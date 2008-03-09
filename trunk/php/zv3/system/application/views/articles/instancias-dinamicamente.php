<ul>
	<li><a href="#intro">Introducci&oacute;n</a></li>
	<li><a href="#solucion">Soluci&oacute;n</a></li>
	<li><a href="#notas">Notas finales</a></li>
	<li><a href="#enlaces">Enlaces</a></li>
</ul>
<a name="intro"></a>
<h2>Introducci&oacute;n</h2>
<p>Lo primero aclarar el concepto &quot;crear instancias de clases din&aacute;micamente&quot;. Con esto me refiero a que, dado el <em>classpath</em> completo de una clase, podamos crear una instancia de ella. Eso es posible porque las clases que compilamos dentro de una pel&iacute;cula Flash se &quot;guardan&quot; dentro del objeto _global siguiendo el classPath. Es decir, las clases de mi dominio se almacenan en _global.tv.zarate.*, Flash crea &quot;f&iacute;sicamente&quot; todos esos objetos. &Eacute;sta es una de las principales razones para NO utilizar variables globales, ya que es relativamente sencillo &quot;pisar&quot; las que se est&aacute;n utilizando para almacenar clases.</p>

<p>Pero a d&iacute;a de hoy es el &uacute;nico camino que tenemos para crear instancias partiendo del nombre de la clase. En AS3 esto ya se hace de una forma oficial (<a href="http://livedocs.macromedia.com/flex/2/langref/flash/utils/package.html#getDefinitionByName()">getDefinitionByName()</a>), pero hasta que puedas utilizar player 9, igual te sirve lo siguiente.</p>

<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="solucion"></a>
<h2>Soluci&oacute;n</h2>
<p>Para facilitar el proceso, he creado una clase con un m&eacute;todo est&aacute;tico al que se le pasa un classpath completo y devuelve un objeto. La pod&eacute;is ver y/o descargar <a href="ClassUtils.as">aqu&iacute;</a>. Tened en cuenta que lo que pretendemos hacer es algo como <span class="asCode">new _global.tv.zarate.test.nombreClase();</span>. Veamos el c&oacute;digo:</p>

<p class="asCode">public static function getInstanceFromClasspath(classPath:String):Object{<br /><br />
		
&nbsp;&nbsp;&nbsp;var constructor:Function;<br />
&nbsp;&nbsp;&nbsp;var classpathBits:Array = classPath.split(".");<br /><br />

&nbsp;&nbsp;&nbsp;constructor = _global[classpathBits[0]];<br />

&nbsp;&nbsp;&nbsp;for(var x:Number=1;x&lt;classpathBits.length;x++){ constructor = constructor[classpathBits[x]]; }<br /><br />

&nbsp;&nbsp;&nbsp;return new constructor();<br /><br />

}</p>

<p>Esto es lo que pasa:</p>
<ol>
	<li>Extraemos del classPath los objetos parti&eacute;ndolo por "."</li>
	<li>Utilizamos el primer objeto del array para &quot;enganchar&quot; con el objeto _global</li>
	<li>Nos metemos en un bucle <strong>empezando desde 1</strong> en el que recursivamente vamos accediendo al siguiente objeto.</li>
	<li>Cuando hemos llegado al final, hacemos el new y lo devolvemos.</li>
</ol>

<p>En este momento, <em>la magia</em> ya ha pasado. Partiendo del classpath, hemos creado din&aacute;micamente un objeto. Lo que pasa es que el tipo de la instancia devuelta es <span class="asCode">Object</span>, as&iacute; que normalmente tendremos que hacer un cast para no cargarnos la validaci&oacute;n a la hora de compilar.</p>

<p>Pero claro, ¿c&oacute;mo haces el cast si precisamente la clase la estamos creando din&aacute;micamente? Es aqu&iacute; donde entran las <em>interfaces</em>. Imag&iacute;nate que est&aacute;s haciendo esto porque tienes una serie de objetos que quieres utilizar indistintamente, dependiendo de lo definido en un xml. Benne. Entonces lo que puedes hacer es crear una interface, hacer que los objetos la implementen y luego hacer el cast con la interface, que siempre es la misma. ¿Que no est&aacute; claro? Pues, resumido, as&iacute;:</p>

<p class="asCode">interface tv.zarate.test.iDynamic{<br />
&nbsp;&nbsp;&nbsp;public function giveMeText():String;<br />
}<br /><br />
class tv.zarate.tv.test.DynamicOne implements iDynamic{}<br />
class tv.zarate.tv.test.DynamicTwo implements iDynamic{}<br /><br />
var dynamicInstance:iDynamic = iDynamic(ClassUtils.getInstanceFromClasspath("tv.zarate.test.DynamicOne"));</p>

<p>No s&oacute;lo consigues crear din&aacute;micamente la instancia de la clase, adem&aacute;s al mismo tiempo est&aacute;s <em>programando para la interface</em>, con lo que tu modelo (o lo que est&eacute; creando la instancia) es independiente de las distintas implementaciones, ya que siempre est&aacute; tratando con la interface. Esto mismo tambi&eacute;n se podr&iacute;a conseguir en lugar de con una interface, haciendo que todas las clases extendieran de una com&uacute;n. ¿Cu&aacute;ndo utilizar una cosa o la otra? Si todos los objetos tienen que hacer una misma tarea (por ejemplo cargar un xml), puedes extender y dejar a la parte com&uacute;n hacer esa tarea, as&iacute; no duplicas c&oacute;digo. En caso contrario, la interface es suficiente.</p>

<p>Si est&aacute; todo muy confuso, b&aacute;jate <a href="dynamicinstances.zip">este zip</a> en el que lo puedes ver claramente. Para compilar desde el IDE, importa la clase <span class="asCode">tv.zarate.test.DynamicInstanceCreation</span> y en la l&iacute;nea de tiempo principal pon algo como: <span class="asCode">DynamicInstanceCreation.main(this)</span>. Para hacerlo con MTASC, s&iacute;mplemente tienes que utilizar -main, &eacute;chale un ojo a <a href="http://www.zarate.tv/articulos/flash_libre_facil/">Flash libre, f&aacute;cil</a>.</p>

<p><strong>¡OJO!</strong> En la clase principal, pod&eacute;is ver un par de variables "extra&#241;as", <span class="asCode">forceOne</span> y <span class="asCode">forceTwo</span>. Est&aacute;n ah&iacute; para forzar al compilador a incluir las clases que queremos utilizar din&aacute;micamente. Si no lo haces, el compilador hace bien su trabajo de no incluir clases en el swf que no est&aacute;n referenciadas en el c&oacute;digo (no se usan). Y aqu&iacute; el avispado lector dir&aacute;, ¿y qu&eacute; pasa si no s&eacute; cu&aacute;ntas clases voy a tener ni c&oacute;mo se van a llamar? Pues entonces lo que hay que hacer es compilar la clases sola en un swf (normalmente usando excludes) y cargarla din&aacute;micamente. Una vez cargada, ya se puede utilizar. Eso lo dejo para el pr&oacute;ximo art&iacute;culo, que sino este sale gigante.</p>

<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="notas"></a>
<h2>Notas finales</h2>
<p>Esto que escribo no es nada nuevo, se lleva haciendo bastante tiempo, pero la verdad es que no es algo que se ve muy a menudo. Y como el otro d&iacute;a me lo preguntaron, pues me pareci&oacute; una buena idea ponerlo a la vista de todo el mundo.</p>
<p>Espero que ayude. ¡Salud!</p>
<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="enlaces"></a>
<h2>Enlaces de inter&eacute;s</h2>
<a href="{$url}" title="Enlace directo a este art&iacute;culo">Enlace directo a este art&iacute;culo</a>
<br />Sugerencias, errores o cualquier duda sobre este articulo en <a href="javascript:noBot('articulos','zarate.tv','{$emailID}')" title="Enviar mail al autor sobre este art&iacute;culo">articulos   [arroba]   zarate.tv</a>
<br />
<a href="../index.php" title="M&aacute;s art&iacute;culos">M&aacute;s art&iacute;culos en Zarate.tv</a>
<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
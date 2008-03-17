<ul>
	<li><a href="<?php echo $article->url; ?>#intro">Introducci&oacute;n</a></li>
    <li><a href="<?php echo $article->url; ?>#instalacion">Instalaci&oacute;n de MTASC y SWFMill</a></li>
    <li><a href="<?php echo $article->url; ?>#empezamos">Empieza lo divertido</a></li>
    <li><a href="<?php echo $article->url; ?>#congracia">Ahora lo mismo pero con gracia</a></li>
    <li><a href="<?php echo $article->url; ?>#toquefinal">El toque final, unir SWFMill y MTASC</a></li>
    <li><a href="<?php echo $article->url; ?>#conclusion">Conclusi&oacute;n</a></li>
    <li><a href="<?php echo $article->url; ?>#enlaces">Enlaces</a></li>
</ul>
<a name="intro"></a>
<h2>Introducci&oacute;n</h2>
<p>Desarrollar Flash con Software Libre no es tan f&aacute;cil como alguno dice ni tan complicado como parece al principio. Muchas letras juntas (FAMES, AMES, MTASC,...) que incluso a veces es dif&iacute;cil recordar qu&eacute; significan.</p>
<p>Para empezar hay que tener claro que lo &uacute;nico que hace falta para generar swfs es un compilador, MTASC. El &quot;problema&quot; es que no puede generar la librer&iacute;a, por lo que necesitaremos SWFMill. SWFMill lo que hace es, partiendo de un xml de definici&oacute;n y de elementos externos (jps, pngs, swfs...), generar un swf.</p>
<p>RECORDAR:
	<ul>
		<li>SWFMill genera swf con librer&iacute;a partiendo de xml y elementos externos.</li>
		<li>MTASC inyecta el c&oacute;digo necesario.</li>
	</ul>
	Pod&eacute;is descargar los archivos de ejemplo <a href="Flash_libre_facil_files.zip">aqu&iacute;</a><br />
	Pod&eacute;is descargar el art&iacute;culo en pdf + los archivos <a href="Flash_libre_facil.zip">aqu&iacute;</a>
</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="instalacion"></a>
<h2>Instalaci&oacute;n de MTASC y SWFMill</h2>
<p>Lo primero que necesitamos son los ejecutables de MTASC y SWFMill, que se bajan de sus respecticvas webs (al final del art&iacute;culo est&aacute;n los enlaces). Una vez descargados los descomprimimos donde nos interese, por ejemplo en &quot;Archivos de programa&quot;. Podemos dejar el nombre con la versi&oacute;n, pero yo normalmente lo dejo como &quot;mtasc&quot; y &quot;swfmill&quot;, m&aacute;s sencillo.</p>
<p>Aunque no es necesario, s&iacute; es recomendable crear variables de sistema con sus respectivas rutas:</p>
<p>Bot&oacute;n derecho sobre &quot;Mi PC&quot; &gt; Propiedades &gt; Opciones Avanzadas &gt; Variables de entorno &gt; Variables del sistema &gt; Nueva</p>
<p>Hay que agregar una para MTASC y otra para SWFMill. Para la de MTASC ponemos en un alarde de originalidad &quot;mtasc&quot; (sin comillas). En el valor hay que poner la ruta al ejecutable que acabamos de descomprimir, en mi caso:
	<ul>
		<li>&quot;C:\Archivos de programa\mtasc\mtasc.exe&quot;</li>
		<li>&quot;C:\Archivos de programa\swfmill\swfmill.exe&quot;</li>
	</ul>
	<strong>&iexcl;Incluyendo las comillas!</strong>, esto es as&iacute; por los espacios en la ruta.
</p>
<p>Para comprobar que hemos hecho esto bien, abrimos una consola de dos (Inicio, Ejecutar, cmd) y escribimos:<br /><br />
	<span class="asCode">%mtasc%</span> (enter)<br /><br />
	Si nos muestra la &quot;ayuda&quot; de MTASC, bien, en caso contrario, mal. A veces es necesario reiniciar la sesi&oacute;n. Lo mismo para SWFMill.
</p>
<p>Esto que cuento es para WinXP que es lo que tengo yo instalado. Para Win2000 ser&aacute; parecido y para Mac y Linux no tengo ni idea, pero seguro que hay algo parecido a las variables de entorno. Si alg&uacute;n usuario caritativo me quiere mandar la explicaci&oacute;n de c&oacute;mo hacerlo o un enlace con una explicaci&oacute;n decente, la a&ntilde;adir&eacute; gustoso.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="empezamos"></a>
<h2>Empieza lo divertido</h2>
<p>Recordemos que en principio basta con MTASC para generar swfs 100% funcionales. Vamos a ello. Hay que recordar que a MTASC lo &uacute;nico que le gusta es AS2, as&iacute; que vamos a hacer una clase sencilla:<br /><br />
	<span class="asCode">class MTASCTest{<br />
	   
	function MTASCTest(){<br />
		_root.createTextField("field",100,0,0,0,0);<br />
		_root.field.autoSize = true;<br />
		_root.field.text = "You rock! \m/";<br />
	}<br />
	<br />
	public static function main():Void{<br />
		var app = new MTASCTest();<br />
	}<br />
}</span>
</p>
<p>Abrimos una consola de DOS si no la tenemos abierta, nos movemos hasta el directorio donde hayamos creado la clase y escribimos esto (se puede copiar y pegar en la consola con el bot&oacute;n derecho):<br /><br />
	<span class="asCode">%mtasc% -swf MTASCTest.swf -main -header 200:200:12 MTASCTest.as</span> (enter)<br /><br />
	¡Ol&eacute;! En el mismo diretorio se ha tenido que crear el archivo MTASCTest.swf que podemos ejecutar para alegria de nuestas mentes. Ahora veamos qu&eacute; hacen los par&aacute;metros que hemos utilizado:
	<ul>
		<li>-swf nombreArchivo.swf. Esta claro, el archivo generado de salida</li>
		<li>-main. Este par&aacute;metro lo que hace es crear un &quot;punto de entrada&quot; a la aplicaci&oacute;n. B&aacute;sicamente lo que hace MTASC es a&ntilde;adir a la l&iacute;nea de tiempo principal algo como:<br/>
		<span class="asCode">MTASCTest.main(this);</span>
		<br />
		Es importante notar que a la funci&oacute;n main se le pasa una referencia de la l&iacute;nea de tiempo principal (this). En el ejemplo anterior no lo hemos utilizado, pero luego ya veremos c&oacute;mo hacerlo.
		</li>
		<li>-header ancho:alto:fps. Dimensiones y velocidad de la pel&iacute;cula</li>
		<li>Archivo_origen.as. La clase por la que tiene que empezar el compilado.</li>
	</ul>
</p>
<p>Es MUY recomendable pasar por la web de MTASC para ver qu&eacute; hacen el resto de par&aacute;metros posibles, que hay unos cuantos.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="congracia"></a>
<h2>Ahora lo mismo pero con gracia</h2>
<p>Ya que tenemos controlado(!) MTASC, vamos a ponerle alegr&iacute;a a la pel&iacute;cula, vamos a utilizar SWFMill. Como ya hemos dicho antes, de lo que se encarga SWFMill es de generar archivos swf a partir de un xml y elementos externos. De esa forma podemos tener una biblioteca de la que importar elementos con attachMovie.<br /><br />
	XML de ejemplo (de la propia web de SWFMill)<br /><br />
	<span class="asCode">&lt;?xml version="1.0" encoding="iso-8859-1" ?&gt;<br />
&lt;movie width="200" height="200" framerate="12"&gt;<br />
  &lt;background color="<?php echo $article->url; ?>#ffffff"/&gt;<br />
  &lt;frame/&gt;<br />
&lt;/movie&gt;</span><br /><br />
Nos vamos a la consola, navegamos hasta el directorio y escribimos:<br /><br />
<span class="asCode">%swfmill% simple library.xml SWFMillTest.swf</span> (enter)<br /><br />
Este comando lo que hace es tomar &quot;library.xml&quot; como definici&oacute;n y crear el archivo &quot;SWFMillTest.swf&quot; como salida con el ancho, alto y velocidad definida. Como esto es poco &uacute;til, vamos a agregarle algo que podamos usar luego:<br /><br />
<span class="asCode">&lt;?xml version="1.0" encoding="iso-8859-1" ?&gt;<br />
&lt;movie width="300" height="200" framerate="12"&gt;<br />
  &lt;background color="<?php echo $article->url; ?>#ffffff"/&gt;<br />
  &lt;frame&gt;<br />
    &lt;library&gt;<br />
      &lt;clip id="paradise" import="items/arecibo-beach.jpg"/&gt;<br />
    &lt;/library&gt;<br />
  &lt;/frame&gt;<br />
&lt;/movie&gt;</span><br /><br />
Con esto lo que hacemos es coger el objeto &quot;items/arecibo-beach.jpg&quot; y crear un objeto en la librer&iacute;a con nombre de exportaci&oacute;n &quot;paradise&quot;, para luego poder hacer un attachMovie que es lo que nos interesa.
</p>
<p>&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;&iexcl;OJO!!!!!!!!!!!!! El jpg se est&aacute; incluyendo en el swf, NO es una carga din&aacute;mica. Esto es lo mismo que crear en el IDE un objeto en la librer&iacute;a e importar un archivo jpg que luego ir&aacute; incluido DENTRO del swf.</p>
<p>Tambi&eacute;n vale y mucho la pena pasarse por la web de SWFMill para un listado completo de lo que se puede y no hacer. Se pueden importar archivos jpg, png, swf, fuentes y alguna cosa m&aacute;s interesante como definir en qu&eacute; frame estar&aacute;n disponibles qu&eacute; elementos.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="toquefinal"></a>
<h2>El toque final, unir SWFMill y MTASC</h2>
<p>Pues lleg&oacute; el momento, tenemos un generador de swfs y un inyector de c&oacute;digo, estamos tardando. Con el mismo xml anterior, modificamos los comandos de MTASC para dejarlo as&iacute;:<br /><br />
	<span class="asCode">%mtasc% -swf Application.swf -main Application.as</span><br /><br />
	Como veis lo primero que hemos hecho es quitar el par&aacute;metro -header, ya que el swf ya est&aacute; creado previamente con SWFMill, ahora lo &uacute;nico que hacemos es inyectar el c&oacute;digo que nos interesa. En este caso un attachMovie de un elemento de la bibliteca. Modificamos la clase para dejarla as&iacute;:<br /><br />
	<span class="asCode">class Application{<br />
	function Application(){}<br />
	public static function main(m:MovieClip):Void{<br />
		m.attachMovie("paradise","paradise",100);<br />
	}<br />
}</span><br /><br />
Voil&aacute;!
</p>
<p>Os dejo una pequeña utilidad para hacernos la vida m&aacute;s f&aacute;cil. Abrimos un archivo de texto y escribimos:<br /><br />
	<span class="asCode">@echo off<br /><br />
echo ** SWFMIll **<br />
%swfmill% simple library.xml Application.swf<br /><br />
echo ** MTASC **<br />
%mtasc% -swf Application.swf -main Application.as</span><br /><br />
Y guardamos el archivo como &quot;compile.bat&quot;. Ahora solo tenemos que ejecutar este archivo (se puede hacer desde las acciones propias de SEPY, por ejemplo) para que el s&oacute;lo ejecute SWFMill y luego MTASC :D
</p>
<p>Lo siento otra vez por los MacPollo y los Linuxeros, pero seguro que tambi&eacute;n se puede hacer algo similar.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="conclusion"></a>
<h2>Conclusi&oacute;n</h2>
<p>La conclusi&oacute;n es que desarrollar Flash con Software Libre es YA una realidad para muchos proyectos, siempre que tu campo no sea la animaci&oacute;n tradicional (cosa que dudo porque no habr&iacute;as ni abierto el link).</p>
<p>Hay que reconocer que no todo va a ser tan sencillo como esto. A d&iacute;a de hoy MTASC puede dar problemas con ciertas cosas como los componentes de Macromedia (bueno, yo dir&iacute;a que son los componentes de MM los que dan problemas con MTASC), pero repito que yo creo que est&aacute; lo suficiente maduro para muchos proyectos.</p>
<p>Tambi&eacute;n hay algunas librer&iacute;as previas a la aparici&oacute;n de MTASC (como las de XPath de XFactorStudio) que no compilan en el modo estricto (-strict), lo cual es una pena, pero yo supongo que poco a poco las ir&aacute;n puliendo.</p>
<p>Bueno gentes, espero que esto ayude un poco a tirar de software libre cuando sea posible. No s&oacute;lo porque sea gratuito Y abierto, sino porque es de CALIDAD.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="enlaces"></a>
<h2>Enlaces</h2>
<ul>
	<li><a href="http://www.mtasc.org">MTASC</a></li>
	<li><a href="http://iterative.org/swfmill/">SWFMill</a></li>
	<li><a href="http://actionscript.com/Article/tabid/54/ArticleID/towards-open-source-flash-development/Default.aspx">Towards Open Source Flash Development</a></li>
	<li><a href="http://actionscript.com/Article/tabid/54/ArticleID/Far-Beyond-Open-Source-Flash-Development/Default.aspx">Far Beyond Open Source Flash Development</a></li>
	<li><a href="http://www.cristalab.com/tutoriales/108/tutorial-de-instalacion-y-uso-de-fames">Tutorial de instalaci&oacute;n y uso de FAMES</a></li>
</ul>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
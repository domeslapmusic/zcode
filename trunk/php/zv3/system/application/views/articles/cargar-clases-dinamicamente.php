<ul>
	<li><a href="#intro">Introducci&oacute;n</a></li>
	<li><a href="#solucion">Soluci&oacute;n</a></li>
	<li><a href="#lonormal">La vida es bella, pero no tanto</a></li>
	<li><a href="#notas">Notas finales</a></li>
	<li><a href="#enlaces">Enlaces</a></li>
</ul>
<a name="intro"></a>
<h2>Introducci&oacute;n</h2>
<p>En el <a href="http://www.zarate.tv/articulos/instancias-dinamicamente/">cap&iacute;tulo anterior</a> nos quedamos un poco con las ganas de no tener que forzar al compilador a incluir las clases de las que cre&aacute;bamos las instancias din&aacute;micamente. Esto es especialmente un problema cuando no se sabe de antemano cu&aacute;ntas clases distintas se van a tener que instanciar. ¿La forma de solucionarlo? Muy sencillo. Con <span class="asCode">loadMovie</span> :)</p>

<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="solucion"></a>
<h2>Soluci&oacute;n</h2>
<p>La idea es muy sencilla, "meter" la(s) clase(s) que queramos en un swf, cargarlo con loadMovie y listo. Es casi tan f&aacute;cil como suena. Vamos a hacerlo por pasos.</p>

<h3>Paso 1. Meter las clases en un swf independiente</h3>
<p><strong>Si utilizas el IDE</strong></p>
<p>La idea es la misma que contaba en el art&iacute;culo anterior, forzar al compilador a meter la clase en el swf. Para ello s&iacute;mplemente imp&oacute;rtala y haz referencia a ella, nada m&aacute;s. Algo como esto en la l&iacute;nea de tiempo principal:</p>
<p class="asCode">import tv.zarate.test.DynamicOne;<br>
var force:DynamicOne;</p>
<p>Y listo. No hay que crear una instancia ni nada. Con eso es suficiente.</p>
<p><strong>Si utilizas MTASC</strong></p>

<p>M&aacute;s sencillo a&uacute;n. Con algo como:</p>
<p class="asCode">mtasc -swf "dynamicone.swf" -header 1:1:24 -version 7 -strict DynamicOne.as</p>
<p>Que se note que *no* utilizamos -main para iniciar la pel&iacute;cula, simplemente creamos un swf y metemos la clase dentro.</p>

<h3>Paso 2. Cargas el swf con la clase.</h3>
<p>Una vez que tienes creado el swf, lo cargas con loadMovie o MovieClip loader y, cuando haya terminado de cargar, ya tienes "disponible" la clase que estaba en ese swf. Puedes utilizar el m&eacute;todo del anterior art&iacute;culo para crear din&aacute;micamente la instancia sin necesidad de forzar la inclusi&oacute;n de las clases en la clase principal. ¡YEAH!</p>

<p>Puedes bajarte el mismo ejemplo del art&iacute;culo anterior de <a href="swf_as_dll.zip">aqu&iacute;</a>.</p>

<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="lonormal"></a>
<h2>La vida es bella, pero no tanto</h2>
<p>Lo normal. Todas las cosas molonas tienen un pero y esta no iba a ser la excepci&oacute;n:</p>
<p><strong>Los excludes</strong>. Este ejercicio es tan f&aacute;cil porque las clases son triviales, pero en la vida real son m&aacute;s complicadas y normalmente hay mucha relaci&oacute;n entre ellas. Si utilizas esta t&eacute;cnica, lo m&aacute;s normal es que tengas un pu&#241;ado de clases comunes que est&aacute;n en el swf principal y que quieras que en el swf cargado <strong>s&oacute;lo</strong> est&eacute; la clase que quieres cargar din&aacute;micamente. Para forzar al compilador a NO incluir ciertas clases, necesitas utilizar los apestodos excludes. Que, como coment&aacute;bamos en <a href="http://www.domestika.org/foros/viewtopic.php?t=50969">este post de Domestika</a>, no funcionan muy bien que digamos. Al final dejo un par de enlaces para utilizarlos, tanto desde el IDE como desde MTASC.</p>
<p><strong>Las variables globales</strong>. Yo y mi cruzada contra las variables globales. A lo mejor tienes suerte y no es tu caso, pero las variables globales de una pel&iacute;cula publicada para player 6 NO se ven en una pel&iacute;cula publicada para player 7. Eso quiere decir que si uno de los swfs es 7 y el otro 6, esto deja de funcionar. *Creo* que esto ya no es as&iacute; para player superior a 7, pero no estoy seguro. Esta t&eacute;cnica funciona sin problemas con el player 9, pero estoy casi seguro de que no se puede mezclar clases AS1/AS2 con AS3. Quien haga la prueba que me mande un mail, <em>please</em>.</p>

<a name="notas"></a>
<h2>Notas finales</h2>
<p>Esta t&eacute;cnica tiene bastantes aplicaciones y funciona bastante bien. <em>S&eacute; de buena tinta</em> que por ejemplo <a href="http://www.elpais3.com">El Pais 3</a> la utiliza intensivamente para ahorrar tiempo de descarga. La mayor&iacute;a de los objetos (tipos de noticia) utilizan clases que son comunes a todo el sitio web, con lo que son excluidas a la hora de crearlos. Las clases comunes simplemente <em>est&aacute;n ah&iacute;</em> cuando la pel&iacute;cula las necesita. Es decir, la parte principal de la aplicaci&oacute;n carga unas clases comunes que son exclu&iacute;das de los objetos secundarios. Un efecto lateral de esto es que, al no estar las clases comunes compiladas en los objetos secundarios, <b>no hace falta recompilar esos objetos para las nuevas versiones de las clases comunes</b>. Esto es al mismo tiempo una ventaja y un inconveniente. Si actualizas una clase y la cagas, cosas que funcionaban dejar&aacute;n de funcionar aunque no las hayas recompilado. Por la misa regla de 3, solucionar un bug com&uacute;n es m&aacute;s sencillo, ya que, una vez solucionado, todos los objetos secundarios utilizar&aacute;n la nueva versi&oacute;n instant&aacute;neamente. Yo en su d&iaacute;a encontr&eacute; partidarios y detractores por igual utilizar esto.</p>
<p>Otro uso bastante mol&oacute;n es por ejemplo para hacer <em>skins</em>. La idea es: tienes una clase que hace de modelo y quieres tener muchas vistas distintas. No s&oacute;lo colores, sino una disposici&oacute;n de los elementos completamente variable. En ese caso lo que puedes hacer es crear un swf principal con el modelo y clases comunes y un swf con elementos de biblioteca y la clase espec&iacute;fica de esa vista. Luego defines en un xml qu&eacute; swf quieres que haga de <em>skin</em>. Funciona de maravilla siempre y cuando todas las vistas tengan algo en com&uacute;n, una interfaces.</p>

<p>Pues esto es m&aacute;s o menos todo. Espero que ayude. ¡Salud!</p>
<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<ul>
	<li><a href="http://www.osflash.org/using_a_swf_as_a_dll">Using a SWF as a DLL</a>. Art&iacute;culo de Aral Balkan en OSFlash sobre el mismo tema: c&oacute;mo cargar clase din&aacute;micamente.</li>
	<li><a href="http://www.darronschall.com/weblog/archives/000145.cfm">Using _exclude.xml, the Good, the Bad, and the Wishlist</a>. Darron Schall hablando de los excludes.</li>
	<li><a href="http://mtasc.org/#usage">C&oacute;mo usar -exclude en MTASC</a>. MTASC no aporta mucho m&aacute;s a la utilizaci&oacute;n de excludes, aunque s&iacute; alguna mejora como poder utilizar varios archivos.</li>
	<li><a href="http://www.domestika.org/foros/viewtopic.php?t=50969">Post en Domestika</a> donde se comenta sobre los excludes.</li>	
</ul>
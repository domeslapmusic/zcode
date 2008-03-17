<ul>
	<li><a href="<?php echo $article->url; ?>#intro">Introducci&oacute;n</a></li>
    <li><a href="<?php echo $article->url; ?>#aprox">Aproximaciones anteriores</a></li>
    <li><a href="<?php echo $article->url; ?>#objetivo">Objetivo</a></li>
    <li><a href="<?php echo $article->url; ?>#solucion">Soluci&oacute;n</a></li>
    <li><a href="<?php echo $article->url; ?>#problemas">Problemas</a></li>
    <li><a href="<?php echo $article->url; ?>#agradecimientos">Agradecimientos</a></li>
    <li><a href="<?php echo $article->url; ?>#enlaces">Enlaces</a></li>
</ul>
<a name="intro"></a>
<h2>Introducci&oacute;n</h2>
<p>El uso de tipograf&iacute;as compartidas en Flash nunca ha sido una tarea f&aacute;cil. Desde hace 3-4 a&ntilde;os se ha intentado resolver por varios caminos, algunos con mejor o peor resultado. Este m&eacute;todo tampoco es perfecto. Estar&iacute;a bien que Macromedia aprovechara la nueva versi&oacute;n de Flash para crear un m&eacute;todo &quot;cient&iacute;fico&quot; que solucionara de una vez por todas este problema.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="aprox"></a>
<h2>Aproximaciones anteriores </h2>
<p>Anteriormente se han intentado b&aacute;sicamente 2 caminos:</p>
<h4>1) Utilizaci&oacute;n &quot;normal&quot; de librer&iacute;as compartidas.</h4>
<p>La utilizaci&oacute;n de las librer&iacute;as compartidas implicaba que la carga de las pel&iacute;culas externas no se hac&iacute;a a trav&eacute;s de <span class="asCode">loadMovie</span>, por lo que el peso de la fuente se cargaba siempre en el primer frame de la pel&iacute;cula, con los consiguientes problemas de precarga. Adem&aacute;s, este sistema no te permite llevar un control (a trav&eacute;s de una clase para la gesti&oacute;n de las fuentes, componente o algo similar) de las fuentes que ya han sido cargadas.</p>
<p>Otro de los inconvenientes de utilizar librer&iacute;as compartidas es que todas las pel&iacute;culas que requieran la fuente har&aacute;n la petici&oacute;n del archivo swf que la contiene, a pesar de que el archivo est&eacute; en la cach&eacute; del navegador (siempre que no estemos en un entorno https o que por cualquier tipo de raz&oacute;n se hayan utilizado cabeceras de no-cache).</p>
<h4>2) Carga din&aacute;mica de pel&iacute;culas con las fuentes.</h4>
<p>La resoluci&oacute;n del problema que m&aacute;s se acercaba a lo que yo quer&iacute;a era la de Ivan Dembicki con su <strong>Shared Font Manager</strong> (SFM). Pero ten&iacute;a una serie de problemas: 1) es de pago, 2) utiliza variables globales para la definici&oacute;n de los objetos TextFormat, 3) utiliza 2 archivos para cada fuente.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="objetivo"></a>
<h2>Objetivo</h2>
<p>Crear un archivo swf por cada una de las tipograf&iacute;as que se vayan a compartir y poder cargarlos din&aacute;micamente a trav&eacute;s de <span class="asCode">loadMovie</span> como si fuera un archivo externo m&aacute;s. La aplicaci&oacute;n del formato de texto a los campos nuevos debe ser luego la m&aacute;s transparente posible, evitando adem&aacute;s objetos <span class="asCode">TextFormat</span> globales.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="solucion"></a>
<h2>Soluci&oacute;n</h2>
<p>Puedes bajarte un <a href="files/Zarate_Shared_Fonts.zip">zip</a> con los fla (MX 2004) de ejemplo. </p>
<h4>a) Creaci&oacute;n de las pel&iacute;culas con las fuentes.</h4>
<p>Crear una &uacute;nica pel&iacute;cula por fuente era una de mis obsesiones, ya que no entend&iacute; nunca por qu&eacute; deber&iacute;a haber 2. Adem&aacute;s cuando hay 2 pel&iacute;culas, la precarga se complica bastante ya que la pel&iacute;cula que se carga NO es la que realmente contiene la fuente. Eso quiere decir que se precargaba una pel&iacute;cula de, por ejemplo, 1kb, cuando la carga real pod&iacute;a ser de 15kb. Cuando s&oacute;lo hay una pel&iacute;cula la precarga, evidentemente, es real.</p>
<p>La soluci&oacute;n a este problema la encontr&eacute; por puro azar y no creo que haya que ense&ntilde;arsela a los ni&ntilde;os en la escuela... simplemente funciona. Para saber por qu&eacute; funciona, lo mejor es preguntar en <a href="http://www.macromedia.com" target="_blank">www.macromedia.com</a> &ntilde;_&ntilde;</p>
<ol>
	<li>Crear una pel&iacute;cula nueva. Normalmente yo utilizo como nombre para el archivo el de la fuente que va a contener. Si el nombre tiene un espacio en blanco, los sustituyo por &quot;_&quot;. Tambi&eacute;n es posible crear una pel&iacute;cula con varias fuentes, lo que puede ser muy &uacute;til para agrupar fuentes por proyectos y cargarla todas de una sola vez.</li>
    <li>Agregar un s&iacute;mbolo de tipograf&iacute;a a la biblioteca. Para agregarlo hay que hacer click en el bot&oacute;n de la parte superior derecha de la biblioteca y seleccionar &quot;New Font&quot;. Seleccionamos de la lista la fuente que deseamos y le damos el nombre que queramos, <strong>es indiferente</strong>. El de la propia fuente es una buena opci&oacute;n, simplemente por temas de organizaci&oacute;n. </li>
    <li>Hacer click con el bot&oacute;n derecho sobre el s&iacute;mbolo creado, seleccionar la opci&oacute;n &quot;Export for runtime sharing&quot; y como url poner la del archivo swf que resulta de compilar la pel&iacute;cula. Es decir, si tenemos el archivo fla &quot;nombre_fuente.fla&quot;, pues habr&iacute;a que poner &quot;nombre_fuente.swf&quot;. </li>
    <li>Crear un MovieClip vac&iacute;o y darle como nombre &quot;ForceShared&quot; (esto es una copia de lo que hac&iacute;a Branden J. Hall). Arrastralo al escenario. Abrir la biblioteca, hacer click con el bot&oacute;n derecho sobre el y seleccionar &quot;Import for runtime sharing&quot;. En la URL escribir la url que hemos definido en el paso anterior. <strong>IMPORTANTE: SI EL ARCHIVO DE LA FUENTE Y LA PEL&Iacute;CULA QUE LO VA A CARGAR NO EST&Aacute;N EN LA MISMA CARPETA, HAY DEFINIR ESTA RUTA RELATIVA A LA PEL&Iacute;CULA QUE LA VA A CARGAR</strong>.Ver ejemplo en el fla de los archivos que est&aacute; en &quot;DistintaCarpeta&quot;.</li>
    <li>Compilar. Si la ruta de exportaci&oacute;n e importaci&oacute;n no es la misma, se producir&aacute; un error de carga ya que no podr&aacute; cargar la ruta de importaci&oacute;n. No pasa nada.</li>
</ol>
<h4>b) Utilizaci&oacute;n de las fuentes.</h4>
<ol>
	<li>Cargar din&aacute;micamente con <span class="asCode">loadMovie</span> la pel&iacute;cula de la fuente.</li>
    <li>Crear un objeto <span class="asCode">TextFormat</span> y un campo de texto din&aacute;micos como si la fuente estuviera en la biblioteca.Es decir, si la fuente que queremos cargar es &quot;Quadaptor&quot;, tendremos que definir la propiedad font del <span class="asCode">TextFormat</span> as&iacute;: <span class="asCode">myFomat.font=&quot;Quadaptor&quot;</span>. El campo de texto tiene que incluir las fuentes con <span class="asCode">myField.embedFonts=true</span>. </li>
    <li>Enjoy :)</li>
</ol>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="problemas"></a>
<h2>Problemas</h2>
<p>De la misma forma que cualquiera de los otros m&eacute;todos, &eacute;ste que acabo de presentar tambi&eacute;n tiene incovenientes. Supongo que la elecci&oacute;n de un m&eacute;todo u otro depender&aacute; de las necesidades de cada proyecto. Estos son los que yo he encontrado, si v&eacute;is cualquier otro, por favor mandadme un mail a <a href="javascript:noBot('articulos','zarate.tv','{$emailID}')" title="Enviar mail al autor sobre este art&iacute;culo">articulos   [arroba]   zarate.tv</a> para que lo pueda actualizar.</p>
<ul>
	<li><strong>No puede haber en la pel&iacute;cula campos de texto creados desde el IDE (ni siquiera est&aacute;ticos) con la misma fuente que la que se va a cargar</strong>. Esto es tan sencillo como que si hay un campo de texto con la misma fuente que la que se ha cargado din&aacute;micamente, los campos de texto a los que le apliquemos el <span class="asCode">TextFormat</span> de la fuente din&aacute;mica dejar&aacute;n de verse correctamente. La forma m&aacute;s sencilla de solucionar esto es crear con <span class="asCode">createTextField</span> TODOS los campos de texto que utilicen la fuente din&aacute;mica. Esto NO AFECTA A LAS PEL&Iacute;CULAS QUE LA PEL&Iacute;CULA PRINCIPAL HAYA CARGADO DIN&Aacute;MICAMENTE. Ver archivo fla de Errores/TextoEstatico para demostraci&oacute;n.</li>
    <li><strong>No es posible utilizar fuentes en cursiva o en negrita</strong>. No he conseguido utilizar una fuente en cursiva o negrita y no he encontrado otra forma de solucionarlo. Ver archivo fla de Errores/Cursiva para demostraci&oacute;n.</li>
    <li><strong>Los campos de texto tienen que tener la fuente incluida</strong> (campo.embedFonts = true), por lo que la fuente SIEMPRE estar&aacute; suavizada.</li>
    <li><strong>Problemas al hacer la precarga con la clase MovieClipLoader</strong>. Utilizando la clase <span class="asCode">MovieClipLoader</span> para la carga del archivo de la fuente, me he dado cuenta de que el evento onLoadInit se dispara ANTES de que la fuente est&eacute; lista para usarse. T&eacute;cnicamente yo creo que esto no deber&iacute;a ser as&iacute; ya que la referencia pone claramente que este evento es llamado despu&eacute;s de que las acciones del primer frame de la pel&iacute;cula se hayan ejecutado. En nuestro caso, no funciona as&iacute; ya que se ejecuta primero el onLoadInit y luego los frames de la pel&iacute;cula cargada. En algunos casos el orden ha sido MovieClip, onLoadInit, Linea principal, lo que es a&uacute;n m&aacute;s raro.&iquest;Por qu&eacute; sucede esto? Pues realmente no lo s&eacute;, pero supongo que ser&aacute; un &quot;efecto colateral&quot; de utilizar el mismo swf para la exportaci&oacute;n y la importaci&oacute;n. Si alguien puede aclararnos esto un poco, ser&aacute; de gran ayuda. La &uacute;nica forma que he encontrado para solucionarlo es: 1) esperar un frame o 2) crear un intervalo. Ver archivos fla de Errores/CargaMovieClipLoader y Errores/Trace para demostraci&oacute;n. [Como se puede apreciar en la pel&iacute;cula de Errores/Trace, hay otro m&eacute;todo de conseguir las fuentes din&aacute;micas y consiste en sustituir el s&iacute;mbolo de fuente de la biblioteca por un MovieClip con un campo de texto con los caracteres incluidos. Esto puede ser especialmente &uacute;til cuando no se quiere incluir toda la fuente sino s&oacute;lo unos caracteres, por ejemplos, s&oacute;lo los n&uacute;meros de un preload]</li>
    <li><strong>Incompatibilidades de Player</strong>. Yo he probado con &eacute;xito el m&eacute;todo en players 7 de Windows, Mac y Linux y player 6,0,79 de Windows. Habr&iacute;a que hacer una prueba intensiva porque es probable que de problemas en players anteriores. </li>
</ul>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="agradecimientos"></a>
<h2>Agradecimientos</h2>
<p>Lo primero agradecer a todas las personas que han intentado esto antes, ya que sus trabajos han sido las bases de &eacute;ste. Tambi&eacute;n a <strong>Oscar P&eacute;rez</strong> y <strong>Gustavo Ramos</strong> por su labor de investigaci&oacute;n y consejos cuando ya estaba completamente desesperado :D</p>
<p>Agradecer&iacute;a un voluntario/a que traduzca el art&iacute;culo a ingl&eacute;s, ya que si lo hago yo seguro que el que lo lea no saca mucho beneficio :) </p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="enlaces"></a>
<h2>Enlaces</h2>
<ul>
	<li><a href="http://www.sharedfonts.com/" target="_blank">Shared fonts manager</a></li>
    <li><a href="http://web.archive.org/web/20021206180401/http://www.waxpraxis.org/archives/000062.html" target="_blank">WaxPraxis - Shared Fonts Redux (Wayback Machine)</a></li>
    <li><a href="http://www.quasimondo.com/archives/000227.php" target="_blank">Quasimondo - Shared Library Secrets</a></li>
    <li><a href="http://www.macromedia.com/cfusion/knowledgebase/index.cfm?id=tn_14786" target="_blank">Macromedia Flash TechNote: Using font symbols</a></li>
    <li><a href="http://www.macromedia.com/cfusion/knowledgebase/index.cfm?id=tn_14767" target="_blank">Macromedia Flash TechNote: Using shared libraries</a></li>
</ul>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
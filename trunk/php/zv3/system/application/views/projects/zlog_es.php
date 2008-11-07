<span class="version">versi&oacute;n 1.1</span>
<div id="menu">
	<ul>
		<li><a href="<?php echo $project->url; ?>#intro">Introducci&oacute;n</a></li>
		<li><a href="<?php echo $project->url; ?>#usage">Formas de uso</a></li>
		<li><a href="<?php echo $project->url; ?>#demo">Demo</a></li>
		<li><a href="<?php echo $project->url; ?>#download">Descarga</a></li>
		<li><a href="<?php echo $project->url; ?>#changelog">Change log</a></li>
		<li><a href="projects/zlog/">Switch to english</a></li>
	</ul>
</div>

<a name="intro"></a>
<h2>Introducci&oacute;n</h2>

<p><strong>ZLog</strong> ("zetalog") es un sencillo sistema de log para Flash 100% compatible con <a href="http://www.mtasc.org">MTASC</a> y el IDE. <strong>ZLog</strong> consta de 2 partes:</p>
<ul>
	<li><strong>La consola</strong>. Es una una p&aacute;gina HTML en la que se van mostrando las trazas. La p&aacute;gina incluye un objeto Flash que es el que se encarga de recibir las trazas enviadas por las aplicaciones.</li>
	<li><strong>Una clase o conector con la consola</strong>. Esta clase lo &uacute;nico que hace es crear un objecto LocalConnection que envia la cadena a la consola de log. Esta clase es incluida en tu pel&iacute;cula.</li>
</ul>
<p>Las principales caracter&iacute;sticas son:</p>
<ul>
	<li>Ultra ligero. Solo hay que incluir la clase est&aacute;tica que conecta con la consola y listo.</li>
	<li>Se pueden a&ntilde;adir nuevos tipos de trazas sin necesidad de recompilar nada. Por cada traza se genera una etiqueta &lt;p class=&quot;type&quot;&gt; donde type es el segundo par&aacute;metro pasado a la funci&oacute;n trace. As&iacute; que para hacer un nuevo tipo de traza s&oacute;lo hay que modificar la css de la consola.</li>
	<li>Atajos de teclado de la consola:
		<ul>
			<li>r: reinicia el log.</li>
			<li>p: pausa/contin&uacute;a el log.</li>
			<li>a: agregar l&iacute;nea en blanco.</li>
		</ul>
	</li>
	<li>Se puede pasar como tercer par&aacute;metro de la funci&oacute;n trace un valor boleano (true/false) que reiniciar&aacute; el log, por lo que se borrar&aacute;n todas las trazas anteriores. Muy &uacute;til cuando hay millones de trazas en el log.</li>
</ul>
<p><a href="http://www.google.co.uk/search?q=flash+log&start=0&ie=utf-8&oe=utf-8&client=firefox-a&rls=org.mozilla:en-US:official">Como muchos otros sistemas de log para Flash</a>, <strong>ZLog</strong> se basa en el objeto <a href="http://livedocs.macromedia.com/flash/mx2004/main_7_2/wwhelp/wwhimpl/common/html/wwhelp.htm?context=Flash_MX_2004&file=00001421.html#wp3995201">Local Connection</a> de Flash, por lo que trazar&aacute; cualquier cosa que le llegue a trav&eacute;s de la conexi&oacute;n que establece la consola (m&eacute;todo "log", conexi&oacute;n "_ZLog"). De esa forma es muy sencillo realizar las trazas tanto desde MTASC como desde el IDE.</p>

<a name="usage"></a>
<h2>Formas de uso</h2>
<h3>Desde MTASC</h3>
<p>Para utilizar <strong>ZLog</strong> desde MTASC simplemente tienes que a&ntilde;adir a tu comando de compilaci&oacute;n -trace tv.zarate.Utils.Trace.trc. De esa forma MTASC sustituir&aacute; todas las llamadas trace(&quot;Hello world&quot;) por tv.zarate.Utils.Trace.trc(&quot;Hello world&quot;). Para saber un poco m&aacute;s sobre c&oacute;mo MTASC trabaja con trace, &eacute;chale un ojo a su <a href="http://www.mtasc.org/#trace">referencia</a>.</p>
<h3>Desde el IDE de Flash, o AS2 compilado con el IDE.</h3>
<p>Si a pesar de que <a href="http://www.zarate.tv/articulos/flash_libre_facil/">trabajar con MTASC es muy f&aacute;cil</a> a&uacute;n sigues con el IDE, puedes tambi&eacute;n utilizar <strong>ZLog</strong>. Simplemente tendr&aacute;s que sustituir tus trace() por Trace.trc(), en este caso no tienes un compilador que preprocese el c&oacute;digo para sustituir las llamadas autom&aacute;ticamente.</p>
<h4>Par&aacute;metros opcionales de la clase (tanto MTASC como IDE)</h4>
<p>Si queremos definir un tipo de traza simplemente hay que pasarlo como segundo par&aacute;metro: trace(&quot;Hello world&quot;,&quot;fatal&quot;). Ese segundo par&aacute;metro se debe corresponder con una clase definda en la css de la consola.</p>
<p>Se puede reiniciar la consola pasando true como tercer par&aacute;metro. trace(&quot;Hello world&quot;,&quot;&quot;,true).</p>

<a name="demo"></a>
<h2>Demo</h2>
<p>Para ver <strong>ZLog</strong> en funcionamiento puedes abrir la consola <a href="<?php echo base_url(); ?>assets/projects/zlog/ZLog.html" onClick="javascript:window.open('<?php echo base_url(); ?>assets/projects/zlog/ZLog.html','ZLog','width=500,height=400,resizable=yes'); return false;">aqu&iacute;</a>, y luego pinchar sobre cualquiera de los botones que tienes debajo.</p>
	
	<div id="container"></div>
	
	<script type="text/javascript">
		// <![CDATA[
			
			var so = new SWFObject("<?php echo base_url(); ?>assets/projects/zlog/elements/test.swf","zlog","500","40","8","#ffffff");
			so.write("container");
			
		// ]]>
	</script>

	
<a name="download"></a>
<h2>Descarga</h2>
<p>Todo el c&oacute;digo de <strong>ZLog</strong> es abierto y te lo puedes bajar de aqu&iacute;:</p>
<ul>
	<li><a href="<?php echo base_url(); ?>assets/projects/zlog/files/ZLog.air">ZLog AIR</a>. Para usar ZLog como una aplicaci&oacute;n fuera del navegador. Necesita <a href="http://get.adobe.com/air/">AIR 1.1 runtime</a>.</li>
	<li><a href="<?php echo base_url(); ?>assets/projects/zlog/files/zlog_v_1_1_simple.zip">Paquete b&aacute;sico</a>. La consola compilada y la clase conectora.</li>
	<li><a href="<?php echo base_url(); ?>assets/projects/zlog/files/zlog_v_1_1_complete.zip">Paquete friki</a>. El c&oacute;digo de la consola con instrucciones para compilar y la clase conectora.</li>
</ul>

<a name="changelog"></a>
<h2>ChangeLog</h2>
<dl>
	<dt>Versi&oacute;n 1.1 - 10 junio 2007</dt>
	<dd>
		<ul>
			<li>La consola pasa de Flash a HTML.</li>
			<li>Mejorada la traza de objetos XML. Para trazar un objeto XML hay que pasarlo &quot;s&oacute;lo&quot;:
				<ul>
					<li>trace(myXML); // bien</li>
					<li>trace("This is my XML &gt; " + myXML); // mal</li>
				</ul>
			</li>
			<li>A&ntilde;adido "a" como atajo para agregar una l&iacute;nea en blanco a la consola.</li>
			<li>La versi&oacute;n m&iacute;nima de player requerida para ver la consola es 8 debido al uso de ExternalInterface para la comunicaci&oacute;n Flash -&gt; JavaScript.</li>
			<li>tv.zarate.Utils.Trace se ha actualizado para permitir el paso de objetos a la consola (necesario para poder trazar objetos XML).</li>
			<li>Ahora se comprueba si la el objeto LocalConnection de la consola se crea correctamente y se muestra error en caso contrario.</li>
		</ul>
	</dd>
	<dt>Versi&oacute;n 1.0 - 25 marzo 2006</dt>
	<dd>Versi&oacute;n inicial.</dd>
</dl>

<a name="licencia"></a>
<h2>Licencia</h2>
<p>El uso de <strong>ZLog</strong> <strong>corre enteramente a tu riesgo</strong>, yo lo uso a diario y no tengo mayores problemas. El c&oacute;digo est&aacute; licenciado bajo Creative Commons, puedes verlo, modificarlo y utilizarlo si lo crees conveniente, incluso en proyectos comerciales. Si tienes dudas, quieres ver algo nuevo en <strong>ZLog</strong> o encuentras un bug, m&aacute;ndame un mail a <a href="javascript:noBot('zlog','zarate.tv');">zlog [*] zarate . tv</a>.</p>
<p><strong>HTH :D</strong></p>
<p><a href="http://www.zarate.tv">Z&aacute;rate</a></p>
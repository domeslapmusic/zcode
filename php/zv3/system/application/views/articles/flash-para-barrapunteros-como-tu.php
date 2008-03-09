<p><strong>ACTUALIZACI&Oacute;N:</strong> Finalmente este art&iacute;culo pas&oacute; a <a href="http://barrapunto.com/article.pl?sid=07/10/29/1255222">portada de Barrapunto</a> el 29 de Octubre. Interesante echarle un ojo a los comentarios.</p>

<ul id="toc">
	<li><a href="#intro">Introducci&oacute;n</a></li>
	<li><a href="#programar">&iquest;Pero en Flash se programa?</a></li>
	<li><a href="#flashos">Flash &iquest;vs? Software Libre</a></li>
		<ul>
			<li><a href="#formatoswf">El formato swf</a></li>
			<li><a href="#desarrollo">Desarrollar Flash con Software Libre</a></li>
			<li><a href="#tamarin">Tamarin</a></li>
			<li><a href="#flex2sdk">Flex 2 SDK</a></li>
			<li><a href="#gnash">GNash</a></li>
		</ul>
	<li><a href="#accesibilidad">Flash y accesibilidad</a></li>
	<li><a href="#seo">Flash y buscadores</a></li>
	<li><a href="#multi">Flash es multiplataforma. O eso dicen</a></li>
	<li><a href="#aplicaciones">Aplicaciones que molan y proyectos curiosos</a></li>
		<ul>
			<li><a href="#papervision">Papervision3D</a></li>
			<li><a href="#red5">Red5</a></li>
			<li><a href="#hydra">Hydra</a></li>
			<li><a href="#alivepdf">AlivePDF</a></li>
			<li><a href="#flashvnc">FlashVNC</a></li>
			<li><a href="#swhx">ScreenweaverHX</a></li>
			<li><a href="#fc64">FC64</a></li>
		</ul>
</ul>

<a name="intro"></a>
<h2>Introducci&oacute;n</h2>
<p>A ra&iacute;z de <a href="http://barrapunto.com/article.pl?sid=07/09/05/102239">este art&iacute;culo</a> de Barrapunto me he dado cuenta de que todav&iacute;a hay mucha gente anclada en la idea de que Flash s&oacute;lo sirve para hacer dibujitos y letras que vuelan. Bueno, <i>tambi&eacute;n</i> sirve para eso.</p>

<p>Para que todo el mundo se sit&uacute;e, declaro lo siguiente alto y claro:</p>

<ul>
	<li>Yo soy Flashero. Trabajo desde hace 5 a&ntilde;os como programador Flash. S&iacute;, he puesto programador y Flash en la misma frase.</li>
	<li>Mi visi&oacute;n de Adobe es 50%-50% amor/odio. Creo que como empresa que son tienen todo el derecho a hacer lo que les parezca con su tecnolog&iacute;a y tienen todo mi respeto por llevar a Flash a lo que es hoy en d&iacute;a. Dicho esto, por ejemplo muchas veces tienen una pol&iacute;tica poco clara sobre algunas aplicaciones libres del mundilo Flash, lo cual me molesta bastante.</li>
	<li>Llevo alg&uacute;n tiempo en Barrapunto aunque antes me dedicaba simplemente a lurkear. La frase "Barrapunto ya no es lo que era" me hace gracia porque como yo llegu&eacute; tarde a la fiesta, para mi siempre ha sido lo que es ahora. Es decir, un sitio de noticias (algunas me interesan, otras no) con una mezcla de gente que sabe mucho, junto con una panda de trolls con mucho tiempo libre. El t&iacute;tulo del art&iacute;culo viene a que tradicionalmente el usuario medio de Barrapunto "odia" Flash, sus intros, el software privativo y (parece) que no se informa sobre la realidad de Flash &uacute;ltimamente. Espero que me sepan perdonar la gracieta cari&ntilde;osa del t&iacute;tulo.</li>
</ul>

<p>La idea es proporcionar una visi&oacute;n general actual sobre lo que es el desarrollo de aplicaciones Flash hoy en d&iacute;a (Octubre 2007) para que quien quiera trollear lo haga con conocimiento de causa. No es lo mismo decir:</p>

<blockquote>"Flash es s&oacute;lo para hacer dibujitos que vuelan" // esto suena a "webmaster" y &lt;marquee&gt;</blockquote>
<p>que</p>
<blockquote>"Adobe es el diablo por intentar sabotear proyectos como Red5" // mucho m&aacute;s 2.0!</blockquote>
<p>Que quede claro que mi intenci&oacute;n con este art&iacute;culo es hacer una visi&oacute;n m&aacute;s o menos r&aacute;pida de los t&oacute;picos m&aacute;s habituales en el desarrollo Flash. Como no soy un experto en todos estos campos, <b>seguramente haya errores o puntualizaciones que gustosamente corregir&eacute; si alguien me los indica</b> (cuentame arroba zarate tv o directamente en <a href="http://www.dandolachapa.com/2007/10/17/flash-para-barrapunteros-como-tu/">el blog</a>). Al final hay enlaces para ampliar informaci&oacute;n.</p>

<h3>Flash es s&oacute;lo una herramienta</h3>

<p>Algo que mucho friki parece olvidar selectivamente es que Flash es s&oacute;lo una herramienta. Como con todas las tecnolog&iacute;as hay gente que la usa muy bien y gente que la usa muy mal.</p>
<p>Yo personalmente tambi&eacute;n odio las intros, los "efectos libro" y <a href="http://www.dandolachapa.com/2006/10/05/no-me-gusta-tu-musica/">el que una web tenga m&uacute;sica y me obligue a quitar la m&iacute;a cuando navego</a>. Yo sufro no s&oacute;lo a clientes que me obligan a programar estas y otras fechor&iacute;as sino que luego sufro tambi&eacute;n esas webs cuando navego y a los millones de barrapunteros se&ntilde;al&aacute;ndome con el dedo como si yo hubiera programado todas las intros del mundo.</p>


<a name="programar"></a>
<h2>&iquest;Pero en Flash se programa?</h2>

<p>La salida de ActionScript 2 supuso un salto de calidad brutal en cuanto a metodolog&iacute;a de programaci&oacute;n. ActionScript 2 es un lenguaje de programaci&oacute;n orientado a objetos basado en ECMAScript.</p>

<p>Sin embargo programar en AS2 requiere ciertos <em>hacks poco elegantes</em> para tareas concretas. Esto es porque AS2 y AS1 son compilados al mismo <em>bytecode</em> que es el que interpreta la ActionScript Virtual Machine 1 (ASVM1).</p>

<p>AS3 sin embargo se compila a un bytecode completamente nuevo que es el que interpreta la AVM2 (lanzada con el player 9). En AS3 se ha cambiado y mucho la estructura interna del lenguaje para hacerlo completamente estricto con ECMAScript de tercera generaci&oacute;n (<a href="http://www.ecma-international.org/publications/standards/Ecma-262.htm">ECMA-262</a>).</p>

<p>El arsenal de herramientas de un flashero a d&iacute;a de hoy no dista mucho del de un programador Java o C. Compiladores por l&iacute;nea de comandos, herramientas de control de versiones, plugins de Eclipse, consolas de log y debug, descompiladores, libros de programaci&oacute;n orientada a objetos... lo normal.</p>


<a name="flashos"></a>
<h2>Flash &iquest;vs? Software Libre</h2>

<p>Como he dicho antes, la pol&iacute;tica de Adobe sobre algunas de las aplicaciones libres es cuando menos ambigua. La norma general es un sospechoso silencio sobre por ejemplo Red5 (clon libre de Flash Media Server) o la antigua versi&oacute;n de Screenweaver que permit&iacute;a incluir el ocx de Flash en un ejecutable.</p>

<p>Adobe por ahora sigue la norma de vive y deja vivir, aunque tambi&eacute; ha hecho movimientos muy torpes como <a href="http://blog.deconcept.com/2006/04/21/flashobject-to-become-swfobject/">obligar al proyecto FlashObject a rebautizarse como SWFObject</a> porque no pod&iacute;a utilizar su marca registrada "Flash". Cargar contra tus propios desarrolladores y evangelistas MAL Adobe.</p>

<a name="formatoswf"></a>
<h3>El formato swf</h3>

<p>El formato swf es p&uacute;blico pero pertenece a Adobe. Se pueden <a href="http://www.adobe.com/licensing/developer/">solicitar las especificaciones</a> pero el leerlas te incapacita para crear un reproductor de swfs:</p>

<blockquote>This license grants the Licensee access to the SWF file format specification to aid in the creation of software which creates SWF files.<br><br>This license does not permit the usage of the specification to create software which supports SWF file playback.</blockquote>

<p>Es decir, si lees las especificaciones y aceptas la licencia legalmente, NO puedes crear un reproductor de archivos swf como GNash (ver abajo). Lo que s&iacute; puedes es crear una herramienta generadora de swfs. &iquest;Significa esto que Gnash es ilegal? NO. Significa que los programadores de GNash no pueden echar un ojo a la especificaci&oacute;n.</p>

<a name="desarrollo"></a>
<h3>Desarrollar Flash con Software Libre</h3>

<p><a href="http://mtasc.org">MTASC</a> es un compilador de ActionScript 2 (player 6,7,8) totalmente abierto. Es multiplataforma  y funciona mucho, mucho mejor que el compilador oficial del Flash IDE 8. Pero MTASC no puede s&oacute;lo con toda la faena, as&iacute; que para eso naci&oacute; <a href="http://swfmill.org/">SWFMill</a>. &iquest;Se puede hacer con el d&uacute;o MTASC + SWFMill lo mismo que con el IDE oficial? NO.</p>

<p>Si necesitas hacer animaci&oacute;n tradicional por frames, entonces necesitas el IDE (o alguna de las otras herramientas para generar swfs como <a href="http://www.toonboom.com/">Toon Boom</a> o <a href="http://www.erain.com/products/swift3d/">Swift 3D</a>). Ahora, a d&iacute;a de hoy Flash es mucho m&aacute;s que animaci&oacute;n tradicional. Sin tocar el IDE de Flash y utilizando herramientas libres sobre Linux se pueden programar aplicaciones Flash para la gesti&oacute;n de usuarios, chats, herramientas de videoconferencia, etc, etc.</p>

<p>Para desarrollar ActionScript 3 (player 9) puedes bajarte el <a href="http://www.adobe.com/products/flex/sdk/">SDK de Flex 2</a> que es multiplataforma pero que a&uacute;n no ha sido liberado (m&aacute;s informaci&oacute;n <a href="http://labs.adobe.com/wiki/index.php/Flex:Open_Source">aqu&iacute;</a>) o usar <a href="http://haxe.org">haXe</a>. haXe es un lenguaje de programaci&oacute;n web similar a ActionScript 2 que compila a Flash (6,7,8 y 9), JavaScript y Neko bytecode. Neko es una m&aacute;quina virtual que funciona en el servidor como m&oacute;dulo de Apache. Es decir, que con el mismo lenguaje (haXe) puedes compilar para cliente, servidor y aplicaciones de escritorio (ScreenweaverHX, ver m&aacute;s abajo).</p>

<a name="tamarin"></a>
<h3>Tamarin</h3>

<p>Como he dicho antes, la introducci&oacute;n de la AVM2 y AS3 ha llevado al player de Flash a dar el salto de calidad que le faltaba. La AVM2 utiliza JIT (<a href="http://en.wikipedia.org/wiki/Just-in-time_compilation">Just In Time compilation</a>) lo que ha supuesto una mejora brutal del rendimiento.</p>

<p>Pero resulta que la AVM2 no es s&oacute;lo la m&aacute;quina virtual para AS3, sino que es una m&aacute;quina virtual para lenguajes ECMAScript. Tanto es as&iacute; que Mozilla ha decidido sustituir su motor de JavaScript por la AVM2 en lo que se conoce como el proyecto Tamarin. Adobe liber&oacute; una parte de la AVM2 bajo la MPL en una de las mayores donaciones de c&oacute;digo a la Mozilla Foundation.</p>

<a name="flex2sdk"></a>
<h3>Flex 2 SDK</h3>

<p>Seguramente ayudados por la presi&oacute;n de MTASC y haXe, Adobe decici&oacute; liberar el SDK de Flex 2. Flex es un framework de componentes para el desarrollo de aplicaciones Flash <b>ya que el resultado final de Flex es igualmente un archivo swf</b>, s&oacute;lo que en lugar del IDE de Flash + ActionScript se utiliza MXML (Macromedia XML, lenguaje de marcado) y AS3. Pero repito, el resultado final es el mismo.</p>

<p>Junto con la liberaci&oacute;n de Flex, Adobe tambi&eacute;n est&aacute; empezando a abrir poco a poco <a href="http://bugs.adobe.com/">su sistema de gesti&oacute;n de bugs</a> al estilo Bugzilla.</p>

<a name="gnash"></a>
<h3>GNash</h3>

<p><a href="http://www.gnu.org/software/gnash/">GNash</a> es el reproductor de swfs de la Free Software Foundation. A d&iacute;a de hoy la compatibilidad es bastante limitada ya que s&oacute;lo reproduce pel&iacute;culas de player 7 y algunas de player 8. Aun as&iacute;, ser&aacute; incluido por defecto en la pr&oacute;xima versi&oacute;n de Ubuntu y otras distribuciones.</p>

<p>Aunque no est&aacute; preparado para sustituir con garant&iacute;as al player oficial, el proyecto es bastante interesante. La mayor&iacute;a de detractores de Flash argumentan que es una herramienta propietaria. Tener un player libre abre aun m&aacute;s las puertas de Flash all&iacute; donde por razones (normalmente econ&oacute;micas) a Adobe no le interesa invertir tiempo de desarrollo. Por ejemplo, sistemas de 64 bits o dispositivos fuera de los oficialmente soportados.</p>

<p>Tambi&eacute;n podr&iacute;a redistribuirse sin necesitar el permiso de Adobe, lo cual facilitar&iacute;a la labor de programas como ScreenweaverHX y otros wrappers de aplicaciones Flash. Eso evitar&iacute;a la obligaci&oacute;n de que el usuario final tenga la correcta versi&oacute;n de Flash instalada. Sobre si es legal redistribuir el player de Flash sin el consentimiento oficial de Adobe, hay una interesante discusi&oacute;n <a href="http://osflash.org/pipermail/osflash_osflash.org/2005-October/004591.html">aqu&iacute;</a> y <a href="http://osflash.org/pipermail/osflash_osflash.org/2005-October/004633.html">aqu&iacute;</a>. Mi visi&oacute;n es que NO es legal, pero Adobe nunca ha actuado en contra de esos proyectos. Mantiene silencio e insin&uacute;a acciones, pero no hace nada. Claramente <a href="http://en.wikipedia.org/wiki/Fear%2C_uncertainty_and_doubt">FUD</a> para mi.</p>

<p class="subir"><a href="#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="accesibilidad"></a>
<h2>Flash y accesibilidad</h2>

<p>La accesibilidad es uno de los puntos flojos de Flash, eso no hay quien lo dude. La comunicaci&oacute;n con lectores de pantalla es nula o complicada y Flash tampoco responde por defecto a las preferencias de accesibilidad que el usuario ha establecido en su navegador.</p>

<p>Dicho esto, la <a href="http://labs.adobe.com/technologies/flashplayer9/releasenotes.html">&uacute;ltima actualizaci&oacute;n del player de Flash</a> parece que incluye soporte para Microsoft Active Accessibility (<a href="http://en.wikipedia.org/wiki/Microsoft_Active_Accessibility">MSAA</a>) no s&oacute;lo para el ActiveX (IE) sino tambi&eacute;n para los plug-ins (Firefox y compa&ntilde;&iacute;a). Hay una <a href="http://osdir.com/ml/mozilla.accessibility/2006-11/msg00001.html">interesante discusi&oacute;n</a> en la lista de accesibilidad de Mozilla, especialmente <a href="http://osdir.com/ml/mozilla.accessibility/2006-11/msg00019.html">este post</a>.</p>

<p>Un problema bastante grave que esperemos que Adobe junto con los fabricantes de navegadores se digne a solucionar se llama <a href="http://livedocs.adobe.com/flash/9.0/UsingFlash/WSd60f23110762d6b883b18f10cb1fe1af6-7ba7.html">SeamlessTabbing</a>. Este par&aacute;metro se define en el c&oacute;digo HTML usado para incluir un objeto Flash en una p&aacute;gina y, en teor&iacute;a, permite que una aplicaci&oacute;n Flash entre sin problemas en el ciclo de tabulaciones de una p&aacute;gina HTML. Es decir, desdepu&eacute;s de hacer tab en el objeto HTML precedente a Flash, el navegador da el foco a la pel&iacute;cula Flash que inicia su propio ciclo de tabs y, al llegar al &uacute;ltimo elemento, "salta" de nuevo al elemento HTML inmediatamente posterior. Esto funciona a d&iacute;a de hoy, pero s&oacute;lo en Internet Explorer. </p>

<p>Una vez que el objeto Flash tiene el foco, es posible programar aplicaciones accesibles s&oacute;lo con el teclado, lo cual puede no parecer mucho pero por lo menos es algo.</p>

<p>Resumen: hagamos lo poco que se puede hacer para mejorar la accesibilidad de nuestras aplicaciones Flash.</p>

<a name="seo"></a>
<h2>Flash y buscadores</h2>

<p>Por qu&eacute; Google no hace m&aacute;s para buscar informaci&oacute;n dentro de archivos swf no lo tengo claro. Seguramente sea una mezcla de "pol&iacute;tica" a&ntilde;adido a que el formato swf no es un estandar. Lo que s&iacute; tengo claro es que la mayor&iacute;a de aplicaciones Flash a d&iacute;a de hoy est&aacute;n "vac&iacute;as de contenido", es decir, obtienen sus datos de forma din&aacute;mica (xmls, bases de datos etc), as&iacute; que seguramente leer "dentro" de ellas no supusiese un gran avance.</p>

<p>Para conseguir que el contenido se indexe y de paso evitar que los usuarios de IE tengan que activar la pel&iacute;cula Flash haciendo click en ella (el problema de Microsoft vs. <a href="http://en.wikipedia.org/wiki/Eolas">EOLAS</a>) la mejor forma de incluir contenido Flash es utilizar alguno de los m&eacute;todos basados en JavaScript. Los m&aacute;s conocidos son <a href="http://meddle.dzygn.com/esp/weblog/flash.accesible/">Flaccess</a>, <a href="http://blog.deconcept.com/swfobject/">SWFObject</a>, o el nuevo <a href="http://www.swffix.org/">SWFFix</a>.</p>

<p>Aunque con algunas diferencias entre ellos, estos m&eacute;todos se basan en presentar la p&aacute;gina en cuesti&oacute;n como HTML y "poner encima" las partes con Flash mediante JavasScript. Aunque esto podr&iacute;a dejar fuera a usuarios con el plugin de Flash instalado pero JS desactivado, no utilizar JS implica caer en el problema de EOLAS y perder una buena manera de validar que el usuario tiene la versi&oacute;n m&iacute;nima necesaria del plugin.</p>

<p>M&aacute;s enlaces a art&iacute;culos y ampl&iacute;as discusiones sobre el tema en la secci&oacute;n de enlaces.</p>

<a name="multi"></a>
<h2>Flash es multiplataforma. O eso dicen.</h2>

<p>&iquest;Multi significa m&aacute;s de uno, no? Entonce s&iacute;, Flash es multiplataforma. La clave claro est&aacute; en saber cu&aacute;n multiplataforma es. A d&iacute;a de hoy estas son las plataformas soportadas:</p>

<ul>
	<li>Windows, Mac y Linux. Player 9.</li>
	<li>Dispositivos m&oacute;viles Symbian. <a href="http://www.adobe.com/products/flashlite/">Flash Lite 3</a> (base de Player 8, aunque no completo).</li>
	<li>PDAs y Smartphones. <a href="http://www.adobe.com/products/flashplayer_pocketpc/">Flash para PocketPC</a> (Player 7).</li>
	<li>PSP. <a href="http://www.dandolachapa.com/2006/10/12/flash-en-la-psp-%c2%bfquieres-las-buenas-o-las-malas-noticias/">Player 6 con muchas limitaciones</a>.</li>
	<li>Montones de otros dispositivos como la Wii, la PS3, m&oacute;viles no basados en Symbian y cosas m&aacute;s estrafalarias como <a href="http://www.chumby.com/">Chumby</a>.</li>
</ul>

<p>Flash no funciona nativamente en sistemas de 64 bits ni en en FreeBSD. Dejo a juicio del lector decidir si calificar a Flash de multiplataforma o no.</p>

<a name="aplicaciones"></a>
<h2>Aplicaciones que molan y proyectos curiosos</h2>

<p>No son ni mucho menos todos los que hay, pero yo creo que son una buena muestra del potencial de Flash y AS3. La mayor&iacute;a adem&aacute;s son Open Source.</p>

<a name="papervision"></a>
<h3>Papervision3D</h3>

<p><a href="http://blog.papervision3d.org/">Papervision3D</a> es el motor de 3D en Flash m&aacute;s extendido a d&iacute;a de hoy. No es el primero ni el &uacute;ltimo pero es Open Source y ha conseguido aunar a una importante comunidad de desarrolladores que lo est&aacute;n haciendo mejorar d&iacute;a a d&iacute;a.</p>

<p>Capitaneado por el espa&ntilde;ol <a href="http://www.carlosulloa.com/">Carlos Ulloa</a> est&aacute; empezando a dar los <a href="http://osflash.org/papervision3d">primeros frutos realmente interesantes</a> para el 3D en Flash.</p>

<a name="red5"></a>
<h3>Red5</h3>

<p>Hay 2 formas de publicar v&iacute;deo en Flash. Descarga progresiva (el v&iacute;deo se carga din&aacute;micamente) o streaming real (el player conecta con un servidor, abre una conexi&oacute;n y descarga el v&iacute;deo seg&uacute;n lo necesita).</p>

<p>El servidor oficial de Adobe es Flash Media Server (antes Flash Communication Server), pero los chicos de <a href="http://osflash.org/red5">Red5</a> (escrito en Java) est&aacute;n haciendo un muy buen trabajo para tener un servidor de streaming para Flash totalmente abierto. &uacute;ltimamente parece que Adobe quiere poner alguna traba legal a proyectos como Red5 o Wowza (otro clon de FMS, esta vez cerrado y de pago), pero est&aacute; a&uacute;n por ver el alcance y la validez de la <a href="http://www.dandolachapa.com/2007/08/21/mpg4-en-flash-adobe-haciendo-amigos/">amenaza</a>.</p>

<p>Red5 tambi&eacute;n se usa para programar aplicaciones multi-usuario como chats o v&iacute;deo conferencias. </p>

<a name="hydra"></a>
<h3>Hydra</h3>

<p>Hydra (parte del <a href="http://labs.adobe.com/wiki/index.php/AIF_Toolkit">Adobe Image Foundation Toolkit</a>) es un nuevo lenguaje de programaci&oacute;n de Adobe para la creaci&oacute;n de efectos y procesamiento de im&aacute;genes. En teor&iacute;a, est&aacute; optimizado para utilizar GPUs y CPUs multi-n&uacute;cleo con lo que el rendimientno deber&iacute;a ser bueno. Sin embargo, lo relamente interesante es que podr&aacute; ser usado tanto en Flash como en AfterEffects.</p>

<a name="alivepdf"></a>
<h3>AlivePDF</h3>

<p><a href="http://www.alivepdf.org/">AlivePDF</a> es una librer&iacute;a en AS3 para la creaci&oacute;n de PDFs directamente desde Flash creada por Thibault Imbert, culpable tambi&eacute;n de proyectos como SMTPMailer, Mouse Gesture, <a href="http://www.wiiflash.org/">WiiFlash</a>, etc, etc.</p>

<a name="flashvnc"></a>
<h3>Flash VNC</h3>

<p><a href="http://osflash.org/fvnc">Cliente de VNC</a> escrito en AS3 por <a href="http://www.darronschall.com/">Darron Schall</a>. Seguramente no para ser usado en producci&oacute;n y m&aacute;s como prueba de concepto y aprendizaje.</p>

<a name="swhx"></a>
<h3>ScreenweaverHX</h3>

<p>La idea de los <em>wrappers</em> o contenedores de Flash es simple. Incluir la pel&iacute;cula Flash dentro de un ejecutable para poder ampliar sus posibilidades. Desde acceso de lectura y escritura al disco o al reg&iacute;stro de Windows hasta proveer una API de la ventana que lo contiene.</p>

<p>Una de las primeras aplicaciones fu&eacute; Screenweaver (primero de pago, luego libre) que no hace mucho se pas&oacute; completamente a haXe (de ah&iacute; el HX). <a href="http://haxe.org/swhx">SWHX</a> es un contenedor de aplicaciones Flash totalmente extensible mediante haXe y Neko.</p>

<a name="fc64"></a>
<h3>FC64</h3>

<p><a href="http://osflash.org/FC64">FC64</a> es un emulador de Commodore64 escrito en AS3 tambi&eacute;n por Darron Schall y compa&ntilde;&iacute;a.</p>

<ul>
	<li><a href="http://blogs.adobe.com/jnack/2007/10/adobe_unveils_h.html">Adobe unveils Hydra imaging technology</a></li>
	<li><a href="http://niquimerret.com/?p=94">Accessibility in Flash bug and issue list.</a></li>
	<li><a href="http://accesibilidadweb.blogspot.com/2007/09/flash-y-accesibilidad-web-una-relacin.html">Flash y Accesibilidad Web: una relaci&oacute;n complicada.</a></li>
	<li><a href="http://blog.deconcept.com/2006/03/13/modern-approach-flash-seo/">A modern approach to Flash SEO.</a></li>
	<li><a href="http://blog.guya.net/?p=11">Can you make me first in Google???</a></li>
	<li><a href="http://blogs.adobe.com/penguin.swf/2006/10/whats_so_difficult_64bit_editi.html">What's So Difficult? 64-bit Edition.</a></li>
</ul>
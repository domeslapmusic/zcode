<ul>
	<li><a href="<?php echo $article->url; ?>#intro">Introducci&oacute;n</a></li>
	<li><a href="<?php echo $article->url; ?>#solucion">Soluci&oacute;n</a></li>
	<li><a href="<?php echo $article->url; ?>#notas">Notas finales</a></li>
	<li><a href="<?php echo $article->url; ?>#enlaces">Enlaces</a></li>
</ul>
<a name="intro"></a>
<h2>Introducci&oacute;n</h2>
<p>Delegar es una cosa que mola. En la vida en general y en Flash en particular. Sobre todo cuando nos movemos de AS1 a AS2 + clases. Los foros de Flash est&aacute;n llenos de preguntas que tienen que ver con el &quot;scope&quot; o &aacute;mbito dentro de los famosos &quot;callbacks&quot; de objetos como XML, LoadVars, XMLSocket, etc. Flash necesita estas funciones porque las llamadas al servidor en Flash son as&iacute;ncronas, es decir, el player no detiene la ejecuci&oacute;n del c&oacute;digo cuando se hace, por ejemplo, una petici&oacute;n de un fichero xml:</p>
<p class="asCode">class A{<br><br>
&nbsp;&nbsp;&nbsp;private var oneVar:String = &quot;Hello world&quot;;<br><br>
&nbsp;&nbsp;&nbsp;function A():Void{<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var myXML:XML = new XML();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.ignoreWhite = true; // alguien ha encontrado esto en false????<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.onLoad = function():Void{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trace(oneVar); // undefined ¬¬<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.load(&quot;myXML.xml&quot;);<br><br>
&nbsp;&nbsp;&nbsp;}<br><br>
}</p>

<p>Esto pasa porque el &aacute;mbito &quot;dentro&quot; del onLoad es el propio objeto myXML, NO la clase. Puedes hacer la prueba haciendo trace(this) dentro del onLoad.</p>
<p>Una de las primeras soluciones que se utiliz&oacute; para esto fue crear dentro de la funci&oacute;n principal una variable que hac&iacute;a referencia a la propia clase. Algo como esto:</p>


<p class="asCode">class A{<br><br>
&nbsp;&nbsp;&nbsp;private var oneVar:String = &quot;Hello world&quot;;<br><br>
&nbsp;&nbsp;&nbsp;function A():Void{<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var owner = this;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var myXML:XML = new XML();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.ignoreWhite = true;<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.onLoad = function():Void{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trace(owner.oneVar); // yeah!<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.load(&quot;myXML.xml&quot;);<br><br>
&nbsp;&nbsp;&nbsp;}<br><br>
}</p>

<p>Y esto funciona. Este comportamiento &quot;peculiar&quot; de Flash (de los ECMAScript, vamos) se llama <strong>closure</strong>, algo de lo que yo me enter&eacute; en <a href="http://www.domestika.org/foros/viewtopic.php?t=47694">&eacute;ste post de Domestika</a>. M&aacute;s informaci&oacute;n en <a href="http://timotheegroleau.com/Flash/articles/scope_chain.htm">Scope Chain and Memory waste in Flash MX</a> y en la <a href="http://en.wikipedia.org/wiki/Closure_%28computer_science%29">Wikipedia</a> (para campeones).</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>


<a name="solucion"></a>
<h2>Soluci&oacute;n</h2>
<p>La misi&oacute;n era clara, buscar una forma m&aacute;s sencilla y elegante de resolver el problema del &aacute;mbito en las llamadas as&iacute;ncronas. Pues a todo esto lleg&oacute; la version 7.2 del Flash IDE y el se&ntilde;or Mike Chambers introdujo la clase Delegate. Utilizando esa clase dejar&iacute;amos el c&oacute;digo anterior en algo como esto:</p>
<p class="asCode">import mx.utils.Delegate;<br><br>
class A{<br><br>
&nbsp;&nbsp;&nbsp;private var oneVar:String = &quot;Hello world 2&quot;;<br><br>
&nbsp;&nbsp;&nbsp;function A(){<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var myXML:XML = new XML();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.ignoreWhite = true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.onLoad = Delegate.create(this,xmlLoaded);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;myXML.load("myXML.xml");<br><br>
&nbsp;&nbsp;&nbsp;}<br><br>
&nbsp;&nbsp;&nbsp;private function xmlLoaded(success:Boolean):Void{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trace(oneVar);<br>
&nbsp;&nbsp;&nbsp;}<br><br>
}</p>

<p>Estamos &quot;delegando&quot; el onLoad en la funci&oacute;n xmlLoaded, pero, lo m&aacute;s importante, el &aacute;mbito de la funci&oacute;n xmlLoaded es la clase original, por lo que &quot;encontramos&quot; la variable sin problemas. Ahora empezamos a molar.</p>
<p>Esto definitivamente NO es lo mismo que hacer: <span class="asCode">myXML.onLoad = xmlLoaded</span>. Si lo prob&aacute;is, estar&eacute;is con el mismo problema que antes, el &aacute;mbito de la funci&oacute;n xmlLoaded ser&aacute; el objeto myXML, por lo que el trace volver&aacute; a ser undefined.</p>
<p>El mayor problema de la clase de Macromedia (a&uacute;n era Macromedia) es que NO permite el paso de par&aacute;metros a la funci&oacute;n delegada, pero pronto llegaron los frikis para solucionarlo haciendo sus propias clases para delegar. <a href="Delegate.as">La que yo utilizo</a> es una copia con alguna modificaci&oacute;n de una que encontr&eacute; en la lista de <a href="http://lists.motion-twin.com/pipermail/mtasc/2005-April/001602.html">MTASC</a>. Con estas nuevas clases se pueden pasar par&aacute;metros de la siguiente forma:</p>
<p class="asCode">myXML.onLoad = Delegate.create(this,xmlLoaded,"val1",val2);</p>
<p><strong>OJO</strong>, nuestros par&aacute;metros llegar&aacute;n despu&eacute; de los &quot;oficiales&quot;, en este caso el t&iacute;pico success que llega a los onLoad del objeto XML.</p>
<p>Como curiosidad apuntar que con las clases de Delegate se pueden hacer cosas como esta:</p>
<p class="asCode">import tv.zarate.Utils.Delegate;<br><br>
class A{<br><br>
&nbsp;&nbsp;&nbsp;function A(){<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// delegamos la funcion en una variable local<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var delegatedOne:Function = Delegate.create(this,getOneValue);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// pasamos la funcion delegada como parametro<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;doLater(delegatedOne);<br><br>
&nbsp;&nbsp;&nbsp;}<br><br>
&nbsp;&nbsp;&nbsp;private function doLater(delegated:Function):Void{<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// ejecutamos la funcion pero no devuelve nada<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trace("Pero no me devuelve nada? " + delegated());<br><br>
&nbsp;&nbsp;&nbsp;}<br><br>
&nbsp;&nbsp;&nbsp;private function getOneValue():String{<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trace("La funcion se ejecuta");<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return "I rock \m/";<br><br>
&nbsp;&nbsp;&nbsp;}<br><br>
}</p>

<p>Decidir si esta manera de trabajar es una <i>best practice</i> o no es cosa de cada uno. Hace poco me encontr&eacute; con una aplicaci&oacute;n MVC en la que el modelo le pasaba a la vista las funciones delegadas para los botones de la interface. A gusto del consumidor.</p>

<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

<a name="notas"></a>
<h2>Notas finales</h2>
<p>Lo gracioso de esto es que <i>dentro de poco</i> las clases de delegar no se van a utilizar porque en AS3 la delegaci&oacute;n es autom&aacute;tica (echad un ojo a <a href="http://www.adobe.com/devnet/actionscript/articles/actionscript3_overview.html">AS3 overview</a>, Method closures). Pero vamos, al ritmo que se va adoptando las nuevas versiones, yo creo que este art&iacute;culo a&uacute;n puede ser &uacute;til a mucha gente.</p>
<p>Pues esto es todo familia, <strong>HTH</strong>.</p>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
<a name="enlaces"></a>
<h2>Enlaces</h2>
<ul>
	<li><a href="http://www.adobe.com/devnet/flash/articles/eventproxy.html">Proxying Events with the mx.utils.Delegate Class</a></li>
	<li><a href="http://lists.motion-twin.com/pipermail/mtasc/2005-April/001602.html">Implementaci&oacute;n original de Till Schneidereit sobre la que est&aacute; hecha la clase que yo utilizo.</a></li>
	<li><a href="http://www.domestika.org/foros/viewtopic.php?t=47694">Post sobre <i>closures</i> en Domestika en el que queda patente mi inculticia :P</a></li>
	<li><a href="http://en.wikipedia.org/wiki/Closure_%28computer_science%29">Explicaci&oacute;n en la Wikipedia sobre closures. Para muy gafotas.</a></li>
</ul>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>
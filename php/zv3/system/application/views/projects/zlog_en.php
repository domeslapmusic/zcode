<span class="version">version 1.1</span>
<div id="menu">
	<ul>
		<li><a href="<?php echo $project->url; ?>#intro">Introduction</a></li>
		<li><a href="<?php echo $project->url; ?>#usage">How to use it</a></li>
		<li><a href="<?php echo $project->url; ?>#demo">Demo</a></li>
		<li><a href="<?php echo $project->url; ?>#download">Download</a></li>
		<li><a href="<?php echo $project->url; ?>#changelog">Change log</a></li>
		<li><a href="proyectos/zlog/">Castellano</a></li>
	</ul>
</div>

<a name="intro"></a>
<h2>Introduction</h2>

<p><strong>ZLog</strong> ("z-log") is a simple Flash log system 100% compatible with <a href="http://www.mtasc.org">MTASC</a> and the IDE. <strong>ZLog</strong> has 2 parts:</p>
<ul>
	<li><strong>The console</strong>. It&apos;s an HTML page in which traces are shown.</li>
	<li><strong>The connector class</strong>. This class just creates one LocalConnection object to send the trace to the console. This class has to be added to your movie.</li>
</ul>
<p>Main features are:</p>
<ul>
	<li>Ultralight. You just need to add the connector class and you'll be ready to go.</li>
	<li>You can add new trace types without recompiling anything. For every trace one &lt;p class=&quot;type&quot;&gt; tag is created, where type is the second parameter passed to the trace function. To add or modify trace types you just need to update the console's css.</li>
	<li>Keyboard shortcuts:
		<ul>
			<li>r: inits log.</li>
			<li>p: pause/continue log.</li>
			<li>a: add blank line.</li>
		</ul>
	</li>
	<li>You could pass as third parameter one boolean value (true/false) that will reinitiate the log. Very useful when you have hundreds of log lines.</li>
</ul>
<p><a href="http://www.google.co.uk/search?q=flash+log&start=0&ie=utf-8&oe=utf-8&client=firefox-a&rls=org.mozilla:en-US:official">As many other Flash log systems</a>, <strong>ZLog</strong> is based in the <a href="http://livedocs.macromedia.com/flash/mx2004/main_7_2/wwhelp/wwhimpl/common/html/wwhelp.htm?context=Flash_MX_2004&file=00001421.html#wp3995201">LocalConnection</a> object, so it should trace everything arriving from the console's connection (method &quot;log&quot;, connection &quot;_ZLog&quot;). This way should be easy to trace either from MTASC or IDE </p>

<a name="usage"></a>
<h2>How to use</h2>
<h3>From MTASC</h3>
<p>To use <strong>ZLog</strong> from MTASC you should just add to your compile command -trace tv.zarate.Utils.Trace.trc. MTASC will change all your trace(&quot;Hello World&quot;) with tv.zarate.Utils.Trace.trc(&quot;Hello world&quot;). If you want to learn a little bit more how MTASC works with -trace take a look at its <a href="http://www.mtasc.org/#trace">reference</a>.</p>

<h3>From Flash IDE or AS2 compiled with the IDE.</h3>
<p>If you are working with the IDE, you can also use <strong>ZLog</strong>. You just have to change your trace() actions for Trace.trc(). In this case you have not one compiler which automatically pre-processes the code to make that change.</p>
<h4>Optional parameters (MTASC and IDE)</h4>
<p>If you want to define a type of trace, you just need to pass it as second parameter: trace(&quot;Hello world&quot;,&quot;fatal&quot;). That second parameter must match one console's css class.</p>
<p>You can remove previous traces passing true as third parameter: trace(&quot;Hello world&quot;,&quot;&quot;,true).</p>

<a name="demo"></a>
<h2>Demo</h2>
<p>If you want to see <strong>ZLog</strong> running open it <a href="<?php echo base_url(); ?>assets/projects/zlog/ZLog.html" onClick="javascript:window.open('<?php echo base_url(); ?>assets/projects/zlog/ZLog.html','ZLog','width=500,height=400,resizable=yes'); return false;">here</a>, and then click any of the buttons bellow.</p>

	<div id="container"></div>
	
	<script type="text/javascript">
		// <![CDATA[
			
			var so = new SWFObject("<?php echo base_url(); ?>assets/projects/zlog/elements/test.swf","zlog","500","40","8","#ffffff");
			so.write("container");
			
		// ]]>
	</script>

<a name="download"></a>
<h2>Download</h2>
<p><strong>ZLog</strong> is Open Source and you can download:</p>
<ul>
	<li><a href="<?php echo base_url(); ?>assets/projects/zlog/files/ZLog.air">ZLog AIR package</a>. It runs ZLog as an application outside the browser. It needs <a href="http://get.adobe.com/air/">AIR 1.1 runtime</a>.</li>
	<li><a href="<?php echo base_url(); ?>assets/projects/zlog/files/zlog_v_1_1_simple.zip">Basic pack</a>. Compiled console and the connector class.</li>
	<li><a href="<?php echo base_url(); ?>assets/projects/zlog/files/zlog_v_1_1_complete.zip">Geek pack</a>. Console's code with compiling instructions and the connector class.</li>
</ul>

<a name="changelog"></a>
<h2>ChangeLog</h2>
<dl>
	<dt>Version 1.1 - 10th june 2007</dt>
	<dd>
		<ul>
			<li>Console switched from Flash to HTML.</li>
			<li>Improved how XML objects are traced. To trace an XML object, you have to pass it &quot;alone&quot;:
				<ul>
					<li>trace(myXML); // ok</li>
					<li>trace("This is my XML > " + myXML); // wrong!</li>
				</ul>
			</li>
			<li>Added "a" as shortcut to add blank lines.</li>
			<li>Now minimum Flash player version required to use the console is 8 due to ExternalInterface usage for Flash -&gt; JavaScript communication.</li>
			<li>tv.zarate.Utils.Trace has been updated to allow sending objects to the console (needed to trace XML objects).</li>
			<li>Now we check if console's LocalConnection object is actually created and display error if otherwise.</li>
		</ul>
	</dd>
	<dt>Version 1.0 - 25th March 2006</dt>
	<dd>Initial version.</dd>
</dl>

<a name="licencia"></a>
<h2>License</h2>
<p>You should use <strong>ZLog at your own risk</strong>, I use it everyday without any problem. The code is under a Creative Commons license so you can take a look to it, change it or use it even in commercial projects. If you have any doubts, want to see anything new or you find a bug, please drop me a line to <a href="javascript:noBot('zlog','zarate.tv');">zlog [*] zarate . tv</a>.</p>
<p><strong>HTH :D</strong></p>
<p><a href="http://www.zarate.tv">Z&aacute;rate</a></p>
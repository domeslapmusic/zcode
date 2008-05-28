<div>
<p><a href="http://www.m-learning.org/">m-learning</a> is an e-learning platform for mobile devices. It consists in a Windows-based desktop tool to create the content and a Flash-based application that runs on the devices. That Flash application also communicates with a remote server to keep user statistics.</p>
<p>My work consisted in planificating the Flash estructure and developing the generic Flash player for the especific activities. The Flash player si flexible enough to work on:
<ul>
	<li>Windows Mobile PDAs, inside our own C wrapper.</li>
	<li>In any regular PC, inside Screenweaver.</li>
	<li>In a browser, giving up some of the features (basically file system access).</li>
</ul>

You can see a litte recorded demo in the video bellow:

</p>
<br>
<br>

<div id="container"></div>

<script type="text/javascript">
	// <![CDATA[
		
		var so = new SWFObject("<?php echo base_url(); ?>assets/portfolio/mlearning/zplayer.swf","mlearning","500","500","8","#832cad");
		so.addVariable("fv_xmlPath","<?php echo base_url(); ?>assets/portfolio/mlearning/zplayer.xml");
		so.write("container");
		
	// ]]>
</script>


<div>
<div>
<p><a href="http://www.m-learning.org/">m-learning</a> es una plataforma de e-learning para dispositivos m&oacute;viles. Consiste en una herramienta de escritorio para generar contenido y una aplicaci&oacute;n Flash para mostrarlo en las PDAs. Esa aplicaci&oacute;n adem&aacute;s se comunica con un servidor que almacena las estad&iacute;sticas de uso.</p>
<p>Mi trabajo ha consistido en la planificaci&oacute;n de toda la parte Flash y el desarrollo del player gen&eacute;rico para las actividades. Ese player en el que se realizan las actividades puede funcionar:
<ul>
	<li>En las PDAs, dentro de un wrapper propio escrito en C.</li>
	<li>En un PC normal, dentro de Screenweaver.</li>
	<li>En un navegador, renunciando a algunas de las caracter&iacute;siticas.</li>
</ul>
</p>
<br/>
<br/>

<div id="container"></div>

<script type="text/javascript">
	// <![CDATA[
		
		var so = new SWFObject("<?php echo base_url(); ?>assets/portfolio/mlearning/zplayer.swf","mlearning","500","500","8","#832cad");
		so.addVariable("fv_xmlPath","<?php echo base_url(); ?>assets/portfolio/mlearning/zplayer.xml");
		so.write("container");
		
	// ]]>
</script>

<div>
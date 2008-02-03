<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	
	<title>Z&aacute;rate - <?php echo $section->title; ?></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<base href="<?php echo base_url(); ?>" />
	<link rel="stylesheet" href="css/zwebv3.css" type="text/css" media="screen" />
	<script type="text/javascript" src="js/swfobject.js"></script>
	
</head>
<body>

	<div id="container">
		
		<div id="header">
			
			<div id="languages">
				
				<ul>
					
					<?php foreach($languages as $language){
					
					if($language->language_id != $this->session->userdata('language_id')){  ?>
					
					<li><a href="<?php echo $language->shortID; ?>" title="<?php echo $language->change; ?>"><?php echo $language->title; ?></a></li>
					
					<?php } else {?>
					
					<li><?php echo $language->title; ?></li>
					
					<?php }
					
					} ?>
					
				</ul>
				
			</div>
			
			<div id="menu">
				
				<ul>
					<?php foreach($sections as $menuSection){
					
					if($menuSection->section_id != $section->section_id){  ?>
					
					<li><a href="<?php echo $menuSection->rewrite; ?>"><?php echo $menuSection->title; ?></a></li>
					
					<?php } else { ?>
					
					<li><?php echo $menuSection->title; ?></li>
					
					<?php }
					
					} ?>
				</ul>
				
			</div>
			
		</div>
		
		<div id="section">
			
			<h1><?php echo $section->title; ?></h1>
			
			<p><?php echo $section->summary; ?></p>
			
			<?php if(isset($section->options)){?>
			
			<div id="options">
				
				<dl>
					
					<?php foreach($section->options as $option){?>
					
					<dt><?php echo $option->title; ?></dt>
					<dd><?php echo $option->summary; ?>. <?php $option->url; ?></dd>
					
					<?php } ?>
					
				</dl>
				
			</div>
			
			<?php } ?>
			
		</div>
		
		<div id="hcard-Juan-Delgado" class="vcard">
			<a class="url fn" href="http://zarate.tv">Juan Delgado</a>
			<a class="email" href="mailto:zzzarate@gmail.com">zzzarate@gmail.com</a>
			<div class="adr">
				<span class="locality">Cambridge</span>
				<span class="country-name">UK</span>
			</div>
			<div class="tags"><a href="http://kitchen.technorati.com/contacts/tag/flash">flash</a> <a href="http://kitchen.technorati.com/contacts/tag/developer">developer</a> <a href="http://kitchen.technorati.com/contacts/tag/actionscript">actionscript</a> <a href="http://kitchen.technorati.com/contacts/tag/open source">open source</a> <a href="http://kitchen.technorati.com/contacts/tag/haxe">haxe</a> <a href="http://kitchen.technorati.com/contacts/tag/php">php</a> </div>
		</div>
		
		<p id="no_flash_warning"><?php echo $misc_flash_warning; ?></p>
		
	</div>
	
	<script type="text/javascript">
		// <![CDATA[
			
			var so = new SWFObject("assets/zwebv3.swf","zwebv3","100%","100%","8","#000000");
			so.addVariable("fv_xmlPath","xml/");
			so.write("container");
			
		// ]]>
	</script>
	
</body>
</html>
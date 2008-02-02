<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	
	<title>Z&aacute;rate - <?php echo utf8_encode($section->title); ?></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<base href="<?php echo base_url(); ?>" />
	<link rel="stylesheet" href="css/zwebv3.css" type="text/css" media="screen" />
	<script type="text/javascript" src="js/swfobject.js"></script>
	
</head>
<body>

	<div id="container">
		
		<div id="menu">
			
			<ul>
				<?php foreach($sections as $menuSection){
				
				if($menuSection->section_id != $section->section_id){  ?>
				
				<li><a href="<?php echo utf8_encode($menuSection->rewrite); ?>"><?php echo utf8_encode($menuSection->title); ?></a></li>
				
				<?php } else { ?>
				
				<li><?php echo utf8_encode($menuSection->title); ?></li>
				
				<?php }
				
				} ?>
			<ul>
			
		</div>
		
		<h1><?php echo utf8_encode($section->title); ?></h1>
		
		<p><?php echo utf8_encode($section->summary); ?></p>
		
		<?php if(isset($section->options)){?>
		
		<div id="options">
			
			<dl>
				
				<?php foreach($section->options as $option){?>
				
				<dt><?php echo utf8_encode($option->title); ?></dt>
				<dd><?php echo utf8_encode($option->summary); ?>. <?php echo utf8_encode($option->url); ?></dd>
				
				<?php } ?>
				
			</dl>
			
		</div>
		
		<?php } ?>
		
		<div id="languages">
			
			<ul>
				
				<?php foreach($languages as $language){
				
				if($language->language_id != $this->session->userdata('language_id')){  ?>
				
				<li><a href="<?php echo $language->shortID; ?>" title="<?php echo utf8_encode($language->change); ?>"><?php echo utf8_encode($language->title); ?></a></li>
				
				<?php } else {?>
				
				<li><?php echo utf8_encode($language->title); ?></li>
				
				<?php }
				
				} ?>
				
			</ul>
			
		<div>
		
		<p>Either not correct version of Flash player, no JS or you have an iPhone.</p>
		
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
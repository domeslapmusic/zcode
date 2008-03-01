<!--

<?php 

/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

echo utf8_encode($misc_freak_warning); 

?>
	

-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $language->shortID; ?>" lang="<?php echo $language->shortID; ?>">
<head>
	
	<title>Z&aacute;rate - <?php echo $section->title; ?></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<base href="<?php echo base_url(); ?>" />
	<link rel="stylesheet" href="css/zwebv3.css" type="text/css" media="screen" />
	<?php if($forceHTML != true){ ?> <script type="text/javascript" src="js/swfobject.js"></script> <?php } ?>
	<script type="text/javascript" src="js/zwebv3.js"></script>
	
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
					<dd><?php echo $option->summary; ?></dd>
					
					<?php } ?>
					
				</dl>
				
			</div>
			
			<?php } ?>
			
		</div>
		
		<div id="hcard-Juan-Delgado" class="vcard">
			<a class="url fn" href="http://zarate.tv">Juan Delgado</a>
			<a class="email" href="mailto:zzzarate@gmail.com">zzzarate@gmail.com</a>
		</div>
		
		<p id="no_flash_warning"><?php echo utf8_encode($misc_flash_warning); ?></p>
		
		
	</div>
	
	<?php if($forceHTML != true){ ?>
	
	<script type="text/javascript">
		// <![CDATA[
			
			var so = new SWFObject("assets/zwebv3.swf","zwebv3","100%","100%","8","#000000");
			so.addVariable("fv_xmlPath","xml/");
			so.write("container");
			
		// ]]>
	</script>
	
	<?php } ?>
	
</body>
</html>
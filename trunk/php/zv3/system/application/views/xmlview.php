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

header('Content-Type: text/xml');
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"; 

?>

<data>

	<sections>

	<?php foreach($sections as $section){ ?>
	
	<section section_id="<?php echo $section->section_id; ?>" selected="<?php echo ($currentSection->section_id == $section->section_id)? "true":"false"; ?>">
		
		<title><![CDATA[<?php echo $section->title; ?>]]></title>
		<text><![CDATA[<?php echo $section->summary; ?>]]></text>
		
		<?php if(isset($section->options)){?>
		
		<options>
			
			<?php foreach($section->options as $option){?>
			<option>
				<title><![CDATA[<?php echo $option->title; ?>]]></title>
				<text><![CDATA[<?php echo $option->summary; ?>]]></text>
				<link><![CDATA[<?php echo $option->url; ?>]]></link>
			</option>
			
			<?php } ?>
			
		</options>
		
		<?php } ?>
		
	</section>
	
	<?php } ?>
	
	</sections>
	
	<languages>
		
		<?php foreach($languages as $language){ ?>
		
		<language language_id="<?php echo $language->language_id; ?>" shortID="<?php echo $language->shortID; ?>" selected="<?php echo ($language->language_id != $this->session->userdata('language_id'))? "false":"true"; ?>">
			<title><![CDATA[<?php echo $language->title; ?>]]></title>
			<change><![CDATA[<?php echo $language->change; ?>]]></change>
		</language>
		
		<?php } ?>
		
	</languages>
	
	<literals>
		<?php foreach($literals as $key => $val){ ?>
		<literal id="<?php echo $key; ?>"><![CDATA[<?php echo utf8_encode($val); ?>]]></literal>
		<?php } ?>
	</literals>
	
</data>
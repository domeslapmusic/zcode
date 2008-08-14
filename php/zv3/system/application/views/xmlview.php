<?php 

/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
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
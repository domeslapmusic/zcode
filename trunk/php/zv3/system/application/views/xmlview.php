<?php 

header('Content-Type: text/xml');
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"; 

?>

<data>

	<sections>

	<?php foreach($sections as $section){ ?>
	
	<section section_id="<?php echo utf8_encode($section->section_id); ?>" selected="<?php echo ($currentSection->section_id == $section->section_id)? "true":"false"; ?>">
		
		<title><![CDATA[<?php echo utf8_encode($section->title); ?>]]></title>
		<text><![CDATA[<?php echo utf8_encode($section->summary); ?>]]></text>
		
		<?php if(isset($section->options)){?>
		
		<options>
			
			<?php foreach($section->options as $option){?>
			<option>
				<title><![CDATA[<?php echo utf8_encode($option->title); ?>]]></title>
				<text><![CDATA[<?php echo utf8_encode($option->summary); ?>]]></text>
				<link><![CDATA[<?php echo utf8_encode($option->url); ?>]]></link>
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
			<title><![CDATA[<?php echo utf8_encode($language->title); ?>]]></title>
			<change><![CDATA[<?php echo utf8_encode($language->change); ?>]]></change>
		</language>
		
		<?php } ?>
		
	</languages>
	
	<molas><?php echo $currentSection->section_id; ?></molas>
	
</data>
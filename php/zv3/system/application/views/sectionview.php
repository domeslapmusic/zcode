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
			
			<?php  $this->load->view("menuview"); ?>
			
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
			
			var so = new SWFObject("assets/launcher.swf","zwebv3","100%","100%","8","#000000");
			so.addVariable("fv_xmlPath","xml/");
			so.addVariable("fv_application","assets/zwebv3.swf");
			so.write("container");
			
		// ]]>
	</script>
	
	<?php } ?>
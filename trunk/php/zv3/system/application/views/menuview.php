
			<div id="menu">
				
				<ul>
					<?php foreach($sections as $menuSection){
					
					if($menuSection->section_id != $section->section_id || $forceMenu){  ?>
					
					<li><a href="<?php echo $menuSection->rewrite; ?>"><?php echo $menuSection->title; ?></a></li>
					
					<?php } else { ?>
					
					<li><?php echo $menuSection->title; ?></li>
					
					<?php }
					
					} ?>
				</ul>
				
			</div>
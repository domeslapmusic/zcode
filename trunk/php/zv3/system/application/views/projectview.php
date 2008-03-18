<?php  $this->load->view("menuview"); ?>

<h1><?php echo $project->title; ?></h1>

<?php  $this->load->view("projects/".$project->rewrite."_".$language->shortID); ?>
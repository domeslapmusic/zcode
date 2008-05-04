<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	
	<title>Zalaga</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<base href="<?php echo base_url(); ?>" />

	<link rel="stylesheet" href="css/zalaga.css" type="text/css" media="screen" />
	
</head>
<body>

<h1>Zalaga</h1>

<h2>Nav</h2>

<?php

if(count($breadcrumbs) > 0){

	$totalpath = base_url();

	echo '<a href="'.$totalpath.'">Home</a> >>  ';

	foreach($breadcrumbs as $breadcrumb){
		
		echo '<a href="'.$totalpath."/".$breadcrumb.'">'.$breadcrumb.'</a> >>  ';
		
		$totalpath.= $breadcrumb."/";
		
	}
	
}

?>

<h2>Folders</h2>

<?php 

if(count($folders) > 0){

	foreach($folders as $folder){
		
		echo '<a href="'.base_url().$initPath."/".$folder.'">'.$folder.'</a><br>';
		
	}
	
}

?>

<h2>Files</h2>

<?php  echo getPagination($totalpages,$page,$initPath); ?>

<br><br>

<?php

if(count($files) > 0){

	foreach($files as $file){
		
		$path = 'image'.$initPath.'/'.$file;
		
		echo '<a href="'.$path.'/full"><img src="'.$path.'"/></a>';
		
	}
	
}

?>

<br><br>

<?php  echo getPagination($totalpages,$page,$initPath); ?>

</body>
</html>

<?php

	function getPagination($totalpages,$page,$initPath){
		
		$pagination = "";
		
		for($x=1;$x<$totalpages;$x++){
			
			if($x != $page){
				
				$pagination .='<a href="'.base_url().$initPath.'/page/'.$x.'/">'.$x.'</a>';
				
			} else {
				
				$pagination .= $x;
				
			}
			
			if($x < $totalpages-1){ $pagination.= ' | '; }
			
		}
		
		return $pagination;
		
	}

?>
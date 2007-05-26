<?php

	require_once("../../data/zbooks/setup.php");	
	require_once($confObj->getClassPath()."html.class.php");
	
	$WSPath = "http://".$_SERVER["SERVER_NAME"].$page->getWSPath();
	
	$myHTML = new html($smarty,$WSPath,$_GET["user_id"],$_GET["label_id"]);
	$myHTML->displayPage();

	$page->config("html.htm","Inicio");
	$page->setFlashVars();
	$page->display();
	
?>
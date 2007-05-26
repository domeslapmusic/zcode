<?php

	define('IN_ZBOOKS',true);
	define("appRoot","./");
	
	require_once(appRoot."data/setup.php");
	
	$page->config("flash.htm","Inicio");
	$page->setFlashVars();
	$page->display();
	
?>
<?php

	define('IN_ZBOOKS',true);
	define("appRoot","./../");

	require_once(appRoot."data/setup.php");
	require_once($confObj->getClassPath()."data.class.php");
	
	$page->config("adminCommon.htm","Account confirmation");

	if($user->isLogged()){
		
		header("Location:index.php");
		
	} else {
		
		if($_GET["action"] == "confirm" && isset($_GET["key"])){
			
			$result = $user->confirmUser($_GET["key"]);
			
		}
		
	}
	
	if(isset($result)){ $page->showError($user->getError(),$result); }
	
	$page->display();
	
?>
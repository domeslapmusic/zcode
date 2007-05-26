<?php

	define('IN_ZBOOKS',true);
	define("appRoot","./../");

	require_once(appRoot."data/setup.php");
	require_once($confObj->getClassPath()."data.class.php");
	require_once($confObj->getClassPath()."import.class.php");
	
	$page->config("adminCommon.htm","Administration");
	
	if($user->isLogged()){
		
		$page->setAdminTemplate("converter.htm");
		$page->showLoginData($user);
		
		if($_POST["action"] == "import"){
			
			$imp = new import($confObj);
			
			$result = $imp->importFromFile($_FILES["userFile"],$_POST["fileType"],$user->getCurrentUserID(),$_POST["private"]);
			
		}
		
		if(isset($result)) $page->showError($imp->getError(),$result);
		
	} else {
		
		
		
	}
	
	$page->display();
	
?>
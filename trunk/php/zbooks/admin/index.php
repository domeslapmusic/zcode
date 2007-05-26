<?php

	define('IN_ZBOOKS',true);
	define("appRoot","./../");

	require_once(appRoot."data/setup.php");
	require_once($confObj->getClassPath()."data.class.php");
	
	$page->config("adminCommon.htm","Administration");
	
	if($user->isLogged()){
		
		$page->setAdminTemplate("adminMain.htm");
		
		switch($_POST["action"]){
			
			case("backup"):
				
				$result = $user->changeBackupOptions($_POST["autobackup"],$_POST["backuponserver"],$_POST["autobackupdays"]);
				break;
				
			case("basicOptions"):
				
				$result = $user->updateConfigData($_POST["bookmarksTarget"],$_POST["bookmarksNumber"],$_POST["showURL"]);
				break;
				
			case("resetApp"):
				
				$result = $user->resetApp();
				break;
				
			case("changePassword"):
				
				$result = $user->changePassword($_POST["currentPass"],$_POST["newPass1"],$_POST["newPass2"]);
				break;
				
			case("changeEmail"):
				
				$result = $user->changeEmail($_POST["newUserEmail"]);
				break;
			
		}
		
		$page->showLoginData($user);
		
		if(isset($result)) $page->showError($user->getError(),$result);
		
		if($user->isAdmin()) $page->showBackupData($user->getAdminData());
		$page->showConfigData($user->getConfigData($user->getCurrentUserID()));
		
	}
	
	$page->display();
	
?>
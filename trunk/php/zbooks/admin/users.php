<?php

	define('IN_ZBOOKS',true);
	define("appRoot","./../");

	require_once(appRoot."data/setup.php");
	require_once($confObj->getClassPath()."data.class.php");
	
	$page->config("adminCommon.htm","Administration");

	if($user->isLogged()){
		
		$page->showLoginData($user);
		
		if($user->isAdmin()){
			
			$page->setAdminTemplate("manageUsers.htm");
			
			switch($_POST["action"]){
				
				case("addUSer"):
					
					$result = $user->addUSer($_POST["username"],$_POST["usermail"],$_SERVER["PHP_SELF"]);
					break;
					
				case("removeUsers"):
					
					$result = $user->removeUsers($_POST["toRemove"]);
					break;
					
				case("removeTempUsers"):
					
					$result = $user->removeTempUsers($_POST["toRemove"]);
					break;
				
			}
			
			$page->showCurrentUsers($user->getCurrentUsers());
			$page->showTempUsers($user->getTempUsers());
			
		} else {
			
			$page->showAdminRightsWarning();
			
		}
		
		if(isset($result)) $page->showError($user->getError(),$result);
		
	}
	
	$page->display();
	
?>
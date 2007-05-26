<?php

	if (!defined('IN_ZBOOKS') ){
		die("Hacking attempt");
	}

	if($_POST["newUserName"] && $_POST["newUserPassword"]){
		
		if(!$user->validateUser($_POST["newUserName"],$_POST["newUserPassword"],$_POST["useCookie"])){
			
			$page->showError($user->getError(),false);
			
		}
		
	} else if($user->getCookie()){
		
		if(!$user->validateUserByCookie()){
			
			$user->logout();
			$page->showError($user->getError(),false);
			
		}
		
	}
	
	if(isset($_POST["logout"])){
		
		$user->logout();
		
	}
	
?>
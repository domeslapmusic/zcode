<?php

	if($user->isAdmin() && $user->isLogged() && !$_SESSION["backupChecked"]){
		
		$_SESSION["backupChecked"] = true;
		$user->doBackup();
		
	}
	
?>
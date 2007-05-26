<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


require_once($confObj->getClassPath()."export.class.php");
require_once($confObj->getClassPath()."email.class.php");

class user{
	
	var $validate;
	var $cookieName = "zb_user";
	var $errorString = "";
	var $newUserPass;
	
	function user($val){
		
		$this->validate = $val;
		
	}
	
	function getCurrentUsers(){
		
		$q = "SELECT * FROM zb_users WHERE user_id > 2 ORDER BY name ASC";
		return mysql_query($q);
		
	}
	
	function getTempUsers(){
		
		$q = "SELECT * FROM zb_users_tmp ORDER BY name ASC";
		return mysql_query($q);		
		
	}
	
	function removeTempUsers($users){
		
		$tmpRes = false;
		
		if($this->isLogged() && $this->isAdmin()){
			
			if(isset($users) && count($users) > 0){
				
				foreach($users as $key => $val){
					
					$q = "DELETE FROM zb_users_tmp WHERE confirmation='".$key."'";
					$tmpRes = mysql_query($q);
					
					$this->setError(($tmpRes)? "Users removed without problems.":"Problems removing some users.");
					if(!$tmpRes) break;
					
				}
				
			} else  {
				
				$this->setError("No user selected.");
				
			}
			
		}
		
		return $tmpRes;
		
	}
	
	function removeUsers($users){
		
		$tmpRes = false;
		
		if($this->isLogged() && $this->isAdmin()){
			
			if(isset($users) && count($users) > 0){
				
				foreach($users as $key => $val){
					
					$q = "DELETE FROM zb_users WHERE user_id='".$key."'";
					$tmpRes = mysql_query($q);
					
					if($tmpRes){
						
						$q = "DELETE FROM zb_config WHERE user_id='".$key."'";
						$tmpRes = mysql_query($q);
						
					} else {
						
						$this->setError("Problems removing user information.");
						
					}
					
				}
				
			} else {
				
				$this->setError("No user selected.");
				
			}
			
		}
		
		return $tmpRes;
		
	}
	
	function confirmUser($key){
		
		$tmpRes = false;
		
		$key = $this->validate->validateConfirmKey($key);
		
		$q = "SELECT * FROM zb_users_tmp WHERE confirmation='".$key."'";
		$qDB = mysql_query($q);
		
		if(mysql_num_rows($qDB) == 1){
			
			$initialData = mysql_fetch_array($qDB);
			$initialName = $initialData["name"];
			
			if($this->addConfirmedUSer($key)){
				
				if($this->removeTmpUSer($key)){
					
					$this->setError("Your account has been created successfully. Your username is ".$initialName." and your initial password ".$this->newUserPass.", you can change it after login. Enjoy ZBooks :)");
					$tmpRes = true;
					
				} else {
					
					$this->setError("Impossible to create new user, please try again.");
					
				}
				
			} else {
				
				$this->setError("Impossible to create new user, please try later.");
				
			}
			
			
		} else {
			
			$this->setError("You are not using a valid confirmation key.");
			
		}
		
		return $tmpRes;
		
	}
	
	function addConfirmedUSer($key){
		
		$tmpRes = false;
		
		$key = $this->validate->validateConfirmKey($key);
		
		$initialData = $this->getConfirmData($key);
		
		$initPass = str_shuffle(strtotime("now").mt_rand());
		$q = "INSERT INTO zb_users VALUES ('','0','".$initialData["name"]."','".$initialData["mail"]."','".md5($initPass)."')";
		
		if(mysql_query($q)){
			
			$newUserID = mysql_insert_id();
			$q = "INSERT INTO zb_config VALUES ('".$newUserID."','_self','10','0')";
			
			if(mysql_query($q)){
				
				$this->newUserPass = $initPass;
				$tmpRes = true;
				
			}
			
		}
		
		return $tmpRes;
		
	}
	
	function getConfirmData($key){
		
		$key = $this->validate->validateConfirmKey($key);
		$q = "SELECT * FROM zb_users_tmp WHERE confirmation='".$key."'";		
		$qDB = mysql_query($q);
		return mysql_fetch_array($qDB);
		
	}
	
	function removeTmpUSer($key){
		
		$key = $this->validate->validateConfirmKey($key);
		$q = "DELETE FROM zb_users_tmp WHERE confirmation='".$key."'";
		
		return mysql_query($q);
		
	}
	
	function addUSer($username,$usermail,$scriptPath){
		
		$tmpRes = false;
		
		if($this->isLogged() && $this->isAdmin()){
			
			$username = $this->validate->userName($username);
			$usermail = $this->validate->userMail($usermail);
			
			if($this->validate->isValidEmail($usermail)){
				
				if(!$this->userExists($username)){
					
					$confirm = md5(str_shuffle(strtotime("now").mt_rand()));
					$q = "INSERT INTO zb_users_tmp VALUES('".$username."','".$usermail."','".$confirm."',CURDATE())";
					
					$tmpRes = mysql_query($q);
					
					if($tmpRes){
						
						$e = new email();
						$e->sendConfirmationMail($username,$usermail,$confirm,$scriptPath);
						
					}
					
					$this->setError(($tmpRes)? "An email has been sent to the user. <strong>He/she has to finish the registration process to use ZBooks</strong>.":"Problems either creating the temporal user or sending email confirmation. Please try later.");
					
				} else {
					
					$this->setError("Please choose another username, '".$username."' is already in use or is not a valid username.");
					
				}
				
			} else {
				
				$this->setError("Ummm... seems '".$newEmail."' is not a valid email, please try another one.");
				
			}
			
		}
		
		return $tmpRes;
		
	}
	
	function userExists($incomingUsername){
		
		$tmpRes = true;
		
		if($this->isLogged() && $this->isAdmin() && isset($incomingUsername) && $incomingUsername != ""){
			
			$incomingUsername = $this->validate->userName($incomingUsername);
			
			$q = "SELECT name FROM zb_users WHERE name='".$incomingUsername."'";
			$qDB = mysql_query($q);
			$tmpRes = (mysql_num_rows($qDB) == 0)? false:true;
			
			if(!$tmpRes){
				
				$q = "SELECT name FROM zb_users_tmp WHERE name='".$incomingUsername."'";
				$qDB = mysql_query($q);
				$tmpRes = (mysql_num_rows($qDB) == 0)? false:true;
				
			}
			
		}
		
		return $tmpRes;
		
	}
	
	function timeToBackup(){
		
		$tmpRes = false;
		
		if($this->isLogged() && $this->isAdmin()){
			
			$currentData = $this->getAdminData();			
			$tmpRes = (($currentData["autobackup"] == "1") && ((strtotime("now") + ($currentData["autobackupdays"]*60*60)) >= strtotime($currentData["lastbackup"])));
			
		}
		
		return $tmpRes;
	}
	
	function doBackup(){
		
		global $confObj;
		
		$tmpRes = false;
		
		if($this->isLogged() && $this->isAdmin()){
			
			if($this->timeToBackup()){
				
				$export = new export($confObj);
				$export->sqlExport();
				
			}
			
		}
		
		return $tmpRes;
		
	}
	
	function changeEmail($newEmail){
		
		$tmpVal = false;
		
		if($this->isLogged()){
			
			$newEmail = $this->validate->userMail($newEmail);
			
			if($this->validate->isValidEmail($newEmail)){
				
				$q = "UPDATE zb_users
						SET mail='".$newEmail."'
						WHERE user_id='".$this->getCurrentUserID()."'";
				
				$tmpVal = mysql_query($q);
				
				$this->setError(($tmpVal)? "Mail updated.":"Problems updating mail. Please try again.");
				
				if($tmpVal) $_SESSION["mail"] = $newEmail;
				
			} else {
				
				$this->setError("Ummm... seems '".$newEmail."' is not a valid email, please try another one.");
				
			}
			
		}
		
		return $tmpVal;
		
	}
	
	function changePassword($current,$newpass1,$newpass2){
		
		$tmpVal = false;
		
		if($this->isLogged()){
			
			if(isset($current) && $current != "" && isset($newpass1) && $newpass1 != "" && isset($newpass2) && $newpass2 != "" && $newpass1 == $newpass2){
				
				$current = $this->validate->userPassword($current);
				$newpass1 = $this->validate->userPassword($newpass1);
				$newpass2 = $this->validate->userPassword($newpass2);
				
				$userData = $this->getUserData($this->getCurrentUserID());
				
				if(md5($current) == $userData["password"]){
					
					$q = "UPDATE zb_users
							SET password='".md5($newpass1)."'
							WHERE user_id='".$this->getCurrentUserID()."'";
					
					$tmpVal = mysql_query($q);
					
					$this->setError(($tmpVal)? "Password updated.":"Problems updating password. Please try again.");
					
				} else {
					
					$this->setError("Current password is wrong.");
					
				}
				
			} else {
				
				$this->setError("Either passwords are empty or don't match.");
				
			}
			
		} else {
			
			$this->setError("You are not logged in.");
			
		}
		
		return $tmpVal;
		
	}
	
	function setCurrentUser($userData,$cookie){
		
		$_SESSION["admin"] = ($userData["admin"] == "1")? true:false;
		$_SESSION["logged"] = true;
		$_SESSION["user_id"] = $userData["user_id"];
		$_SESSION["name"] = $userData["name"];
		$_SESSION["mail"] = $userData["mail"];
		
		if(isset($cookie) && $cookie == "true") $this->addUserCookie($userData["name"]);
		
	}
	
	function getUserNameFromID($user_id){
		
		$q = "SELECT name FROM zb_users WHERE user_id='".$user_id."'";
		$qDB = mysql_query($q);
		$dat = mysql_fetch_array($qDB);
		return $dat["name"];
		
	}
	
	function getCurrentUser(){
		
		$tmpArr = array();
		$tmpArr["user_id"] = $_SESSION["user_id"];
		$tmpArr["admin"] = $_SESSION["admin"];
		$tmpArr["name"] = $_SESSION["name"];
		$tmpArr["mail"] = $_SESSION["mail"];
		
		return $tmpArr;
		
	}
	
	function validateUser($userName,$passWord,$cookie){
		
		$tmpVal = false;
		
		if(isset($userName) && $userName != "" && isset($passWord) && $passWord != ""){
			
			$tmpusr = $this->validate->userName($userName);
			$tmpass = $this->validate->userPassword($passWord);
			
			$q = "SELECT * FROM zb_users WHERE name='".$tmpusr."' AND password='".md5($tmpass)."'";
			$qDB = mysql_query($q);
			
			if(mysql_num_rows($qDB) == 1){
				
				$this->setCurrentUser(mysql_fetch_array($qDB),$cookie);				
				$tmpVal = true;
				
			} else {
				
				$this->logout();
				$this->setError("Error. User name and/or password invalid, please try again.");
				
			}
			
		} else {
			
			$this->logout();
			$this->setError("Error. User name and/or password invalid, please try again.");
			
		}
		
		return $tmpVal;
		
	}
	
	function getUserData($user_id){
		
		$tmpRes = false;
		
		if($this->isLogged()){
			
			$user_id = $this->validate->userID($user_id);
			
			$q = "SELECT * FROM zb_users WHERE user_id='".$user_id."'";
			$qDB = mysql_query($q);
			
			if(mysql_num_rows($qDB) == 1) $tmpRes = mysql_fetch_array($qDB);
			
		}
		
		return $tmpRes;
		
	}
	
	function validateUserByCookie(){
		
		$tmpVal = false;
		
		if($this->getCookie()){
			
			$tmpusr = $this->validate->userName($_COOKIE[$this->cookieName]);
			
			$q = "SELECT * FROM zb_users WHERE name='".$tmpusr."'";
			$qDB = mysql_query($q);
			
			if(mysql_num_rows($qDB) == 1){
				
				$this->setCurrentUser(mysql_fetch_array($qDB),"true");				
				$tmpVal = true;
				
			} else {
				
				$this->setError("We cannot find your user profile. Please contact the administrator to get an account.");
				
			}
			
		}
		
		return $tmpVal;
		
	}
	
	function logout(){
		
		$this->removeCookie();
		session_unset();
		session_destroy();
		
		$this->setError("You've correctly logged out.");
		
		return true;
		
	}
	
	function getAdminData(){
		
		$tmpError = "true";
		
		if($this->isLogged() && $this->isAdmin()){
			
			$q = "SELECT * FROM zb_admin";
			$qDB = mysql_query($q);
			return mysql_fetch_array($qDB);
			
		}
		
		return $tmpError;
		
	}
	
	function changeBackupOptions($_autobackup,$_backuponserver,$autobackupdays){
		
		$tmpRes = false;
		
		if($this->isLogged() && $this->isAdmin()){
			
			$autobackup = ($_autobackup == "true")? "1":"0";
			$backuponserver = ($_backuponserver == "true")? "1":"0";
			
			$currentData = $this->getAdminData();
			
			$q = "UPDATE zb_admin 
					SET autobackup='".$autobackup."',
					autobackupdays='".$autobackupdays."',
					lastbackup='".$currentData["lastbackup"]."',
					backuponserver='".$backuponserver."'";
			
			$tmpRes = mysql_query($q);
			
			$this->setError(($tmpRes)? "Options updated.":"Problems updating options. Please try again.");
			
		}
		
		return $tmpRes;
		
	}
	
	function updateConfigData($bookmarksTarget,$bookmarksNumber,$showURL){
		
		$tmpRes = false;
		
		if($this->isLogged()){
			
			$q = "UPDATE zb_config 
					SET linktarget='".$bookmarksTarget."',
					itemsPerPage='".$bookmarksNumber."', 
					showURL='".$showURL."' 
					WHERE user_id='".$this->getCurrentUserID()."'";
			
			$tmpRes = mysql_query($q);
			
			$this->setError(($tmpRes)? "Configuration updated.":"Problems updating configuration. Please try again.");
			
		} else {
			
			$this->setError("You are not logged in.");
			
		}
		
		return $tmpRes;
		
	}
	
	function getConfigData($user_id){
		
		$user_id = $this->validate->userID($user_id);
		
		if(!isset($$user_id)) $$user_id = "1";
		
		$q = sprintf("SELECT * FROM zb_config WHERE user_id='%1\$s'",$user_id);
		$qDB = mysql_query($q);
		return mysql_fetch_array($qDB);
		
	}
	
	function resetApp(){
		
		$tmpRes = false;
		
		if($this->isLogged()){
			
			$q = "TRUNCATE zb_bookmarks";
			$tmpRes = mysql_query($q);
			
			if($tmpRes){
				
				$q = "TRUNCATE zb_bookmarks_labels";
				$tmpRes = mysql_query($q);
				
			}
			
			if($tmpRes){
				
				$q = "TRUNCATE zb_labels";
				$tmpRes = mysql_query($q);
				
			}
			
			if($tmpRes){
				
				$q = "TRUNCATE zb_users_tmp";
				$tmpRes = mysql_query($q);
				
			}
			
			if($tmpRes){
				
				$q = "DELETE FROM zb_config WHERE user_id > 2";
				$tmpRes = mysql_query($q);
				
			}
			
			if($tmpRes){
				
				$q = "DELETE FROM zb_users WHERE user_id > 2";
				$tmpRes = mysql_query($q);
				
			}
			
			$this->setError(($tmpRes)? "No problems during the operation.":"Problems reseting ZBooks. Please try again.");
			
		} else {
			
			$this->setError("You are not logged in.");
			
		}
		
		return $tmpRes;
		
	}
	
	function addUserCookie($userName){
		
		if($this->isLogged()){
			setcookie($this->cookieName,$userName,time()+31536000,"/","",""); // 1 year cookie
		}
		
	}
	
	function removeCookie(){
		
		if($this->isLogged()){
			setcookie($this->cookieName,"",time()-1,"/","","");
		}
		
	}
	
	function isAdmin(){
		return $_SESSION["admin"];
	}
	
	function isLogged(){
		return $_SESSION["logged"];
	}
	
	function getCurrentUserID(){
		return $_SESSION["user_id"];
	}
	
	function getCookie(){
		return isset($_COOKIE[$this->cookieName]);
	}

	function setError($text){
		$this->errorString = $text;
	}
	
	function getError(){
		return $this->errorString;
	}
	
}

?>
<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


class sitePage{

	var $template = "";
	var $title = "";
	var $metas;
	var $js;
	var $error = false;
	var $smarty;
	var $conf;
	var $lang;
	var $basePath = "";
	var $WSPath = "";

	function sitePage($smarty,$conf){
		
		$this->smarty = $smarty;
		$this->conf = $conf;
		
		// TODO, dont use PHP_SELF here due security reasons, use appRoot instead.
		
		$this->basePath = substr($_SERVER['PHP_SELF'],0,strrpos($_SERVER['PHP_SELF'],"/")+1);
		$this->WSPath = $this->basePath."data.php";
		
	}

	function config($template,$pageTitle){
		
		$this->setTemplate($template);
		$this->setTitle($pageTitle);
		
	}
	
	function showCurrentUsers($users){
		
		while($userData = mysql_fetch_array($users)){
			
			$this->smarty->append('currentUsersData',array(
				'user_id' => $userData['user_id'],
				'name' => $userData['name']
			));
			
		}
		
	}
	
	function showTempUsers($users){
		
		while($userData = mysql_fetch_array($users)){
			
			$this->smarty->append('tempUsersData',array(
				'confirmation' => $userData['confirmation'],
				'name' => $userData['name'],
				'initDate' => $userData['initDate']
			));
			
		}
		
	}
	
	function setAdminTemplate($adminTemplate){
		$this->smarty->assign("adminTemplate",$adminTemplate);
	}
	
	function showAdminRightsWarning(){
		$this->smarty->assign("showAdminRightsWarning",true);
	}
	
	function showError($text,$result){
		
		$this->smarty->assign("showError",true);
		$this->smarty->assign("processError",$text);
		$this->smarty->assign("errorType",($result)? "processRight":"processWrong");
		
	}
	
	function showLoginData($user){
		
		$uData = $user->getCurrentUser();
		$this->smarty->assign("userID",$uData["user_id"]);
		$this->smarty->assign("userName",$uData["name"]);
		$this->smarty->assign("userEMail",$uData["mail"]);
		$this->smarty->assign("userAdmin",$uData["admin"]);
		$this->smarty->assign("logged",$user->isLogged());
		$this->smarty->assign("admin",$user->isAdmin());
		
	}
	
	function showBackupData($optionData){
		
		$this->smarty->assign("autobackup",($optionData["autobackup"] == "1")? "checked":"");
		$this->smarty->assign("backuponserver",($optionData["backuponserver"] == "1")? "checked":"");
		$this->smarty->assign("autobackupdays",$optionData["autobackupdays"]);
		
	}
	
	function showConfigData($optionData){
		
		$this->smarty->assign("bookmarksTarget",$optionData["linktarget"]);
		$this->smarty->assign("bookmarksNumber",$optionData["itemsPerPage"]);
		$this->smarty->assign("showURL",$optionData["showURL"]);
		
	}
	
	function setFlashVars(){
		
		$getVars = "fv_WSPath=".$this->getWSPath()."&";
		foreach($_GET as $key => $val){ $getVars .= "fv_".$key ."=". urlencode($val)."&"; }
		
		$getVars = substr($getVars,0,strlen($getVars)-1);
		
		$this->smarty->assign('flashvars',$getVars);
		
	}
	
	function display(){
		
		$this->smarty->assign("pageTitle",$this->conf->pageTitle.$this->getTitle());
		$this->smarty->display($this->getTemplate());
		
		@mysql_close();
		
	}
	
	/* getter / setter */
	function setTemplate($val){ $this->template = $val; }
	function getTemplate(){ return $this->template; }
	function setTitle($val){ $this->title = $val; }
	function getTitle(){ return $this->title; }
	function setMetas($val){ $this->metas = $val; }
	function getMetas(){ return $this->metas; }
	function getWSPath(){ return $this->WSPath; }
	
}

?>
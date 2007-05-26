<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


class lang{
	
	var $conf;
	
	function lang($conf){
		$this->conf = $conf;
	}
	
	function getLangs(){
		
		$q = "SELECT * FROM ".$this->conf->ZSite_lang." ORDER BY orden ASC";
		return mysql_query($q); 
		
	}
	
	function getTotalLangs(){
		
		$q = "SELECT COUNT(*) FROM ".$this->conf->ZSite_lang;		
		$qDB = mysql_query($q);
		return mysql_result($qDB,0);
		
	}
	
	function changeLang($newLang,$setCookie){
		
		$validate = new validate();
		$lID = $validate->langID($newLang);

		$q = sprintf("SELECT * FROM %s WHERE idCorto='%s'",$this->conf->ZSite_lang,$lID);
		$qDB = mysql_query($q);
		
		$_SESSION["siteLang"] = mysql_fetch_array($qDB);
		if($setCookie) $this->setLangCookie($this->getShortID(),true);
	}
	
	function setLangCookie($newLang,$action){
		
		$tmpTime = ($action)? $this->conf->cookieTime:-1;
		setcookie($this->conf->cookieLang,$newLang,time()+$tmpTime,"/","","");

	}
	
	function getCurrenntLang(){
		return $_SESSION["siteLang"];
	}
	
	function getLangCookie(){
		return (isset($_COOKIE[$this->conf->cookieLang]))? $_COOKIE[$this->conf->cookieLang]:false;  
	}
	
	function getLongID(){
		return $_SESSION["siteLang"]["idLargo"];
	}
	
	function getShortID(){
		return $_SESSION["siteLang"]["idCorto"];
	}
	
	function getLangFolder(){
		return $_SESSION["siteLang"]["carpeta"];
	}
	
	function currentLangID(){
		return $_SESSION["siteLang"]["id_idioma"];
	}
	
}

?>

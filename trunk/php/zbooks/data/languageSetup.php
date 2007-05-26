<?php
	
	if (!defined('IN_ZBOOKS') ){
		die("Hacking attempt");
	}
	
	if(isset($_REQUEST["newLang"])){
		
		$lang->changeLang($_REQUEST["newLang"],true);
		
	} else if(!isset($_SESSION["siteLang"]["idCorto"])){
		
		if($lang->getLangCookie()){
			$lang->changeLang($lang->getLangCookie(),false);
		} else {
			$lang->changeLang($confObj->defaultLang,false);
		}
		
	}
	
?>

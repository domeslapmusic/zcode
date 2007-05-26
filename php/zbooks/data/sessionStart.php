<?php

	if (!defined('IN_ZBOOKS') ){
		die("Hacking attempt");
	}

	session_start();

	if(!isset($_SESSION["started"])){

		$_SESSION["started"] = true;
		$_SESSION["admin"] = false;
		$_SESSION["logged"] = false;
		$_SESSION["user_id"] = 1;
		$_SESSION["name"] = 0;
		$_SESSION["mail"] = 0;
		$_SESSION["backupChecked"] = false;
		$_SESSION["key"] = getRandKey();

	}

	function getRandKey(){

		// thanks to Joan Garnet!
		// http://www.joangarnet.com/blog/?p=439

		srand(date("s"));

		$length = 32;
		$letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		$string = "";

		while(strlen($string)<$length){
			$string .= substr($letters,rand()%strlen($letters),1);
		}

		return $string;

	}

?>
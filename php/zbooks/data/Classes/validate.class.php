<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


class validate{

	var $usernameMaxLength = 25;
	var $passwordMaxLength = 32;
	var $confirmationKeyMaxLength = 32;
	var $MailMaxLength = 255;
	var $idMaxLength = 9;
	var $urlMaxLength = 250;
	var $titleMaxLength = 250;
	var $labelTitleMaxLength = 25;

	function validate(){}

	function userName($val){

		$res = substr($val,0,$this->usernameMaxLength);
		$res = strtolower($res);
		return mysql_real_escape_string($res);

	}

	function validateConfirmKey($val){
		return substr($val,0,$this->confirmationKeyMaxLength);
	}

	function userPassword($val){
		return substr($val,0,$this->passwordMaxLength);
	}

	function userID($val){

		$val = mysql_real_escape_string($val);
		return substr($val,0,$this->idMaxLength);

	}

	function userMail($val){
		return substr($val,0,$this->MailMaxLength);
	}

	function isValidEmail($email){
		return ($email != "")? true:false;
	}

	function privateAtt($val){
		return substr($val,0,1);
	}

	function url($val){

		$val = mysql_real_escape_string($val);
		return substr($val,0,$this->urlMaxLength);

	}

	function bookmarkId($val){

		$val = mysql_real_escape_string($val);
		return substr($val,0,$this->idMaxLength);

	}

	function labelId($val){

		$val = mysql_real_escape_string($val);
		return substr($val,0,$this->idMaxLength);

	}

	function labelTitle($val){

		$val = mysql_real_escape_string($val);
		return substr($val,0,$this->labelTitleMaxLength);

	}

	function bookmarkTitle($val){

		$val = mysql_real_escape_string($val);
		return substr($val,0,$this->titleMaxLength);

	}

	function bookmarkLabels($val){
		return mysql_real_escape_string($val);
	}

	function searchString($val){
		return mysql_real_escape_string($val);
	}

	function pageNumber($val){
		return $val;
	}

}

?>
<?php
	
	// take a look to this define('ABSPATH', dirname(__FILE__).'/');
	
	if (!defined('IN_ZBOOKS') ){
		die("Hacking attempt");
	}
	
	require_once("hacking.php");
	require_once("defineVariables.php");
	require_once("Classes/conf.class.php");
	require_once("sessionStart.php");
	require_once("dbConnect.php");
	
	// conf object
	$confObj = new conf(appRoot);
	
	// main classes
	require_once($confObj->classPath."Smarty/Smarty.class.php");
	require_once($confObj->classPath."mySmarty.class.php");
	require_once($confObj->classPath."sitePage.class.php");
	require_once($confObj->classPath."validate.class.php");
	require_once($confObj->classPath."user.class.php");

	$validate = new Validate();
	$smarty = new mySmarty($confObj->getTemplateFolder(),$confObj->getCompiledTemplateFolder());
	$user = new User($validate);
	$page = new sitePage($smarty,$confObj);
	
	require_once("checkUser.php");
	require_once("checkBackup.php");
	
?>
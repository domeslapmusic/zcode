<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}

require_once("fileManager.class.php");

class email{

	var $sep = " -- [@] -- ";
	
	function email(){}
	
	function sendConfirmationMail($username,$usermail,$confirm,$scriptPath){
		
		$content = $this->getHTMLEmail("confirmation");
		
		$searchArray = array("__CONFIRMATIONKEY__","__USERDOMAIN__","__CONFIRMATIONPAGE__");
		$replaceArray = array($confirm,$_SERVER["SERVER_NAME"],"http://".$_SERVER["SERVER_NAME"].$scriptPath);
		
		$content = str_replace($searchArray,$replaceArray,$content);
		
		$arrayTo = array();
		$arraySubject = array();
		$arrayBody = array();
		$arrayFrom = array();
		
		$arrayTo[] = $usermail;
		$arraySubject[] = "ZBooks account confirmation";
		$arrayBody[] = $content;
		$arrayFrom[] = "admin@domain.com";
		
		//$this->sendMail($arrayTo,$arraySubject,$arrayBody,$arrayFrom);
		
		//echo $content."<br></br>-------------------------------<br></br>";
		
	}
	
	function getHTMLEmail($type){
		
		global $confObj;
		
		$fileManager = new fileManager();
		
		switch($type){
			
			case("confirmation"):
				$filename = $confObj->getTemplateFolder()."mails/userConfirmation.htm";
				break;
			
		}
		
		return $fileManager->getFileContent($filename);
		
	}
	
	function sendMail($arrayTo,$arraySubject,$arrayBody,$arrayFrom){
		
		$tmpError = 0;
		$total = sizeof($arrayTo);
		
		for($a=0;$a<$total;$a++){
			
			if(!@mail($arrayTo[$a],$arraySubject[$a],$arrayBody[$a],"From: ".$arrayFrom[$a]."\nContent-Type: text/html; charset=iso-8859-1")){
				$tmpError += 1;
			}
			
		}
		
		//$this->setErrorNumber($tmpError);
		
	}
	
	/*
	function chageToNoBot($val){
		return str_replace("@",$this->sep,$val);
	}

	function splitEmail($val){
		
		$start = substr($val,0,strpos($val,"@"));
		$finish = substr($val,strpos($val,"@")+1,strlen($val));
		
		return array($start,$finish);
		
	}
	
	function sendUserContactMail($userName,$userMail,$userText){
		
		$arrayTo = array();
		$arraySubject = array();
		$arrayBody = array();
		$arrayFrom = array();
		
		$arrayTo[] = TSD_contactMail;
		$arraySubject[] = "molas";
		$arrayBody[] = $this->getMailHTML("toAdmin",$userName,$userMail,$userText);
		$arrayFrom[] = $userMail;
		
		if(sendFeedback){
			
			$arrayTo[] = $userMail;
			$arraySubject[] = "Thank god";
			$arrayBody[] = $this->getMailHTML("toUser",$userName,$userMail,$userText);
			$arrayFrom[] = TSD_contactMail;
			
		}
		
		$this->sendMail($arrayTo,$arraySubject,$arrayBody,$arrayFrom);
		
	}
	
	function getMailHTML($type,$userName,$userMail,$userText){
		
		global $lang;
		
		$file = ($type == "toUser")? "toUser.tpl":"toAdmin.tpl";
		$path = appRoot."data/Templates/".$lang->getLangFolder()."/mails/";
		$filename = $path.$file;
		
		$handle = fopen($filename,"rb");
		$contents = fread($handle,filesize($filename));
		fclose($handle);

		$searchArray = array("__USERNAME__","__USERMAIL__","__USERMESSAGE__");
		$replaceArray = array($userName,$userMail,$userText);
		
		return str_replace($searchArray,$replaceArray,$contents);
	
	}
	
	*/
}
?>

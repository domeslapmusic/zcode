<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


require_once("XPath.class.php");
require_once("fileManager.class.php");

class import{
	
	var $user_id;
	var $private;
	var $maxFileSize = 1048576; // 1 mb
	var $validExtensions = array("txt","sql","htm","html","xml");
	var $xmlOptions;
	var $xPath;
	var $confObj;
	var $fileManager;
	var $tmpImportFile;
	var $errorString = "Import successfull";
	
	function import($_confObj){
		
		$this->confObj = $_confObj;
		$this->fileManager = new fileManager();
		
		$this->xmlOptions = array(XML_OPTION_CASE_FOLDING => TRUE, XML_OPTION_SKIP_WHITE => TRUE);
		$this->xPath = new XPath(FALSE, $this->xmlOptions);
		
	}
	
	function importFromFile($userFile,$type,$user_id,$private){
		
		$this->user_id = $user_id;
		$this->private = ($private == "1")? "1":"0";
		
		$sqlString = $this->parseContent($this->uploadFile($userFile),$type,$this->user_id,$this->private);
		
		$this->sendToDB($sqlString);
		
		$this->fileManager->removeFile($this->tmpImportFile);
		
		return true;
		
	}
	
	function sendToDB($sqlString){
		
		foreach($sqlString as $val){
			
			mysql_query($val);
			
		}
		
	}
	
	function parseContent($filePath,$type,$user_id,$private){
		
		$sqlString;
		
		switch($type){
			
			case("delicious"):
				$sqlString = $this->parseDelicious($filePath,$user_id,$private);
				break;
			case("netscape"):
				$sqlString = $this->parseNetscape($filePath,$user_id,$private);
				break;
			
		}
		
		return $sqlString;
		
	}
	
	function parseDelicious($filePath,$user_id,$private){
		
		if(!$this->xPath->importFromFile($filePath)) { echo $this->xPath->getLastError(); exit; }
		
		$next = $this->getLastIDs();
		
		$tagCounter = $next["nextLabel"];
		$bookmarkCounter = $next["nextBookmark"];
		
		$myTags = array();
		$myBookmarks = array();
		$insert = array();
		
		$nodeSet = $this->xPath->match("/posts/post");
		
		foreach($nodeSet as $node){
			
			$attributes = $this->xPath->getAttributes($node);
			
			$title = htmlspecialchars(addslashes($attributes["DESCRIPTION"]));
			$url = $attributes["HREF"];
			$tags = htmlspecialchars(addslashes($attributes["TAG"]));
			$date = substr($attributes["TIME"],0,10);
			
			$tags = split(" ",$tags);
			
			foreach($tags as $tagTitle){
				
				if(!isset($myTags[$tagTitle])){
					
					$label_id = $tagCounter;
					
					$myTags[$tagTitle] = $tagCounter;
					$insert[] = $this->getLabelQuery($tagCounter,$user_id,$private,$tagTitle);
					$tagCounter++;
					
				} else {
					
					$label_id = $myTags[$tagTitle];
					
				}
				
				$insert[] = $this->getRelationQuery($bookmarkCounter,$label_id);
				
			}
			
			$insert[] = $this->getBookmarkQuery($bookmarkCounter,$user_id,$private,$title,$url,$date);
			
			$bookmarkCounter++;
			
		}
		
		return $insert;
		
	}
	
	function parseNetscape($filePath,$user_id,$private){
		
		$rawData = $this->getFileContents($filePath);
		
		$rawData = substr($rawData,strpos($rawData,"</H1>")+5,strlen($rawData));		
		$rawData = eregi_replace("<p>","",$rawData);
		$rawData = eregi_replace("<DT>","",$rawData);
		$rawData = eregi_replace("<DD>","",$rawData);
		$rawData = eregi_replace("<DL>","",$rawData);
		$rawData = eregi_replace("</DL>","",$rawData);
		$rawData = "<data>".$rawData."</data>";
		
		echo $rawData;
		
		if(!$this->xPath->importFromString($rawData)) { echo $this->xPath->getLastError(); exit; }
		
		/*
		//$nodeSet = $this->xPath->match("//DT");
		$nodeSet = $this->xPath->match("//H3");
		
		echo count($nodeSet)."<br>";
		
		foreach($nodeSet as $node){
			
			echo $node."<br>";
			
		}
		*/
	}
	
	function getFileContents($file){
		
		global $confObj;
		
		$filePath = $confObj->appRoot."www/zbooks/admin/".$file;
		
		$handle = fopen($filePath,"rb");		
		$contents = fread($handle,filesize($filePath));
		fclose($handle);
		
		return $contents;
		
	}
	
	function getBookmarkQuery($id,$user,$private,$title,$url,$date){
		return "INSERT INTO zb_bookmarks VALUES('".$id."','".$user."','".$private."','".$title."','".$url."','".$date."');";
	}
	
	function getRelationQuery($bookmar_id,$label_id){
		return "INSERT INTO zb_bookmarks_labels VALUES('".$bookmar_id."','".$label_id."');";
	}
	
	function getLabelQuery($label_id,$user,$private,$title){
		return "INSERT INTO zb_labels VALUES('".$label_id."','".$user."','".$private."','".$title."');";
	}
	
	function uploadFile($userFile){
		
		$tmpReturn = false;
		
		$fileName = strtolower($userFile["name"]);
		$fileSize = $userFile["size"];
		
		$lastDotPos = strrpos($fileName,".");
		$fileType = substr($fileName,$lastDotPos+1);
		
		if(in_array($fileType,$this->validExtensions)){
			
			if($fileSize < $this->maxFileSize){
				
				$this->tmpImportFile = $this->confObj->getTempPath()."imp_".$this->user_id;
				
				if($this->fileManager->copyFile($userFile["tmp_name"],$this->tmpImportFile)){
					
					$tmpReturn = $this->tmpImportFile;
					
				} else {
					
					$this->errorString = "Impossible to upload the file. Check that you have write rights in the tmp folder.";
					
				}
				
			} else {
				
				$this->errorString = "File too heavy.";
				
			}
			
		} else {
			
			$this->errorString = "Invalid file type.";
			
		}
		
		return $tmpReturn;
		
	}
	
	function getLastIDs(){
		
		//TODO change that to something like LAST_INSERT_ID()
		
		$q = "SELECT bookmark_id FROM zb_bookmarks ORDER BY bookmark_id DESC LIMIT 1";
		$qDB = mysql_query($q);
		$lastBookmark = mysql_fetch_array($qDB);
		
		$q = "SELECT label_id FROM zb_labels ORDER BY label_id DESC LIMIT 1";
		$qDB = mysql_query($q);
		$lastLabel = mysql_fetch_array($qDB);
		
		return array("nextBookmark" => ($lastBookmark["bookmark_id"]+1), "nextLabel" => ($lastLabel["label_id"]+1));
		
		
	}
	
	function setError($text){
		$this->errorString = $text;
	}
	
	function getError(){
		return $this->errorString;
	}
	
}

?>
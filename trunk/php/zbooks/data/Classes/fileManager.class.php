<?php 

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


class fileManager{

	function fileManager(){}
	
	function copyFile($fileName,$copyTo){
		return @copy($fileName,$copyTo);
	}
	
	function createFile($fileName){
		
		
		
	}
	
	function removeFile($fileName){
		unlink($fileName);
	}

	function getFileContent($fileNamex){
		
		$fileHandle = fopen($fileNamex,"rb");
		$contents = fread($fileHandle,filesize($fileNamex));
		fclose($fileHandle);
		return $contents;
		
	}
	
}

?>
<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


class export{
	
	var $conf;
	
	function export($_conf){
		$this->conf = $_conf;
	}
	
	function sqlExport(){
		
		$rawSQL = "jajajajajajaja";
		
		$handle = $this->getFile();
		$this->writeFile($handle,$rawSQL);
		
	}
	
	function getFile(){
		
		$tmpfname = $this->conf->getTempPath()."wadus";
		return fopen($tmpfname,"w");
		
	}
	
	function writeFile($handle,$content){
		
		fwrite($handle,$content);
		fclose($handle);
		
	}
	
}

?>
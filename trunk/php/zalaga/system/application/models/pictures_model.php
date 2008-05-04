<?php

class Pictures_model extends Model{
	
	var $picturesFolder = "";
	
	public function Pictures_model(){
		
		parent::Model();
		$this->load->helper('file');
		
		$scriptPath = split("/",__FILE__);
		$scriptPath = array_splice($scriptPath,0,count($scriptPath)-4);
		
		$this->picturesFolder = implode("/",$scriptPath)."/pictures/";
		
	}
	
	public function getFolders($params){
		
		$initPath = $this->picturesFolder.$params;
		
		$folders = array();
		
		if($handle = opendir($initPath)){
			
			while(false !== ($folder = readdir($handle))){
				
				$folderPath = $initPath."/".$folder;
				
				if(is_dir($folderPath) && $folder != "." && $folder != ".."){ $folders[] = $folder; }
				
			}
			
			closedir($handle);
			
		}
		
		return $folders;
		
	}
	
	public function getFiles($params){
		
		$initPath = $this->picturesFolder.$params;
		
		$files = array();
		
		if($handle = opendir($initPath)){
			
			while(false !== ($file = readdir($handle))){
				
				$filePath = $initPath."/".$file;
				
				if(is_file($filePath)){ $files[] = $file; }
				
			}
			
			closedir($handle);
			
		}
		
		return $files;
		
	}
	
}

?>
<?php

class Image extends Controller{

	var $fullSizeToken = "full";

	public function Image(){
		
		parent::Controller();
		
		$this->load->helper('url');
		$this->load->model("Pictures_model");
		
	}
	
	public function _remap(){
		
		$token = "image/";
		$urlPath = $this->uri->uri_string();
		
		$lastSlashPos = strripos($urlPath,"/");
		$lastSegment = substr($urlPath,$lastSlashPos+1);
		
		$fullsize = ($lastSegment == $this->fullSizeToken);
		
		if($fullsize){
			
			$urlPath = substr($urlPath,0,$lastSlashPos);
			
		}
		
		$pos = strrpos($urlPath,$token)+strlen($token);
		
		$actualPath = substr($urlPath,$pos);
		
		$imgPath = $this->Pictures_model->picturesFolder.$actualPath;
		
		$originalImg = imagecreatefromjpeg($imgPath);
		
		if(!$originalImg){
			
			echo "Cannot find image";
			
		} else {
			
			header('Content-type: image/jpeg');
			
			if(!$fullsize){
				
				$width = 100;
				$height = 100;
				
				list($width_orig,$height_orig) = getimagesize($imgPath);
				
				$ratio_orig = $width_orig/$height_orig;
				
				if($width/$height > $ratio_orig){
					$width = $height*$ratio_orig;
				} else {
					$height = $width/$ratio_orig;
				}
				
				$copyImage = imagecreatetruecolor($width,$height);
				//imagecopyresampled($copyImage,$originalImg,0,0,0,0,$width,$height,$width_orig,$height_orig);
				imagecopyresized($copyImage,$originalImg,0,0,0,0,$width,$height,$width_orig,$height_orig);
				
				imagejpeg($copyImage,null,100);
				
				
			} else {
				
				imagejpeg($originalImg,null,100);
				
			}
			
		}
		
	}
	
}
?>
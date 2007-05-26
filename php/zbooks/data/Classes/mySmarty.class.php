<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


class mySmarty extends Smarty {

	function mySmarty($templates,$compiled){
	
		$this->template_dir = $templates;
		$this->compile_dir = $compiled;
		$this->caching = false;
		
	}
	
}
	
?>
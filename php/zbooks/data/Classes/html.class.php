<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


require("Xpath.class.php");

class html{
	
	var $xmlOptions;
	var $xPath;
	var $smarty;
	var $WSPath;
	var $config;
	var $user_id;
	var $label_id;
	
	function html($smarty,$WSPath,$user_id,$label_id){
		
		$this->smarty = $smarty;
		$this->xmlOptions = array(XML_OPTION_CASE_FOLDING => false, XML_OPTION_SKIP_WHITE => true);
		$this->xPath = new XPath(false,$this->xmlOptions);
		$this->WSPath = $WSPath;
		
		$this->user_id = $user_id;
		$this->label_id = $label_id;
		
		$this->getConfig();
		
	}
	
	function getConfig(){
		
		if(!$this->xPath->importFromFile($this->WSPath."?action=getConfig&user_id=".$this->user_id)) { echo $this->xPath->getLastError(); exit; }
		
		$node = $this->xPath->match("/data/config");
		
		$attributes = $this->xPath->getAttributes($node[0]);
		
		$this->config["username"] = $attributes["username"];
		$this->config["edit"] = $attributes["edit"];
		$this->config["defaultTarget"] = $attributes["defaultTarget"];
		$this->config["showURL"] = $attributes["showURL"];
		
		$this->xPath->reset();
		
	}
	
	function displayPage(){
		
		$q = $this->WSPath."?user_id=".$this->user_id.(($this->label_id)? "&label_id=".$this->label_id:"");
		
		if(!$this->xPath->importFromFile($q)) { echo $this->xPath->getLastError(); exit; }
		
		$this->displayBookmarks();
		$this->displayLabels();
		$this->displayOther();
		
	}
	
	function displayBookmarks(){
		
		$nodeSet = $this->xPath->match("/data/label/bookmarks/bookmark");
		
		foreach($nodeSet as $node){
			
			$attributes = $this->xPath->getAttributes($node);
			
			$title = $this->xPath->wholeText($node."/title[1]");
			$url = $this->xPath->wholeText($node."/url[1]");
			
			$this->smarty->append('booksData',array(
				'title' => $title,
				'url' => $url
			));
			
		}
		
	}
	
	function displayLabels(){
		
		$nodeSet = $this->xPath->match("/data/labels/label");
		
		foreach($nodeSet as $node){
			
			$attributes = $this->xPath->getAttributes($node);
			
			$title = $this->xPath->wholeText($node);
			$id = $attributes["id"];
			
			$this->smarty->append('labelsData',array(
				'title' => $title,
				'id' => $id
			));
			
		}
		
	}
	
	function displayOther(){
		
		$this->smarty->assign("username",$this->config["username"]);
		$this->smarty->assign("user_id",$this->user_id);
		
	}
	
}

?>
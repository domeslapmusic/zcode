<?php

class Article_model extends Model{
	
	function Article_model(){
		
		parent::Model();
		
	}
	
	function getAllItems(){
		
		$q = $this->db->get("article");
		return $q;
		
	}
	
}

?>
<?php

class Article_model extends Model{
	
	public function Article_model(){
		
		parent::Model();
		
	}
	
	public function getAllItems(){
		
		$this->db->select("*");
		$this->db->from("article");
		$this->db->join("article_literals","article.article_id=article_literals.article_id");
		$this->db->where("article_literals.language_id='".$this->session->userdata('language_id')."'");
		$this->db->orderby("article.date","desc");
		
		$q = $this->db->get();
		
		return $q;
		
	}
	
}

?>
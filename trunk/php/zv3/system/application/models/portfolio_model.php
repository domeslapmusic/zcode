<?php

class Portfolio_model extends Model{
	
	function Portfolio_model(){
		
		parent::Model();
		
	}
	
	function getAllItems(){
		
		$this->db->select("*");
		$this->db->from("portfolio");
		$this->db->join("portfolio_literals","portfolio.portfolio_id=portfolio_literals.portfolio_id");
		$this->db->where("portfolio_literals.language_id='".$this->session->userdata('language_id')."'");
		$q = $this->db->get();
		
		return $q;
		
	}
	
	function getPortfolio($portfolio_id){
		
		$this->db->select("*");
		$this->db->from("portfolio");
		$this->db->join("portfolio_literals","portfolio.portfolio_id = portfolio_literals.portfolio_id");
		$this->db->where("portfolio.portfolio_id=".$portfolio_id);
		$q = $this->db->get();
		
		return $q;
		
	}

}

?>
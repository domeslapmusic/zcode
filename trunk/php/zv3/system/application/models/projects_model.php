<?php

class Projects_model extends Model{
	
	function Projects_model(){
		
		parent::Model();
		
	}
	
	function getAllItems(){
		
		$this->db->select("*");
		$this->db->from("project");
		$this->db->join("project_literals","project.project_id=project_literals.project_id");
		$this->db->where("project_literals.language_id='".$this->session->userdata('language_id')."'");
		$q = $this->db->get();
		
		return $q;
		
	}
	
}

?>
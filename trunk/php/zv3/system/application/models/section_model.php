<?php

class Section_model extends Model{
	
	var $currentSection;
	
	public function Section_model(){
		
		parent::Model();
		
		$this->load->model('Portfolio_model');
		$this->load->model('Projects_model');
		$this->load->model('Article_model');
		
	}
	
	public function getCurrentSection(){
		
		$session_section_id = $this->session->userdata('section_id');
		
		$section = (isset($session_section_id) && $session_section_id != "")? $this->getSectionByID($session_section_id) : $this->getDefaultRewrite();
		return $section;
		
	}
	
	public function setSectionByID($section_id){
		
		$this->db->select("*");
		$this->db->from("section");
		$this->db->join("section_literals","section.section_id=section_literals.section_id");
		$this->db->where("section.section_id='".$section_id."'");
		$q = $this->db->get();
		
		$this->currentSection = $q->row();
		
		$this->session->set_userdata('section_id',$this->currentSection->section_id);
		
	}
	
	public function getSectionFromRewrite($rewrite){
		
		if(!isset($rewrite) || $rewrite == ""){
			
			$defaultSection = $this->getDefaultRewrite();
			$rewrite = $defaultSection->rewrite;
			
		}
		
		$this->db->select("*");
		$this->db->from("section");
		$this->db->join("section_literals","section.section_id=section_literals.section_id");
		$this->db->where("section_literals.rewrite='".$rewrite."'");
		$q = $this->db->get();
		
		$section = $q->row();
		
		if($section->option != ""){
			
			$section->options = array();
			
			switch($section->option){
				
				case("portfolio"):
					
					$options = $this->Portfolio_model->getAllItems();
					break;
					
				case("project"):
					
					$options = $this->Projects_model->getAllItems();
					break;
					
				case("article"):
					
					$options = $this->Article_model->getAllItems();
					break;
					
			}
			
			foreach($options->result() as $option){ 
				$section->options[] = $option; 
			}
			
		}
		
		return $section;
		
	}
	
	public function getSections($showOptions = false){
		
		$sections = array();
		
		$this->db->select("*");
		$this->db->from("section");
		$this->db->join("section_literals","section.section_id = section_literals.section_id");
		$this->db->where("section_literals.language_id='".$this->session->userdata('language_id')."'");
		$this->db->orderby("position","asc");
		$q = $this->db->get();
		
		foreach($q->result() as $section){
			
			if($showOptions == true){
				
				switch($section->section_id){
					
					case(2): // portfolio
					case(3): // projects
					case(10): // articles
						
						$section->options = array();
						
						$options = ($section->section_id == 2)? $this->Portfolio_model->getAllItems() : (($section->section_id == 3)? $this->Projects_model->getAllItems() : $this->Article_model->getAllItems());
						
						foreach($options->result() as $option){ $section->options[] = $option; }
						
						break;
					
				}
				
			}
			
			array_push($sections,$section);
			
		}
		
		$this->currentSection = $sections;
		
		return $sections;
		
	}

	// *********************** PRIVATE METHODS ***********************

	private function getSectionByID($section_id){
		
		$this->db->select("*");
		$this->db->from("section");
		$this->db->join("section_literals","section.section_id=section_literals.section_id");
		$this->db->where("section.section_id='".$section_id."'");
		$q = $this->db->get();
		
		return $q->row();
		
	}

	private function getDefaultRewrite(){
		
		$this->db->select("*");
		$this->db->from("section");
		$this->db->join("section_literals","section.section_id=section_literals.section_id");
		$this->db->where("section_literals.language_id='".$this->session->userdata('language_id')."'");
		$this->db->orderby("position","asc");
		$q = $this->db->get();
		
		return $q->row();
		
	}

}

?>
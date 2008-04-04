<?php

/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

class Section_model extends Model{
	
	var $currentSection;
	var $forceHTML = false;
	
	public function Section_model(){
		
		parent::Model();
		
		$this->load->model('Portfolio_model');
		$this->load->model('Projects_model');
		$this->load->model('Article_model');
		
		$this->load->library('validate');
		
	}
	
	public function getForceHTML(){
		
		$sesionForceHTML = $this->session->userdata('forceHTML');
		return ($sesionForceHTML != "")? $sesionForceHTML:$this->forceHTML;
		
	}
	
	public function isUniqueRewrite($rewrite){
		
		$this->db->select("rewrite");
		$this->db->from("section_literals");
		$this->db->where("rewrite='".$rewrite."'");
		
		$total = $this->db->count_all_results();
		
		$res = ($total == 1)? true:false;
		
		return $res;
		
	}
	
	public function getCurrentSection(){
		
		$session_section_id = $this->session->userdata('section_id');
		
		$section = (isset($session_section_id) && $session_section_id != "")? $this->getSectionByID($session_section_id) : $this->getDefaultRewrite();
		return $section;
		
	}
	
	public function setSectionByID($section_id){
		
		$validate = array();
		$validate['input_type'] = 'value';
		$validate[] = array('input'=>$section_id,'rules'=>'maximum:8|required');
		
		if($this->validate->run($validate)){
			
			$this->db->select("*");
			$this->db->from("section");
			$this->db->join("section_literals","section.section_id=section_literals.section_id");
			$this->db->where("section.section_id='".$section_id."' AND section_literals.language_id='".$this->session->userdata('language_id')."'");
			$q = $this->db->get();
			
			$this->currentSection = $q->row();
			
			$this->session->set_userdata('section_id',$this->currentSection->section_id);
			
		}
		
	}
	
	public function setSectionFromRewrite($rewrite,$unique=false){
		
		if(!isset($rewrite) || $rewrite == "" || $rewrite == "html" || $rewrite == "flash"){
			
			if($rewrite == "html" || $rewrite == "flash"){
				
				$this->session->set_userdata('forceHTML',($rewrite == "html")?true:false);
				
			}
			
			$defaultSection = $this->getDefaultRewrite();
			$rewrite = $defaultSection->rewrite;
			
		}
		
		$this->db->select("*");
		$this->db->from("section");
		$this->db->join("section_literals","section.section_id=section_literals.section_id");
		
		if($unique){
			
			$this->db->where("section_literals.rewrite='".$rewrite."'");
			
		} else {
			
			$this->db->where("section_literals.rewrite='".$rewrite."' AND section_literals.language_id='".$this->session->userdata('language_id')."'");
			
		}
		
		$q = $this->db->get();
		
		$section = false;
		
		if($q->num_rows() > 0){
			
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
			
			$this->currentSection = $section;
			$this->session->set_userdata('section_id',$this->currentSection->section_id);
			
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
		
		$section = false;
		
		$validate = array();
		$validate['input_type'] = 'value';
		$validate[] = array('input'=>$section_id,'rules'=>'maximum:8|required');
		
		if($this->validate->run($validate)){
			
			$this->db->select("*");
			$this->db->from("section");
			$this->db->join("section_literals","section.section_id=section_literals.section_id");
			$this->db->where("section.section_id='".$section_id."' AND section_literals.language_id='".$this->session->userdata('language_id')."'");
			$q = $this->db->get();
			
			$section = $q->row();
			
		}
		
		return $section;
		
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
<?php

/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
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
<?php

class Section extends Controller{

	public function Section(){
		
		parent::Controller();
		
		//$this->output->enable_profiler(TRUE);
		
		$this->load->helper('url');
		$this->load->model('Section_model');
		
		
	}
	
	public function _remap($method){
		
		$this->load->model('Language_model');
		$this->Language_model->checkLanguage();
		
		$sectionRewrite = ($this->Language_model->IsNewLanguage())? "" : $this->uri->segment(1);
		
		$this->lang->load('misc',$this->session->userdata('language_folder'));
		
		$data["misc_flash_warning"] = $this->lang->line('misc_flash_warning');
		
		$data["section"] = $this->Section_model->getSectionFromRewrite($sectionRewrite);
		$data["sections"] = $this->Section_model->getSections(false);
		$data["languages"] = $this->Language_model->getLanguages();
		
		$this->load->view('sectionview',$data);
		
	}
	
}
?>
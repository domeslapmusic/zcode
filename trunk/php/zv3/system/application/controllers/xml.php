<?php

class Xml extends Controller{

	public function Xml(){
		
		parent::Controller();
		
	}
	
	public function index(){
		
		$this->load->model('Section_model');
		$this->load->model('Language_model');
		
		$data["currentSection"] = $this->Section_model->getCurrentSection();
		$data["sections"] = $this->Section_model->getSections(true);
		$data["languages"] = $this->Language_model->getLanguages();
		
		$this->load->view('xmlview',$data);
		
	}

}
?>
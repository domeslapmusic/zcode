<?php

class Flashgateway extends Controller{

	public function Flashgateway(){
		
		parent::Controller();
		
	}
	
	public function _remap(){
		
		switch($this->input->post('action')){
			
			case("mail"):
				
				$this->load->library('email');
				
				$this->email->from('wadus@wadus.com','Wadus');
				$this->email->to('zzzarate@gmail.com');
				$this->email->subject('Contact from ZV3');
				$this->email->message($this->input->post('text'));
				
				$data["success"] = ($this->email->send())? "true":"false";
				
				break;
				
			case("changelanguage"):
				
				$this->load->model('Language_model');
				$this->load->model('Section_model');
				
				$this->Section_model->setSectionByID($this->input->post('section_id'));
				
				$data["success"] = ($this->Language_model->setLanguageByID($this->input->post('language_id'))) ? "true":"false";
				
				break;
			
		}
		
		$this->load->view('flashgatewayview',$data);
		
	}

}
?>
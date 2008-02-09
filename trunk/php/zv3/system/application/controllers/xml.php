<?php

class Xml extends Controller{

	public function Xml(){
		
		parent::Controller();
		
	}
	
	public function index(){
		
		$this->load->model('Section_model');
		$this->load->model('Language_model');
		
		$this->Language_model->checkLanguage();
		
		$data["currentSection"] = $this->Section_model->getCurrentSection();
		$data["sections"] = $this->Section_model->getSections(true);
		$data["languages"] = $this->Language_model->getLanguages();
		
		$this->lang->load('flash',$this->session->userdata('language_folder'));
		
		$data["literals"] = array();
		
		// TODO reading flash_lang lines and creating this values should be automatic
		$data["literals"]["want_to_send_email"] = $this->lang->line('flash_want_to_send_email');
		$data["literals"]["sending_email"] = $this->lang->line('flash_sending_email');
		$data["literals"]["mail_sent_ok"] = $this->lang->line('flash_mail_sent_ok');
		$data["literals"]["mail_sent_problem"] = $this->lang->line('flash_mail_sent_problem');
		$data["literals"]["space_warning"] = $this->lang->line('flash_space_warning');
		
		$this->load->view('xmlview',$data);
		
	}

}
?>
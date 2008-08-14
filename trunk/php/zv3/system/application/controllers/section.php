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

class Section extends Controller{

	public function Section(){
		
		parent::Controller();
		
		//$this->output->enable_profiler(TRUE);
		
		$this->load->helper('url');
		$this->load->model('Section_model');
		
	}
	
	public function _remap($method){
		
		$this->load->model('Language_model');
		$data["language"] = $this->Language_model->checkLanguage();
		
		$sectionRewrite = ($this->Language_model->IsNewLanguage())? "" : $this->uri->segment(1);
		
		$this->lang->load('misc',$this->session->userdata('language_folder'));
		
		$data["misc_flash_warning"] = $this->lang->line('misc_flash_warning');
		$data["misc_freak_warning"] = $this->lang->line('misc_freak_warning');
		
		$data["section"] = $this->Section_model->setSectionFromRewrite($sectionRewrite);
		
		if($data["section"] == false){
			
			$this->lang->load('error',$this->session->userdata('language_folder'));
			
			$data["section"]->title = "Error 404";
			$data["section"]->summary = $this->lang->line('error_notfound');
			$data["section"]->section_id = "";
			
		}
		
		$data["sections"] = $this->Section_model->getSections(false);
		$data["languages"] = $this->Language_model->getLanguages();
		
		$data["forceHTML"] = $this->Section_model->getForceHTML();
		
		$data["contentView"] = 'sectionview';
		
		$data["pageCss"] = array("zwebv3.css");
		$data["pageJS"] = array("swfobject.js","zwebv3.js");
		
		$data["secondaryTitle"] = $data["section"]->title;
		
		$data["forceMenu"] = false;
		
		$this->load->view('commonview',$data);
		
	}
	
}
?>
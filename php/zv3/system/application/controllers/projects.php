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

class Projects extends Controller{

	public function Projects(){
		
		parent::Controller();
		
		//$this->output->enable_profiler(TRUE);
		
		$this->load->helper('url');
		$this->load->model('Language_model');
		$this->load->model('Projects_model');
		$this->load->model('Section_model');
		
	}
	
	public function index(){
		
		$data["language"] = $this->Language_model->checkLanguage();
		
		$sectionRewrite = ($this->Language_model->IsNewLanguage())? "" : $this->uri->segment(1);
		
		$this->lang->load('misc',$this->session->userdata('language_folder'));
		
		$data["misc_freak_warning"] = $this->lang->line('misc_freak_warning');
		
		$data["section"] = $this->Section_model->setSectionFromRewrite($sectionRewrite);
		$data["sections"] = $this->Section_model->getSections(false);
		
		$data["contentView"] = 'projectview';
		
		$data["project"] = $this->Projects_model->getProjectFromRewrite($this->uri->segment(2));
		
		if($data["project"] == false){
			
			$this->lang->load('error',$this->session->userdata('language_folder'));
			
			$data["project"]->template = "404";
			$data["project"]->loaded = false;
			$projectCss = "projects.css";
			
		} else {
			
			$data["project"]->loaded = true;
			$data["project"]->template = "projects/".$data["project"]->rewrite."_".$data["language"]->shortID;
			$projectCss = ($data["project"]->css != "")? $data["project"]->css:"projects.css";
			$data["secondaryTitle"] = $data["project"]->title;
			
		}
		
		$data["pageCss"] = array($projectCss);
		$data["pageJS"] = array("JSCommon.js","swfobject.js");
		
		$data["forceMenu"] = true;
		
		$this->load->view('commonview',$data);
		
	}
	
}
?>
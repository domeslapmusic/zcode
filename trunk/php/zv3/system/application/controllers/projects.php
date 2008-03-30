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
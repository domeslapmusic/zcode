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

class Articles extends Controller{

	public function Articles(){
		
		parent::Controller();
		
		//$this->output->enable_profiler(TRUE);
		
		$this->load->helper('url');
		$this->load->model('Language_model');
		$this->load->model('Article_model');
		$this->load->model('Section_model');
		
	}
	
	public function index(){
		
		$data["language"] = $this->Language_model->checkLanguage();
		
		$sectionRewrite = ($this->Language_model->IsNewLanguage())? "" : $this->uri->segment(1);
		
		$this->lang->load('misc',$this->session->userdata('language_folder'));
		
		$data["misc_freak_warning"] = $this->lang->line('misc_freak_warning');
		
		$data["section"] = $this->Section_model->setSectionFromRewrite($sectionRewrite);
		$data["sections"] = $this->Section_model->getSections(false);
		
		$data["contentView"] = 'articleview';
		
		$data["pageCss"] = array("articles.css");
		
		$data["article"] = $this->Article_model->getArticleByRewrite($this->uri->segment(2));
		
		if($data["article"] == false){
			
			$data["article"]->title = "Error 404";
			$data["article"]->template = "404";
			$data["article"]->loaded = false;
			
		} else{
			
			$data["article"]->loaded = true;
			$data["article"]->template = "articles/".$data["article"]->rewrite;
			
		}
		
		$data["secondaryTitle"] = $data["article"]->title;
		
		$data["forceMenu"] = true;
		
		$this->load->view('commonview',$data);
		
	}
	
}
?>
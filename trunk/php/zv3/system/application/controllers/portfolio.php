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

class Portfolio extends Controller{

	public function Portfolio(){
		
		parent::Controller();
		
		//$this->output->enable_profiler(TRUE);
		
		$this->load->helper('url');
		$this->load->model('Language_model');
		$this->load->model('Portfolio_model');
		$this->load->model('Section_model');
		
	}
	
	public function index(){
		
		$data["language"] = $this->Language_model->checkLanguage();
		
		$sectionRewrite = ($this->Language_model->IsNewLanguage())? "" : $this->uri->segment(1);
		
		$this->lang->load('misc',$this->session->userdata('language_folder'));
		
		$data["misc_freak_warning"] = $this->lang->line('misc_freak_warning');
		
		$data["section"] = $this->Section_model->setSectionFromRewrite($sectionRewrite);
		$data["sections"] = $this->Section_model->getSections(false);
		
		$data["contentView"] = 'portfolioview';
		
		$data["portfolio"] = $this->Portfolio_model->getPortfolioFromRewrite($this->uri->segment(2));
		
		if($data["portfolio"] == false){
			
			$data["portfolio"]->template = "404";
			$data["portfolio"]->loaded = false;
			$css = "portfolio.css";
			
		} else {
			
			$data["portfolio"]->loaded = true;
			$data["portfolio"]->template = "portfolio/".$data["portfolio"]->rewrite."_".$data["language"]->shortID;
			$css = ($data["portfolio"]->css != "")? $data["portfolio"]->css:"portfolio.css";
			
		}
		
		$data["pageCss"] = array($css);
		$data["pageJS"] = array("JSCommon.js","swfobject.js");
		
		$data["forceMenu"] = true;
		
		$this->load->view('commonview',$data);
		
	}
	
}
?>
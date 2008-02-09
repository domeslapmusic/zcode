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
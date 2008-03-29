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

class Xml extends Controller{

	public function Xml(){
		
		parent::Controller();
		
	}
	
	public function index(){
		
		ob_start();
		
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
		
		// Can you believe this?? After years of dynamic xml driven applications i didn't know this:
		// You have to send length header, otherwise xml.getBytesLoaded() doesn't work properly.
		// And it's just in the reference:
		// http://livedocs.adobe.com/flash/8/main/00002869.html#wp513747
		
		$size=ob_get_length();
		
		header("Content-Length: $size");
		header("Content-Type: text/xml");
		
		ob_end_flush();
		
	}

}
?>
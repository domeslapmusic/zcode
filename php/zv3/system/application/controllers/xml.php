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
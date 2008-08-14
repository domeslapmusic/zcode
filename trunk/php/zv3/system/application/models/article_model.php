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

class Article_model extends Model{
	
	public function Article_model(){
		
		parent::Model();
		
		$this->load->library('validate');
		
	}
	
	public function getArticleByRewrite($rewrite){
		
		$article = false;
		
		$validate = array();
		$validate['input_type'] = 'value';
		$validate[] = array('input'=>$rewrite,'rules'=>'maximum:250|required');
		
		if($this->validate->run($validate)){
			
			$this->db->select("*");
			$this->db->from("article");
			$this->db->join("article_literals","article.article_id=article_literals.article_id");
			$this->db->where("article_literals.rewrite='".$rewrite."' AND article_literals.language_id='".$this->session->userdata('language_id')."'");
			
			$q = $this->db->get();
			
			if($q->num_rows() > 0){
				
				$article = $q->row();
				
			}
			
		}
		
		return $article;
		
	}
	
	public function getAllItems(){
		
		$this->db->select("*");
		$this->db->from("article");
		$this->db->join("article_literals","article.article_id=article_literals.article_id");
		$this->db->where("article_literals.language_id='".$this->session->userdata('language_id')."'");
		$this->db->orderby("article.date","desc");
		
		$q = $this->db->get();
		
		return $q;
		
	}
	
}

?>
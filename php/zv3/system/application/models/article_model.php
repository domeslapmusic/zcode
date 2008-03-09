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

class Article_model extends Model{
	
	public function Article_model(){
		
		parent::Model();
		
	}
	
	public function getArticleByRewrite($rewrite){
		
		$this->db->select("*");
		$this->db->from("article");
		$this->db->join("article_literals","article.article_id=article_literals.article_id");
		$this->db->where("article_literals.rewrite='".$rewrite."' AND article_literals.language_id='".$this->session->userdata('language_id')."'");
		
		$q = $this->db->get();
		
		return $q->row();
		
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
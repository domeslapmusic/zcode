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

class Portfolio_model extends Model{
	
	function Portfolio_model(){
		
		parent::Model();
		
	}
	
	function getAllItems(){
		
		$this->db->select("*");
		$this->db->from("portfolio");
		$this->db->join("portfolio_literals","portfolio.portfolio_id=portfolio_literals.portfolio_id");
		$this->db->where("portfolio_literals.language_id='".$this->session->userdata('language_id')."' AND portfolio.active='1'");
		$this->db->orderby("portfolio.position","desc");
		$q = $this->db->get();
		
		return $q;
		
	}
	
	function getPortfolio($portfolio_id){
		
		$this->db->select("*");
		$this->db->from("portfolio");
		$this->db->join("portfolio_literals","portfolio.portfolio_id = portfolio_literals.portfolio_id");
		$this->db->where("portfolio.portfolio_id='".$portfolio_id."' AND portfolio.active='1'");
		$q = $this->db->get();
		
		return $q;
		
	}

}

?>
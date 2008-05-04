<?php

class Zalaga extends Controller{

	public function Zalaga(){
		
		parent::Controller();
		
		$this->load->helper('url');
		$this->load->model("Pictures_model");
		
	}
	
	public function _remap(){
		
		$breadcrumbs = $this->uri->segment_array();
		//$breadcrumbs= array_slice($breadcrumbs,0,count($breadcrumbs)-1);
		
		$params = $this->uri->uri_string();
		
		$pagepos = strrpos($params,"page");
		
		$page = 1;
		
		if($pagepos){
			
			$params = substr($params,0,$pagepos-1);
			$page = $this->uri->segment($this->uri->total_segments());
			
			$breadcrumbs = array_slice($breadcrumbs,0,count($breadcrumbs)-2);
			
		}
		
		$data["folders"] = $this->Pictures_model->getFolders($params);
		$allfiles = $this->Pictures_model->getFiles($params);
		
		$perpage = 10;
		
		$init = ($page-1) * $perpage;
		
		$data["page"] = $page;
		$data["totalpages"] = ceil(count($allfiles)/$perpage);
		
		$data["files"] = array_slice($allfiles,$init,$perpage);
		$data["initPath"] = $params;
		
		$data["breadcrumbs"] = $breadcrumbs;
		
		$this->load->view('commonview',$data);
		
	}
	
}
?>
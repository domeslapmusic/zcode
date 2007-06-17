<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}

require_once("validate.class.php");

class data{

	var $itemsPerPage = 10;
	var $currentPage = 1;
	var $totalPages = 1;
	var $totalBookmarks = 0;
	var $label_id = "";
	var $user;
	var $errorText = "";
	var $labelSeparator = ",";
	var $userConfig;
	var $validate;

	function data($user){

		$this->validate = new validate();
		$this->user = $user;
		$this->userConfig = $this->user->getConfigData($this->user->getCurrentUserID());
		$this->itemsPerPage = $this->userConfig["itemsPerPage"];

	}

	function search($str,$userFrom_id,$page){

		$userFrom_id = $this->validate->userID($userFrom_id);
		$str = "%".$this->validate->searchString($str)."%";

		$init = ($page-1) * $this->itemsPerPage;
		$end = $init + $this->itemsPerPage;

		$qCount = sprintf("SELECT COUNT(*) FROM zb_bookmarks
				WHERE title LIKE '%1\$s' OR url LIKE '%1\$s' AND ".$this->getWhereUserString($userFrom_id),$str);

		$this->totalBookmarks = mysql_result(mysql_query($qCount),0);

		$q = sprintf("SELECT * FROM zb_bookmarks
				WHERE title LIKE '%1\$s' OR url LIKE '%1\$s' AND ".$this->getWhereUserString($userFrom_id)." LIMIT ".$init.",".$end."",$str);

		$result = mysql_query($q);

		$this->currentPage = $page;
		$this->totalPages = ceil($this->totalBookmarks/$this->itemsPerPage);

		return $result;

	}

	function removeBookmark($bookmark_id){

		$error = "true";
		$this->errorText = "Problems trying to remove the bookmark.";

		$bookmark_id = $this->validate->bookmarkId($bookmark_id);

		if($this->canManage($bookmark_id,"bookmark")){

			$q = sprintf("DELETE FROM zb_bookmarks WHERE bookmark_id='%1\$s'",$bookmark_id);

			if(mysql_query($q)){

				$q = sprintf("DELETE FROM zb_bookmarks_labels WHERE bookmark_id='%1\$s'",$bookmark_id);
				if(mysql_query($q)) $error = "false";

				$this->errorText = "Bookmark removed.";
				$this->removeVoidLabels();

			}

		}

		return $error;

	}

	function removeVoidLabels(){



	}

	function editBookmark($bookmark_id,$private,$url,$title,$labels){

		$error = "true";
		$this->errorText = "Problems trying to edit the bookmark.";

		$bookmark_id = $this->validate->bookmarkId($bookmark_id);
		$private = $this->validate->privateAtt($private);
		$url = $this->validate->url($url);
		$title = $this->validate->bookmarkTitle($title);
		$labels = $this->validate->bookmarkLabels($labels);

		if($this->canManage($bookmark_id,"bookmark")){

			$qDelete = sprintf("DELETE FROM zb_bookmarks_labels WHERE bookmark_id='%s'",
						$bookmark_id);

			if(mysql_query($qDelete)){

				$labels_ids = $this->getLabelsForBookmark($labels);

				$q = sprintf("UPDATE zb_bookmarks
						SET bookmark_id='%1\$s',
							user_id='%2\$s',
							private='%3\$s',
							title='%4\$s',
							url='%5\$s',
							date = CURDATE()
						WHERE bookmark_id = '%1\$s'",
						$bookmark_id,
						$this->user->getCurrentUserID(),
						$private,
						$title,
						$url);

				if(mysql_query($q)){

					$error = "false";
					$this->errorText = "Bookmark updated.";

					foreach($labels_ids as $val){

						if(!$this->addRelationship($bookmark_id,$val)){

							$error = "true";
							break;

						}

					}

				}

			}

		} else {

			$this->errorText = "You have NO rights for this item.";

		}

		return $error;

	}

	function addBookmark($private,$url,$title,$labels){

		$error = "true";
		$this->errorText = "Bookmark not added.";

		if($this->user->isLogged()){

			$private = $this->validate->privateAtt($private);
			$url = $this->validate->url($url);
			$title = $this->validate->bookmarkTitle($title);
			$labels = $this->validate->bookmarkLabels($labels);

			$labels_ids = $this->getLabelsForBookmark($labels);

			$q = sprintf("INSERT INTO zb_bookmarks VALUES('','%1\$s','%2\$s','%3\$s','%4\$s',CURDATE())",
					$this->user->getCurrentUserID(),
					$private,
					$title,
					$url);

			if(mysql_query($q)){

				$error = "false";
				$this->errorText = "Bookmark added properly.";

				$bookmarkID = mysql_insert_id();

				foreach($labels_ids as $val){

					if(!$this->addRelationship($bookmarkID,$val)){

						$error = "true";
						$this->errorText = "Bookmark not added, problem with relations.";
						break;

					}

				}

			} else {

				$error = "true";

			}

		} else {

			$this->errorText = "You must be logged in to add items.";

		}

		return $error;

	}

	function getBookmarkFromID($bookmark_id){

		$tmpRes = false;

		$bookmark_id = $this->validate->bookmarkId($bookmark_id);

		$q = sprintf("SELECT * FROM zb_bookmarks WHERE bookmark_id='%1\$s'",$bookmark_id);
		if($qDB = mysql_query($q)) $tmpRes = mysql_fetch_array($qDB);
		return $tmpRes;

	}

	function getLabelsForBookmark($labels){

		$labels_id = array();
		$labels = strtolower($labels);
		$arr = split($this->labelSeparator,$labels);

		$lng = count($arr);

		if($lng > 0){

			foreach($arr as $val){

				$val = trim($val);

				$labData = $this->getLabelFromTitle($val);

				if($labData){

					$labels_id[] = $labData["label_id"];

				} else {

					$lastID = $this->addLabel($val,"0");
					if($lastID) $labels_id[] = $lastID;

				}

			}

		}

		return $labels_id;

	}

	function getLabelFromTitle($title){

		$title = strtolower($title);
		$q = "SELECT label_id FROM zb_labels WHERE title='".$title."' AND user_id='".$this->user->getCurrentUserID()."'";

		if($qDB = mysql_query($q)) return mysql_fetch_array($qDB);
		return false;

	}

	function addLabel($title,$private){

		if($this->user->isLogged()){

			$title = $this->validate->labelTitle($title);

			if($title == "" || !isset($title)){ return false; }

			$title = strtolower($title);
			$q = "INSERT INTO zb_labels VALUES('','".$this->user->getCurrentUserID()."','".$private."','".$title."')";

			if(mysql_query($q)){ return mysql_insert_id(); }

		}

		return false;

	}

	function addRelationship($bookmark_id,$label_id){

		$bookmark_id = $this->validate->bookmarkId($bookmark_id);
		$label_id = $this->validate->labelId($label_id);

		$q = sprintf("INSERT INTO zb_bookmarks_labels VALUES('%1\$s','%2\$s')",
						$bookmark_id,
						$label_id);

		return mysql_query($q);

	}

	function setLabelAndPage($label_id,$currentPage,$userFrom_id){

		$label_id = $this->validate->labelId($label_id);
		$currentPage = $this->validate->pageNumber($currentPage);
		$userFrom_id = $this->validate->userID($userFrom_id);

		if(isset($currentPage)) $this->currentPage = $currentPage;
		$this->setTotalBookmarks($label_id,$userFrom_id);
		$this->setTotalPages();

	}

	function getLabelData($label_id){

		if(isset($label_id) && $label_id != "0"){

			$label_id = $this->validate->labelId($label_id);

			$q = sprintf("SELECT * FROM zb_labels WHERE label_id='%1\$s'",$label_id);

			$qDB = mysql_query($q);
			return mysql_fetch_array($qDB);

		} else {

			$tmp = array();
			$tmp["title"] = "Main";

			return $tmp;

		}

	}

	function getLabelBookmarks($label_id,$userFrom_id){

		$userFrom_id = $this->validate->userID($userFrom_id);

		if(isset($label_id) && $label_id != "0"){

			$label_id = $this->validate->labelId($label_id);

			$q = sprintf("SELECT * FROM zb_bookmarks, zb_bookmarks_labels
				WHERE zb_bookmarks.bookmark_id = zb_bookmarks_labels.bookmark_id AND zb_bookmarks_labels.label_id='%1\$s' AND ".$this->getWhereUserString($userFrom_id)."
				ORDER BY zb_bookmarks.date DESC
				LIMIT ".$this->getInit().",".$this->itemsPerPage."",$label_id);

		} else {

			$q = sprintf("SELECT * FROM zb_bookmarks
					WHERE %1\$s
					ORDER BY date DESC
					LIMIT ".$this->getInit().",".$this->itemsPerPage."",$this->getWhereUserString($userFrom_id));

		}

		return mysql_query($q);

	}

	function getBookmarkLabels($bookmark_id){

		$bookmark_id = $this->validate->bookmarkId($bookmark_id);

		$q = sprintf("SELECT * FROM zb_bookmarks_labels,zb_labels
				WHERE zb_bookmarks_labels.bookmark_id='%1\$s' AND zb_labels.label_id=zb_bookmarks_labels.label_id",$bookmark_id);

		return mysql_query($q);

	}

	function getLabels($userFrom_id){

		$userFrom_id = $this->validate->userID($userFrom_id);

		$q = sprintf("SELECT * FROM zb_labels
				WHERE %1\$s
				ORDER BY title ASC",$this->getWhereUserString($userFrom_id));

		return mysql_query($q);

	}

	function setTotalBookmarks($label_id,$userFrom_id){

		$userFrom_id = $this->validate->userID($userFrom_id);

		if(isset($label_id) && $label_id != "0"){

			$label_id = $this->validate->labelId($label_id);

			$q = sprintf("SELECT COUNT(*) FROM zb_bookmarks, zb_bookmarks_labels
				WHERE zb_bookmarks.bookmark_id=zb_bookmarks_labels.bookmark_id AND zb_bookmarks_labels.label_id='%1\$s'",$label_id);

		} else {

			$q = sprintf("SELECT COUNT(*) FROM zb_bookmarks
					WHERE %1\$s",$this->getWhereUserString($userFrom_id));

		}

		$this->totalBookmarks = mysql_result(mysql_query($q),0);

	}

	function getBookmarksOwner($user_id){
		return $this->user->getUserNameFromID($user_id);
	}

	function getTotalBookmarks(){
		return $this->totalBookmarks;
	}

	function setTotalPages(){
		$this->totalPages = ceil($this->getTotalBookmarks()/$this->itemsPerPage);
	}

	function getTotalPages($label_id){
		return $this->totalPages;
	}

	function getInit(){
		return ($this->currentPage-1)*$this->itemsPerPage;
	}

	function canManage($id,$type){

		$tmpRes = false;

		switch($type){

			case("bookmark"):
				$bookData = $this->getBookmarkFromID($id);
				$tmpRes = $this->isOwner($bookData["user_id"]);
				break;

		}

		return $tmpRes;

	}

	function getWhereUserString($userFrom_id){

		$userFrom_id = $this->validate->userID($userFrom_id);

		if(!isset($userFrom_id)) $userFrom_id = $this->user->getCurrentUserID();
		return ($this->isOwner($userFrom_id))? " user_id='".$userFrom_id."' ":" user_id='".$userFrom_id."' AND private='0' ";

	}

	function isOwner($userFrom_id){

		$userFrom_id = $this->validate->userID($userFrom_id);
		return ($userFrom_id == $this->user->getCurrentUserID() && $this->user->isLogged());

	}

	function getErrorText(){
		return $this->errorText;
	}

}

?>
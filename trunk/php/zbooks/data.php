<?php

	define('IN_ZBOOKS',true);
	define("appRoot","./");

	require_once(appRoot."data/setup.php");
	require_once($confObj->getClassPath()."data.class.php");

	$error = "false";
	$myData = new data($user);

	$page->config("data.xml","");

	header("Content-type:text/xml");

	switch($_GET["action"]){

		case("add"):

			$error = $myData->addBookmark($_GET["private"],$_GET["url"],$_GET["title"],$_GET["label"]);
			break;

		case("edit"):

			$error = $myData->editBookmark($_GET["bookmark_id"],$_GET["private"],$_GET["url"],$_GET["title"],$_GET["label"]);
			break;

		case("remove"):

			$error = $myData->removeBookmark($_GET["bookmark_id"]);
			break;

		case("search"):

			$searchRes = $myData->search($_GET["query"],$_GET["user_id"]);
			populateBookmarks($searchRes);

			$labelsDB = $myData->getLabels($_GET["user_id"]);
			populateLabels($labelsDB);
			populateItems();

			$page->smarty->assign("labelTitle",'Search results for "'.stripslashes($_GET["query"]).'"');
			$page->smarty->assign("labelId","0");

			break;

		case("getConfig"):

			$userConfig = $user->getConfigData($user->getCurrentUserID());

			$tmpEdit = ($user->isLogged() && $_GET["user_id"] == $user->getCurrentUserID())? "true":"false";

			$page->smarty->assign("username",$user->getUserNameFromID($userConfig["user_id"]));
			$page->smarty->assign("edit",$tmpEdit);
			$page->smarty->assign("defaultTarget",$userConfig["linktarget"]);
			$page->smarty->assign("showURL",$userConfig["showURL"]);
			$page->smarty->assign("user_id",$userConfig["user_id"]);
			$page->smarty->assign("key",$_SESSION["key"]);

			break;

		case("logout"):

			$res = $user->logout();

			$error = ($res)? "true":"false";
			$myData->errorText = $user->getError();

			break;

		case("login"):

			$res = $user->validateUser($_GET["username"],$_GET["password"],"false");

			$error = ($res)? "true":"false";
			$myData->errorText = $user->getError();

			break;

		default:

			$myData->setLabelAndPage($_GET["label_id"],$_GET["currentPage"],$_GET["user_id"]);

			$bookmarksData = $myData->getLabelBookmarks($_GET["label_id"],$_GET["user_id"]);
			populateBookmarks($bookmarksData);

			$labelsDB = $myData->getLabels($_GET["user_id"]);
			populateLabels($labelsDB);
			populateItems();

			break;

	}

	function populateBookmarks($bookmarksData){

		global $myData,$page;

		while($books = mysql_fetch_array($bookmarksData)){

			$labelsDB = $myData->getBookmarkLabels($books['bookmark_id']);

			while($labels = mysql_fetch_array($labelsDB)){ $labelsStr .= $labels["label_id"].$myData->labelSeparator; }
			$labelsStr = substr($labelsStr,0,strlen($labelsStr)-1);

			$page->smarty->append('booksData',array(
				'bookmark_id' => $books['bookmark_id'],
				'title' => urlencode(stripslashes($books['title'])),
				'url' => urlencode(stripslashes($books['url'])),
				'date' => $books['date'],
				'private' => $books['private'],
				'labels' => urlencode($labelsStr)
			));

			$labelsStr = "";

		}

	}

	function populateLabels($labelsDB){

		global $page,$myData;

		while($labels = mysql_fetch_array($labelsDB)){

			$page->smarty->append('labelsData',array(
				'title' => urlencode(stripslashes($labels['title'])),
				'label_id' => $labels['label_id'],
				'date' => $labels['date'],
				'private' => $labels['private']
			));

		}

		$labelData = $myData->getLabelData($_GET["label_id"]);
		$page->smarty->assign("labelTitle",stripslashes($labelData["title"]));
		$page->smarty->assign("labelId",$labelData["label_id"]);

	}

	function populateItems(){

		global $myData, $page;

		$page->smarty->assign("currentPage",(isset($_GET["currentPage"])? $_GET["currentPage"]:1));
		$page->smarty->assign("totalBookmarks",$myData->getTotalBookmarks($_GET["label_id"]));
		$page->smarty->assign("totalPages",$myData->getTotalPages($_GET["label_id"]));
		$page->smarty->assign("owner",$myData->getBookmarksOwner($_GET["user_id"]));

	}

	$page->smarty->assign("error",$error);
	$page->smarty->assign("errorText",$myData->getErrorText());
	$page->smarty->assign("action",$_GET["action"]);

	$page->display();

?>
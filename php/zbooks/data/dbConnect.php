<?php

	if (!defined('IN_ZBOOKS') ){
		die("Hacking attempt");
	}

	if(!mysql_connect(HOST,USER,PASS)){
		die("Impossible to connect with the server.");
	}

	if(!mysql_select_db(DB)){
		die("Impossible to select the database.");
	}

?>
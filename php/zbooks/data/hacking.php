<?php

	/***************************************************************************
	 *
	 *   This program is free software; you can redistribute it and/or modify
	 *   it under the terms of the GNU General Public License as published by
	 *   the Free Software Foundation; either version 2 of the License, or
	 *   (at your option) any later version.
	 *
	 ***************************************************************************/


	/* IMPORTANT NOTE
	
	Hello there. This basically copy + paste from the common.php file of phpBB forums system to prevent some hacking attempts.
	I don't want to attribute code to myself whatsoever and I also want to (have to) follow the original GPL license, 
	therefore this code is under the same GPL licence.
	
	A big thank you to the phpBB crew and its contributors.
	http://phpbb.com
	
	*/

	if (!defined('IN_ZBOOKS') ){
		die("Hacking attempt");
	}

	// The following code (unsetting globals)
	// Thanks to Matt Kavanagh and Stefan Esser for providing feedback as well as patch files

	// PHP5 with register_long_arrays off?
	if (@phpversion() >= '5.0.0' && (!@ini_get('register_long_arrays') || @ini_get('register_long_arrays') == '0' || strtolower(@ini_get('register_long_arrays')) == 'off'))
	{
		$HTTP_POST_VARS = $_POST;
		$HTTP_GET_VARS = $_GET;
		$HTTP_SERVER_VARS = $_SERVER;
		$HTTP_COOKIE_VARS = $_COOKIE;
		$HTTP_ENV_VARS = $_ENV;
		$HTTP_POST_FILES = $_FILES;

		// _SESSION is the only superglobal which is conditionally set
		if (isset($_SESSION))
		{
			$HTTP_SESSION_VARS = $_SESSION;
		}
	}

	// Protect against GLOBALS tricks
	if (isset($HTTP_POST_VARS['GLOBALS']) || isset($HTTP_POST_FILES['GLOBALS']) || isset($HTTP_GET_VARS['GLOBALS']) || isset($HTTP_COOKIE_VARS['GLOBALS']))
	{
		die("Hacking attempt");
	}

	// Protect against HTTP_SESSION_VARS tricks
	if (isset($HTTP_SESSION_VARS) && !is_array($HTTP_SESSION_VARS))
	{
		die("Hacking attempt");
	}

	if (@ini_get('register_globals') == '1' || strtolower(@ini_get('register_globals')) == 'on')
	{
		// PHP4+ path
		$not_unset = array('HTTP_GET_VARS', 'HTTP_POST_VARS', 'HTTP_COOKIE_VARS', 'HTTP_SERVER_VARS', 'HTTP_SESSION_VARS', 'HTTP_ENV_VARS', 'HTTP_POST_FILES', 'phpEx', 'phpbb_root_path');

		// Not only will array_merge give a warning if a parameter
		// is not an array, it will actually fail. So we check if
		// HTTP_SESSION_VARS has been initialised.
		if (!isset($HTTP_SESSION_VARS) || !is_array($HTTP_SESSION_VARS))
		{
			$HTTP_SESSION_VARS = array();
		}

		// Merge all into one extremely huge array; unset
		// this later
		$input = array_merge($HTTP_GET_VARS, $HTTP_POST_VARS, $HTTP_COOKIE_VARS, $HTTP_SERVER_VARS, $HTTP_SESSION_VARS, $HTTP_ENV_VARS, $HTTP_POST_FILES);

		unset($input['input']);
		unset($input['not_unset']);

		while (list($var,) = @each($input))
		{
			if (in_array($var, $not_unset))
			{
				die('Hacking attempt!');
			}
			unset($$var);
		}

		unset($input);
	}

	//
	// addslashes to vars if magic_quotes_gpc is off
	// this is a security precaution to prevent someone
	// trying to break out of a SQL statement.
	//
	if( !get_magic_quotes_gpc() )
	{
		if( is_array($HTTP_GET_VARS) )
		{
			while( list($k, $v) = each($HTTP_GET_VARS) )
			{
				if( is_array($HTTP_GET_VARS[$k]) )
				{
					while( list($k2, $v2) = each($HTTP_GET_VARS[$k]) )
					{
						$HTTP_GET_VARS[$k][$k2] = addslashes($v2);
					}
					@reset($HTTP_GET_VARS[$k]);
				}
				else
				{
					$HTTP_GET_VARS[$k] = addslashes($v);
				}
			}
			@reset($HTTP_GET_VARS);
		}

		if( is_array($HTTP_POST_VARS) )
		{
			while( list($k, $v) = each($HTTP_POST_VARS) )
			{
				if( is_array($HTTP_POST_VARS[$k]) )
				{
					while( list($k2, $v2) = each($HTTP_POST_VARS[$k]) )
					{
						$HTTP_POST_VARS[$k][$k2] = addslashes($v2);
					}
					@reset($HTTP_POST_VARS[$k]);
				}
				else
				{
					$HTTP_POST_VARS[$k] = addslashes($v);
				}
			}
			@reset($HTTP_POST_VARS);
		}

		if( is_array($HTTP_COOKIE_VARS) )
		{
			while( list($k, $v) = each($HTTP_COOKIE_VARS) )
			{
				if( is_array($HTTP_COOKIE_VARS[$k]) )
				{
					while( list($k2, $v2) = each($HTTP_COOKIE_VARS[$k]) )
					{
						$HTTP_COOKIE_VARS[$k][$k2] = addslashes($v2);
					}
					@reset($HTTP_COOKIE_VARS[$k]);
				}
				else
				{
					$HTTP_COOKIE_VARS[$k] = addslashes($v);
				}
			}
			@reset($HTTP_COOKIE_VARS);
		}
	}
	
	
?>
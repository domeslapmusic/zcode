<?php
class Validate
{
	var $_ci; // for the CI functionality 
	var $_rules_path; // path to functions
	var $_rules_separator; // 
	var $_param_start; //
	var $_param_separator; //
	var $_error_files; // array of files needed for the error messages
	var $error_array; //
	
	function Validate($glob_settings = NULL)
	{
		// get CI object for the use of CI related classes
		$this->_ci =& get_instance();
		$glob_settings_is_array = is_array($glob_settings);
		// set the rules path
		if($glob_settings_is_array && 
			array_key_exists('rulespath',$glob_settings) &&
			is_dir($glob_settings['rulespath']))
		{
			$this->_rules_path = $glob_settings['rulespath'];
		}
		else
		{
			$this->_rules_path = APPPATH.'helpers/validate_rules/'; // default path
		}
		//  set array of error files
		$this->_error_files[] = 'validate'; // default error file
		if($glob_settings_is_array && 
			(is_string($glob_settings['error_files']) ||
			 is_array($glob_settings['error_files'])))
		{
			// probably the most used option
			if(is_string($glob_settings['error_files'])) 
			{
				$this->_error_files[] = $glob_settings['error_files'];
			}
			else
			{
				// you have to add the default file to the error_files array but it allows you to have custom messages for the default rules without
				// changing the provided error file
				$this->_error_files = array_intersect($glob_settings['error_files'],$this->_error_files);
			}
		}
		// set rules separator
		if($glob_settings_is_array &&
			is_string($glob_settings['rules_separator']))
		{
			$this->_rules_separator = $glob_settings['rules_separator'];
		}
		else
		{
			$this->_rules_separator = '|';
		}
		// set rule parameter start
		$this->_param_start = ':';
		// set rule parameter separator
		$this->_param_separator = ',';
	}
	
	/*
	*  validate one or more inputs
	*
	* @param array
	* @return boolean
	*/
	function run($settings = array())
	{
	    // no array or array content no validation
		if(!is_array($settings) || (is_array($settings) && count($settings) == 0))
		{
			return FALSE;
		}
		// check if a general input type is set
		$general_input_type = '';
		if(array_key_exists('input_type',$settings))
		{
			$general_input_type = $settings['input_type'];
			unset($settings['input_type']);
		}
		// set error string
		$this->error_array = array();
		// start  the validation
		foreach($settings as $input)
		{
			// no input or rules no validation
			if(!is_array($input) ||
				(is_array($input) && !isset($input['input'])) ||
				!isset($input['rules']))
			{
				continue;
			}
			// set input type for validation rule
			$input_type = (isset($input['input_type']))?$input['input_type']:(($general_input_type != '')? $general_input_type:'value');
			//split the rules
			$rules = explode($this->_rules_separator,$input['rules']);
			// if required is not added to the rules and there is no value the rules aren't validated
			switch($input_type)
			{
				case 'post': $value = $_POST[$input['input']]; break;
				case 'get': $value = $_GET[$input['input']]; break;
				case 'file': $value = $_FILES[$input['input']]['tmp_name']; break;
				case 'cookie': $value = $_COOKIE[$input['input']]; break;
				default : $value = $input['input']; break;
			}
			If(!in_array('required',$rules) && 
				((is_array($value) && count($value) == 0) ||
				(is_string($value) && $value == '')))
			{
				continue;
			}
			// load error messages and define error string
			foreach($this->_error_files as $error_file)
			{
				$this->_ci->lang->load($error_file);
			}
			// loop through the rules
			$methodcount = 0;
			foreach($rules as $rule)
			{
				// check if it's the special method rule
				if(strncmp('method',$rule,6) == 0)
				{
					$pos = strpos($rule,$this->_param_start);
					if($pos !== FALSE)
					{
						$param_array = explode($this->_param_separator,substr($rule,$pos+1));
						if(count($param_array) < 2)
						{
							$this->error_array[] = 'Method rule must have at least two parameters';
						}
						else
						{
							list($class,$method) = $param_array;
							$args = false;
							if(count($param_array)>2)
							{
								$param = array_slice($param_array,2);
								$args = true;
							}
							
							if(!class_exists($class))
							{
								$this->error_array[] = $class.' class isn\'t loaded';
								continue;
							}
							
							if(!method_exists($class,$method))
							{
								$this->error_array[] = $method.' method of the '.$class.' class isn\'t found';
								continue;
							}
							
							$errored = FALSE;
							if($args)
							{
								if(!call_user_func_array(array(&$class,$method),$param))
								{
									$errored = TRUE;
								}
							}
							else
							{
								if(!call_user_func(array($class,$method)))
								{
									$errored = TRUE;
								}
							}
							
							if($errored === TRUE)
							{
								if(!isset($input['rule_errors']['method'][$methodcount]))
								{
									$this->error_array[] = 'Method rule error must be added. Rule for '.$method.' method of the '.$class.' class';
								}
								else
								{
									if(!strpos($input['rule_errors']['method'][$methodcount],' '))
									{
											$error = $this->_ci->lang->line('validate_'.$input['rule_errors']['method'][$methodcount]);
										$this->error_array[] = ($error === FALSE)?'No line for method rule error '.$input['rule_errors']['method'][$methodcount]:$error;
									
										
									}
									else
									{
										$this->error_array[] = $input['rule_errors']['method'][$methodcount];
									}
								}
							}
						}
					}
					else
					{
						$this->error_array[] = 'Method rule must have at least two parameters';
					}
					$methodcount++;
				}
				else
				{
					// default array passed to function
					$param_array = array($input['input'],$input_type);
					// check if the rule has parameters and add them to the func_array if there are
					$pos = strpos($rule,$this->_param_start);
					if($pos !== FALSE)
					{
						$param_array = array_merge($param_array,explode($this->_param_separator,substr($rule,$pos+1)));
						$rule = substr($rule,0,$pos);
					}
					//var_dump($rule);
					// validate the rule
					
					if(is_file($this->_rules_path.'validate_'.$rule.EXT))
					{
						include_once($this->_rules_path.'validate_'.$rule.EXT);
						//var_dump(function_exists('validate_'.$rule));
						if(!call_user_func_array('validate_'.$rule,$param_array))
						{
							if(isset($input['rule_errors'][$rule]))
							{
								if(!strpos($input['rule_errors'][$rule],' '))
								{
									$error = $this->_ci->lang->line('validate_'.$input['rule_errors'][$rule]);
									$this->error_array[] = ($error === FALSE)?'No line for error '.$input['rule_errors'][$rule]:$error;
			
								}
								else
								{
									$this->error_array[] = $input['rule_errors'][$rule];
								}
							}
							else
							{
								$error = $this->_ci->lang->line('validate_'.$rule);
								$this->error_array[] = ($error === FALSE)?'No line for error '.$rule:$error;
							}
						}
					}
					else
					{
						$this->error_array[] = 'No validate function matches '.$rule;
					}
				}
			}
		}
		
		return (count($this->error_array) == 0)? TRUE: FALSE;
		
	}
	
	/*
	* load one or more rules
	*
	* @param : string or array
	* @return : boolean
	*/
	function load_rules($rule)
	{
		if(is_array($rule))
		{
			foreach($rule as $file)
			{
				if(is_file($this->_rules_path.'validate_'.$file.EXT))
				{
					include_once($this->_rules_path.'validate_'.$file.EXT);
				}
				else
				{
					return FALSE;
				}
			}
			return TRUE;
		}
		
		if(is_string($rule))
		{
			if(is_file($this->_rules_path.'validate_'.$rule.EXT))
			{
				include_once($this->_rules_path.'validate_'.$rule.EXT);
				return TRUE;
			}
		}
		
		return FALSE;
	}
}

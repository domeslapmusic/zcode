<?php
// common rule for $_POST,$_GET, $_COOKIE input
function validate_string($input,$input_type = 'value',$exact = 1)
{
    switch($input_type)
    {
        case 'post':
            if(!isset($_POST[$input]))
            {
                return FALSE;
            }
            else
            {
                $value = $_POST[$input];
            }
            break;
        case 'get':
            if(!isset($_GET[$input]))
            {
                return FALSE;
            }
            else
            {
                $value = $_GET[$input];
            }
            break;
        case 'cookie':
            if(!isset($_COOKIE[$input]))
            {
                return FALSE;
            }
            else
            {
                $value = $_COOKIE[$input];
            }
            break;
        default:
            $value = $input;
            break;
    }
    
    if(!is_string($value)){
	return FALSE;
    }
    
    // if all checks are passed the input is good
    return TRUE;
    
}
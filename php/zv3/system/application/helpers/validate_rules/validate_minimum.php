<?php
// common rule for $_POST, $_GET, $_COOKIE and direct input
function validate_minimum($input,$input_type = 'value',$minimum = 1)
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
    // foolproofing minimum value
    if(!is_numeric($minimum))
    {
        return FALSE;
    }
    // checks to confirm is the minimum is reached
    if(is_array($value) && count($value) < $minimum)
    {
        return FALSE;
    }
    
    if(is_string($value) && strlen($value) < $minimum)
    {
        return FALSE;
    }
    // if all checks are passed the input is good
    return TRUE;
}
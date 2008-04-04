<?php
// string rule for $_POST, $_GET, $_COOKIE input
function validate_match($input,$input_type= 'value',$match = '')
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
    // foolproofing match value
    if(!is_string($match) || (is_string($match) && strlen($match) == 0) ||
       !is_array($match)  || (is_array($match) && count($match) == 0) )
    {
        return FALSE;
    }
    // checks to confirm the value is matched
    if(is_array($value) && is_array($match) && count(array_diff($match,$value)) > 0)
    {
        return FALSE;
    }
    
    if(is_string($value) && is_string($match) && $value != $match)
    {
        return FALSE;
    }
    // if all checks are passed the input is good
    return TRUE;
}
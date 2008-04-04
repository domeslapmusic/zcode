<?php
// common rule for $_POST, $_GET, $_FILES, $_COOKIE and direct input
function validate_required($input,$input_type = 'value',$default= '')
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
    // extra files check
    if($input_type == 'file' && ($_FILES[$input]['error']== 4 || !is_uploaded_file($_FILES[$input]['tmp_name'])))
    {
       return FALSE; 
    }
    // don't allow a default value
    if(strlen($default) > 0 && $value == $default)
    {
        return FALSE;
    }
    // several checks to confirm the value is empty
    if(is_array($value) && count($value) == 0)
    {
        return FALSE;
    }
    
    if($value == '')
    {
        return FALSE;
    }
    
    if(empty($value))
    {
        return FALSE;
    }
    // if all checks are passed the value is good
    return TRUE;
}

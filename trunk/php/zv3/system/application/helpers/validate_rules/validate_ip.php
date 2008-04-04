<?php
// string rule for $_POST,$GET, $_COOKIE input
function validate_ip($input,$input_type='value')
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
    // do checks
    if(is_array($value))
    {
        foreach($value as $ip)
        {
            $ip_segments = explode('.', $ip);
                    
            // Always 4 segments needed
            if (count($ip_segments) != 4)
            {
                    return FALSE;
            }
            // IP can not start with 0
            if (substr($ip_segments[0], 0, 1) == '0')
            {
                    return FALSE;
            }
            // Check each segment
            foreach ($ip_segments as $segment)
            {
                    // IP segments must be digits and can not be 
                    // longer than 3 digits or greater then 255
                    if (preg_match("/[^0-9]/", $segment) OR $segment > 255 OR strlen($segment) > 3)
                    {
                            return FALSE;
                    }
            }
        }
    }
    
    if(is_string($value))
    {
        $ip_segments = explode('.', $value);
                    
        // Always 4 segments needed
        if (count($ip_segments) != 4)
        {
                return FALSE;
        }
        // IP can not start with 0
        if (substr($ip_segments[0], 0, 1) == '0')
        {
                return FALSE;
        }
        // Check each segment
        foreach ($ip_segments as $segment)
        {
                // IP segments must be digits and can not be 
                // longer than 3 digits or greater then 255
                if (preg_match("/[^0-9]/", $segment) OR $segment > 255 OR strlen($segment) > 3)
                {
                        return FALSE;
                }
        }
    }
    // if all checks are passed the input is good
    return TRUE;
}
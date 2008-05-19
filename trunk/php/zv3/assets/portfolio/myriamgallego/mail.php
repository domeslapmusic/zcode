<?php

$destino="cuentame@zarate.tv";
$asunto="Web de Myriam Gallego desde Zarate.tv";

$cuerpo = "

<html>
<head>
<title>Myriam Gallego</title>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
</head>

<body bgcolor='#000000'>
<table width='80%' border='1' align='center' cellpadding='4' cellspacing='0' bordercolor='#E5D9AB'>
  <tr> 
    <td><center>
        <b><font color='#E5D9AB' size='1' face='Verdana, Arial, Helvetica, sans-serif'>Comentarios sobre www.myriamgallego.com</font></b></center></td>
  </tr>
</table>
<br>
<table width='80%' border='1' align='center' cellpadding='4' cellspacing='0' bordercolor='#E5D9AB'>
  <tr> 
    <td><center>
        <b><font color='#E5D9AB' size='1' face='Verdana, Arial, Helvetica, sans-serif'>$nombre</font></b> 
      </center></td>
  </tr>
</table>
<br>
<table width='80%' border='1' align='center' cellpadding='4' cellspacing='0' bordercolor='#E5D9AB'>
  <tr> 
    <td><center>
        <b><font color='#E5D9AB' size='1' face='Verdana, Arial, Helvetica, sans-serif'>$comentarios</font></b> 
      </center></td>
  </tr>
</table>
</body>
</html>

";

if(mail($destino, $asunto, $cuerpo, "From: $remite\nContent-Type: text/html; charset=iso-8859-1")){

	print("&correcto=true");

} else {

	print("&correcto=false");

}


?>

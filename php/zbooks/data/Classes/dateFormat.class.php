<?php

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}


class dateFormat{
	
	var $finalDate = "";
	
	function dateFormat($date,$format){
		
		$monthNames = array("","enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre");
		$abvMonthNames = array("","ene","feb","mar","abr","may","jun","jul","ago","sep.","oct","nov","dic");
		$dayNames = array("lunes","martes","mi&eacute;coles","jueves","viernes","s&aacute;bado","domingo");
		
		$formatedDay = substr($date,8,2);
		
		if($formatedDay<10) $formatedDay = substr($formatedDay,1,1);
		$formatedMonth = substr($date,5,2);
		$sqlMonth = $formatedMonth; 
		if($formatedMonth<10) $formatedMonth = substr($formatedMonth,1,1);
		
		$formatedYear = substr($date,0,4);
		
		/* formamos la fecha que se devuelve en funcion del formato pedido
		
		0 -> dia nombreMes, año
		1 -> dia nombreMesAbrv, año
		2 -> nombreMes, año
		3 -> dia nombreMes
		4 -> nombreDia dia nombreMes
		5 -> año
		6 -> mes - año
		default -> nombreMesAbrv, año
		
		*/
		
		switch($format){
			
			case(0):
				$tmpDate = $formatedDay." ".$monthNames[$formatedMonth].", ".$formatedYear;
				break;
			case(1):
				$tmpDate = $formatedDay." ".$abvMonthNames[$formatedMonth].", ".$formatedYear;
				break;
			case(2):
				$tmpDate = $monthNames[$formatedMonth].", ".$formatedYear;
				break;
			case(3):
				$tmpDate = $formatedDay." ".$monthNames[$formatedMonth];
				break;
			case(4):
				$dayNumber = date("w",strtotime($date));
				$dayNumber += ($dayNumber == 0)? 6:-1; 
				$tmpDate = $dayNames[$dayNumber]." ".$formatedDay." ".$monthNames[$formatedMonth];
				break;
			case(5):
				$tmpDate = $formatedYear;
				break;
			case(6):
				$tmpDate = $sqlMonth."/".$formatedYear;
				break;
			default:
				$tmpDate = $abvMonthNames[$formatedMonth].", ".$formatedYear;
				break;
				
		}
		
		$this->finalDate = $tmpDate;
		
	}
	
	function getDate(){
		return $this->finalDate;
	}
	
}

?>
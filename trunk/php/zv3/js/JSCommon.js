/* funciones JavaScript comunes */

function noBot(start,finish,subject){

	// creamos la cadena
	var strAdress = "mailto:" + start + "@" + finish;
	
	if(subject != null) strAdress += "?Subject=" + subject;
	
	// enviamos el mail
	window.location = strAdress;
	
} // end noBot

function openWindow(url,name,width,height,center,addParams){
	
	// creamos la cadena de parametros
	var params = "width=" + width + ",height=" + height + ",";
	
	if(center){ // hay que centrar la ventana
		params += "left=" + ((screen.width/2)-(width/2)) + ",top=" + ((screen.height/2)-(height/2));
	} // end if
	
	// incluimos los parametros adicionales
	params += addParams;
	
	// abrimos la ventana
	window.open(url,name,params);
	
} // end openWindow
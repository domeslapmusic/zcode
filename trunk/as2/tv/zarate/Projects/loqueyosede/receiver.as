/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
*/

import tv.zarate.Utils.Trace;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.loqueyosede.broadcaster;
import tv.zarate.Projects.loqueyosede.myEvent;

class tv.zarate.Projects.loqueyosede.receiver{
	
	private var timeLine_mc:MovieClip;
	private var callbackField:TextField;
	
	public function receiver(m:MovieClip){
		
		timeLine_mc = m;
		
		// creamos la instacia de la clase emisora
		var broadcaster_mc:MovieClip = timeLine_mc.createEmptyMovieClip("broadcaster_mc",100);
		var broadcaster:broadcaster = new broadcaster(broadcaster_mc);
		
		// agregamos como listener de la clase emisora
		// a esta clase y para el evento "helloworld"
		// LA DIFERENCIA FUNDAMENTAL ES QUE NO TENEMOS QUE 
		// VOLVER A ESCRIBIR LA PROPIEDAD TYPE DEL EVENTO (UTILIZAMOS UNA VARIABLE ESTATICA)
		// POR LO QUE LAS POSIBILIDADES DE ERROR SE REDUCEN
		
		broadcaster.addEventListener(myEvent.staticType,this,"broadCasterCallback");
		
		layout();
		
	}

	public static function main(m:MovieClip):Void{
		
		var instance:receiver = new receiver(m);
		
	}
	
	// ************************* PRIVATE METHODS *************************
	
	private function layout():Void{
		
		var callbackField_mc:MovieClip = timeLine_mc.createEmptyMovieClip("callbackField_mc",200);
		callbackField_mc._y = 50;


		callbackField = TextfieldUtils.createMultilineField(callbackField_mc,200);
		callbackField.border = true;
		callbackField.text = "";
		
	}
	
	private function myTrace(s:String):Void{

		getURL("javascript:alert('" + s + "');");
	
	}

	private function broadCasterCallback(e:myEvent):Void{
		
		// el evento que llega ahora no es anonimo
		// por lo que las propiedades que tiene estan
		// bien definidas en la clase myEvent
		
		callbackField.text += e.type + " -- " + e.myvar + "\n";
		callbackField.scroll = callbackField.maxscroll;
		
	}
	
}
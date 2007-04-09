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

import tv.zarate.Projects.loqueyosede.simpleBroadcaster;

class tv.zarate.Projects.loqueyosede.simpleReceiver{
	
	private var timeLine_mc:MovieClip;
	private var callbackField:TextField;
	
	public function simpleReceiver(m:MovieClip){
		
		timeLine_mc = m;
		
		// creamos la instacia de la clase emisora
		var broadcaster_mc:MovieClip = timeLine_mc.createEmptyMovieClip("broadcaster_mc",100);
		var broadcaster:simpleBroadcaster = new simpleBroadcaster(broadcaster_mc);
		
		// agregamos como listener de la clase emisora
		// a esta clase y para el evento "hellworld"
		// el ultimo parametro define el metodo que se va ejecutar cuando el 
		// evento sea emitido
		broadcaster.addEventListener("helloworld",this,"broadCasterCallback");
		
		layout();
		
	}

	public static function main(m:MovieClip):Void{
		
		var instance:simpleReceiver = new simpleReceiver(m);
		
	}
	
	// ************************* PRIVATE METHODS *************************
	
	private function layout():Void{
		
		var callbackField_mc:MovieClip = timeLine_mc.createEmptyMovieClip("callbackField_mc",200);
		callbackField_mc._y = 50;


		callbackField = TextfieldUtils.createMultilineField(callbackField_mc,100);
		callbackField.border = true;
		callbackField.text = "";
		
	}
	
	private function myTrace(s:String):Void{

		getURL("javascript:alert('" + s + "');");
	
	}

	private function broadCasterCallback(e:Object):Void{
		
		// el metod es llamado y llega como parametro un objeto
		// que como minimo tiene que tener una propiedad "type"
		// que define el "nombre" del evento
		
		callbackField.text += e.type + " -- " + e.myvar + "\n";
		callbackField.scroll = callbackField.maxscroll;
		
	}
	
}
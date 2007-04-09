/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
*/

import com.gskinner.GDispatcher;

import tv.zarate.Utils.TextfieldUtils;
import tv.zarate.Utils.Delegate;

class tv.zarate.Projects.loqueyosede.simpleBroadcaster{

	// estas tres variables son realmente creadas por GDispatcher
	public var addEventListener:Function;
	public var removeEventListener:Function;	
	private var dispatchEvent:Function;

	private var base_mc:MovieClip;

	public function simpleBroadcaster(_base_mc:MovieClip){
		
		// inicializamos esta clase en GDispatcher
		GDispatcher.initialize(this);

		base_mc = _base_mc;

		layout();

	}

	// ************************* PRIVATE METHODS *************************

	private function layout():Void{
		
		// creamos un boton para luego hacer un bonito click
		
		var button_mc:MovieClip = base_mc.createEmptyMovieClip("button_mc",100);
		var field:TextField = TextfieldUtils.createField(button_mc);
		
		field.text = "Envia un evento que mole";
		
		// el evento onPress de este boton esta "delegado"
		// a la funcion butPressed de esta misma clase, por eso se pasa "this"
		// como primer parametro

		button_mc.onPress = Delegate.create(this,butPressed);

	}

	private function butPressed():Void{
		
		// creamos con un par de propiedades
		// el objeto que se va a emitir
		var e:Object = new Object();
		e.type = "helloworld";
		e.myvar = 2;
		
		// el metodo dispatchEvent 
		// se define en GDispatcher cuando se inicializa esta clase
		dispatchEvent(e);
		
	}
	
}
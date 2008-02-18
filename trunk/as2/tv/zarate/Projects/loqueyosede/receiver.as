/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

import tv.zarate.utils.Trace;
import tv.zarate.utils.TextfieldUtils;

import tv.zarate.projects.loqueyosede.broadcaster;
import tv.zarate.projects.loqueyosede.myEvent;

class tv.zarate.projects.loqueyosede.receiver{
	
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
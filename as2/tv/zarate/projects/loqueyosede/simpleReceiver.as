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

import tv.zarate.projects.loqueyosede.simpleBroadcaster;

class tv.zarate.projects.loqueyosede.simpleReceiver{
	
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
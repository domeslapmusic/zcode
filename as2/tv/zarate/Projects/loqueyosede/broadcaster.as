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

import com.gskinner.GDispatcher;

import tv.zarate.utils.TextfieldUtils;
import tv.zarate.utils.Delegate;

import tv.zarate.projects.loqueyosede.myEvent;

class tv.zarate.projects.loqueyosede.broadcaster{

	// estas tres variables son realmente creadas por GDispatcher
	public var addEventListener:Function;
	public var removeEventListener:Function;	
	private var dispatchEvent:Function;

	private var base_mc:MovieClip;

	public function broadcaster(_base_mc:MovieClip){
		
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
		var e:myEvent = new myEvent();
		e.myvar = "We rock!";
				
		// el metodo dispatchEvent 
		// se define en GDispatcher cuando se inicializa esta clase
		dispatchEvent(e);
		
	}
	
}
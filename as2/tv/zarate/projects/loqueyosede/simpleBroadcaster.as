/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
* 
*/

import com.gskinner.GDispatcher;

import tv.zarate.utils.TextfieldUtils;
import tv.zarate.utils.Delegate;

class tv.zarate.projects.loqueyosede.simpleBroadcaster{

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
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
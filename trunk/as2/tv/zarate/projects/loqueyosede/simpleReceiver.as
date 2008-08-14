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
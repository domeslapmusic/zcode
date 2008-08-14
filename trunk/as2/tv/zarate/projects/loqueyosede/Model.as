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

import tv.zarate.projects.loqueyosede.View;

class tv.zarate.projects.loqueyosede.Model{
	
	private var view:View;

	private var timeLine_mc:MovieClip;
	private var view_mc:MovieClip;

	private var numberOfClicks:Number = 0;
	
	public function Model(){}

	public function config(m:MovieClip):Void{
		
		// el modelo se guarda una referencia a la linea de tiempo principal
		// basicamente para poder acceder a las FlashVars
		// cuando sea necesario
		timeLine_mc = m;
		
		
		// creamos un mc solo para la vista
		view_mc = timeLine_mc.createEmptyMovieClip("view_mc",100);
		
	}

	public function start():Void{
		
		// creamos la instancia de la vista
		view = new View();
		
		// le pasamos la referencia al modelo y el 
		// clip sobre el que va a trabajar
		view.config(this,view_mc);
		
		// en este caso directamente llamamos al metodo
		// start de la vista
		// en aplicaciones mas complejas, el modelo
		// podria primero ir a buscar datos a un servidor
		// o leer un xml de configuracion
		view.displayValue(numberOfClicks);
		
	}
	
	public function updateClick():Void{
		
		// la vista llama a este metodo cada vez que el usuario hace click
		numberOfClicks++;

		// despues de actualizar 
		// llamamos al metodo que nos interesa de la vista
		view.displayValue(numberOfClicks);
		
	}
	
	// ************************* PRIVATE METHODS *************************
	
}
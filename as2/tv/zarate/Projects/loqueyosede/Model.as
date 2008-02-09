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

import tv.zarate.Projects.loqueyosede.View;

class tv.zarate.Projects.loqueyosede.Model{
	
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
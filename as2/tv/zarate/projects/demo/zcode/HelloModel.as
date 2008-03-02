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

import tv.zarate.application.Model;

import tv.zarate.projects.demo.zcode.HelloView;
import tv.zarate.projects.demo.zcode.HelloConfig;

class tv.zarate.projects.demo.zcode.HelloModel extends Model{

	private var view:HelloView;
	private var conf:HelloConfig;

	public function HelloModel(){
		
		// You have to create the instances of
		// your view and configuration object.
		
		// Remember that defining you own configuration
		// object is optional, although recommended
		
		view = new HelloView();
		conf = new HelloConfig();
		
		super();
		
	}
	
	public static function main(m:MovieClip):Void{
		
		// This is application's entry point
		// Just create an instance of the model and
		// call the config method passing the MovieClip
		// that this application is going to use
		
		// After that, just wait until "frameworkReady" is called
		// From that point onwards, you have the control
		
		var instance:HelloModel = new HelloModel();
		instance.config(m);
		
	}

	// ******************** PRIVATE METHODS ********************

	private function frameworkReady():Void{
		
		// At this point the framework has finished its job
		// Do whatever you like from now onward
		
		// Maybe you want to call something on the server
		// Here we just call a method on the view
		
		view.drawImages();
		
	}

}
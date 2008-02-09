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

import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.FlashVars;

class tv.zarate.Application.Config{

	public var flashvars:FlashVars;
	public var dataXML:XML;
	
	public function Config(){}
	
	public function loadXML(xmlPath:String,callback:Function):Void{
		
		if(xmlPath != ""){
			
			dataXML = new XML();
			dataXML.ignoreWhite = true;
			dataXML.onLoad = Delegate.create(this,xmlLoaded,callback);
			dataXML.load(xmlPath);
			
		} else {
			
			callback(true);
			
		}
		
	}

	// ******************** PRIVATE METHODS ********************

	private function xmlLoaded(success:Boolean,callback:Function):Void{
		
		if(success){
			
			// do here whatever you might need before calling the callback
			// typically you would be parsing the xml file for data
			
			callback(true);
			
		} else {
			
			callback(false);
			
		}
		
	}
	
}
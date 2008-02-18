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

import tv.zarate.application.Config;

import tv.zarate.projects.zkino.Frame;

class tv.zarate.projects.zkino.ZKinoConfig extends Config{
	
	public var frames:/*Frame*/Array;
	public var loop:Boolean = true;
	
	public function ZKinoConfig(){
		
		super();
		
		frames = new Array();
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function xmlLoaded(success:Boolean,callback:Function):Void{
		
		if(success){
			
			var optionsNode:XMLNode = dataXML.firstChild.childNodes[0];
			loop = (optionsNode.attributes["loop"] == "true")? true:false;
			
			var framesNode:XMLNode = dataXML.firstChild.childNodes[1];
			var totalFrames:Number = framesNode.childNodes.length;
			
			for(var x:Number=0;x<totalFrames;x++){
				
				var f:Frame = new Frame();
				f.setXML(framesNode.childNodes[x]);
				
				frames.push(f);
				
			}
			
			
		}
		
		super.xmlLoaded(success,callback);
		
	}
	
}
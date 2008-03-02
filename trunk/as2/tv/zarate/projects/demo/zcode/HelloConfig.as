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

import com.xfactorstudio.xml.xpath.XPath;

import tv.zarate.projects.demo.zcode.Image;

class tv.zarate.projects.demo.zcode.HelloConfig extends Config{

	public var images:/*Image*/Array;
	
	public function HelloConfig(){
		
		super();
		
		images = new Array();
		
	}

	// ******************** PRIVATE METHODS ********************

	private function xmlLoaded(success:Boolean,callback:Function):Void{
		
		// You usually parse whatever you need from the xml
		// and then expose it as public variables whoever might need it
		// Remember that both the Model and the View have access to
		// this class
		
		// Using XPath is entirely your decision.
		// ZCode does *NOT* include it by default
		
		var imageNodes/*XMLNode*/:Array = XPath.selectNodes(dataXML,"data/image");
		var totalImages:Number = imageNodes.length;
		
		for(var x:Number=0;x<totalImages;x++){
			
			var i:Image = new Image();
			i.setXML(imageNodes[x]);
			
			images.push(i);
			
		}
		
		super.xmlLoaded(success,callback);
		
	}
	
}
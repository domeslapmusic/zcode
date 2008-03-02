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

import tv.zarate.utils.Delegate;

import cl.cay.effects.Basic;

class tv.zarate.projects.demo.zcode.Image{
	
	public var path:String = "";
	public var url:String = "";
	public var clip_mc:MovieClip;
	public var loadCallback:Function;
	
	public function Image(){}
	
	public function setXML(imageXML:XMLNode):Void{
		
		path = imageXML.attributes["path"];
		url = imageXML.attributes["url"];
		
	}
	
	public function load(callback:Function):Void{
		
		loadCallback = callback;
		
		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(path,clip_mc);
		
	}
	
	public function toString():String{
		return "Image [path=" + path + ", url= " + url + "]";
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function onLoadInit():Void{
		
		var url:String = url;
		
		clip_mc.onPress = function():Void{ getURL(url); }
		
		Basic.WetFloor(clip_mc);
		
		loadCallback(this);
		
	}
	
}
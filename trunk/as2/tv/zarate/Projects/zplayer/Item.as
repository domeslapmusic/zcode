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

import tv.zarate.projects.zplayer.Thumbnail;

class tv.zarate.projects.zplayer.Item{

	public var thumbnail:Thumbnail;
	
	public var url:String = "";
	public var info:String = "";
	public var title:String = "";
	public var type:String = "";
	public var thumb:String = "";
	public var order:Number = -1;
	public var clip:MovieClip;

	public function Item(){}

	public function setXML(x:XMLNode):Void{}
	
	public function toString():String{ return ""; }

	public function enable():Void{
		thumbnail.enable();
	}
	
	public function disable():Void{
		thumbnail.disable();
	}
	
	// **************** PRIVATE METHODS ****************
	
	private function setThumb(path:String):Void{
		
		var ext:String = path.substr(path.lastIndexOf("."));
		thumb = path.substr(0,path.lastIndexOf(".")) + "_t" + ext;
		
	}
	
}
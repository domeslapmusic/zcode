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

class tv.zarate.projects.ZBooks.Config{

	public var owner:String = "";
	public var showURL:Boolean = false;
	public var edit:Boolean = false;
	public var user_id:Number = 0;
	public var defaultTarget:String = "";
	public var name:String = "";
	public var key:String = "";

	public function Config(){}

	public function setXML(configNode:XMLNode):Void{

		name = configNode.firstChild.childNodes[0].attributes["username"];
		edit = (configNode.firstChild.childNodes[0].attributes["edit"] == "true")? true:false;
		defaultTarget = configNode.firstChild.childNodes[0].attributes["defaultTarget"];
		showURL = (configNode.firstChild.childNodes[0].attributes["showURL"] == "1")? true:false;
		user_id = Number(configNode.firstChild.childNodes[0].attributes["user_id"]);
		key = configNode.firstChild.childNodes[0].attributes["key"];

	}

	public function toString():String{
		return "[Config name=" + name + ", edit=" + edit + ", key=" + key + "]";
	}

}
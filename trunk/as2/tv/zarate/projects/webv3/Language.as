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

class tv.zarate.projects.webv3.Language{
	
	public var language_id:String = "";
	public var title:String = "";
	public var change:String = "";
	public var shortID:String = "";
	public var selected:Boolean = false;
	
	public function Language(){}
	
	public function setXML(languageXML:XMLNode):Void{
		
		language_id = languageXML.attributes["language_id"];
		shortID = languageXML.attributes["shortID"];
		selected = (languageXML.attributes["selected"] == "true")? true:false;
		title = languageXML.childNodes[0].firstChild.nodeValue;
		change = languageXML.childNodes[1].firstChild.nodeValue;
		
	}
	
	public function toString():String{
		return "Language [title=" +title + ", language_id=" + language_id + "]";
	}
	
}
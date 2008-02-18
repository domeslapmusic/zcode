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

class tv.zarate.projects.webv3.Option{
	
	public var title:String = "";
	public var text:String = "";
	public var link:String = "";
	public var clip_mc:MovieClip;
	public var section_id:String = "";
	
	public function Option(){}
	
	public function setXML(optionXML:XMLNode):Void{
		
		title = optionXML.childNodes[0].firstChild.nodeValue;
		text = optionXML.childNodes[1].firstChild.nodeValue;
		link = optionXML.childNodes[2].firstChild.nodeValue;
		
	}
	
	public function toString():String{
		return "Option [title=" +title + "]";
	}
	
}
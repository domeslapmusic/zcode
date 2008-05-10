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

import tv.zarate.projects.zplayer.Item;
import tv.zarate.projects.zplayer.zpConstants;

class tv.zarate.projects.zplayer.zpVideo extends Item{

	public var intro:String = "";
	
	public function zpVideo(){}

	public function setXML(xmlNode:XMLNode):Void{
		
		type = zpConstants.TYPE_VIDEO;
		
		url = xmlNode.attributes["url"];
		title = xmlNode.childNodes[0].firstChild.nodeValue;
		info = xmlNode.childNodes[1].firstChild.nodeValue;
		intro = xmlNode.attributes["intro"];
		
		setThumb(intro);
		
	}

	public function toString():String{
		return "Video [url=" + url + ", title=" + title + "]";
	}

}
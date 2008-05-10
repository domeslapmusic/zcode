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

class tv.zarate.projects.zplayer.zpImage extends Item{

	public var sound:String = "";
	public var duration:Number = 0; // duration in miliseconds
	public var link:String = "";
	public var target:String = "_self";

	public function zpImage(){}

	public function setXML(xmlNode:XMLNode):Void{
		
		type = zpConstants.TYPE_IMAGE;
		
		url = xmlNode.attributes["url"];
		sound = xmlNode.attributes["sound"];
		link = xmlNode.attributes["link"];
		if(xmlNode.attributes["target"] != undefined){ target = xmlNode.attributes["target"]; }
		title = xmlNode.childNodes[0].firstChild.nodeValue;
		info = xmlNode.childNodes[1].firstChild.nodeValue;
		
		if(sound != undefined){
			
			var durationData:Array = String(xmlNode.attributes["time"]).split(":");
			
			var mins:Number = Number(durationData[0]);
			var secs:Number = Number(durationData[1])
			
			duration = ((mins * 60) + secs) * 1000;
			
		}
		
		setThumb(url);
		
	}

	public function toString():String{
		return "Image [url=" + url + ", title=" + title + "]";
	}

}
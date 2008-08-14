/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
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
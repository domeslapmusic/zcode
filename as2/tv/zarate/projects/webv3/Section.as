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

import tv.zarate.projects.webv3.Option;

class tv.zarate.projects.webv3.Section{
	
	public var title:String = "";
	public var text:String = "";
	public var options:/*Option*/Array; // another typed array, Option objects in this case
	public var totalLetters:Number = 0;
	public var clip_mc:MovieClip;
	public var section_id:String = "";
	public var selected:Boolean = false;
	
	public function Section(){
		
		options = new Array();
		
	}
	
	public function setXML(sectionXML:XMLNode):Void{
		
		section_id = sectionXML.attributes["section_id"];
		selected = (sectionXML.attributes["selected"] == "true")? true:false;
		title = sectionXML.childNodes[0].firstChild.nodeValue;
		text = sectionXML.childNodes[1].firstChild.nodeValue;
		
		var optionsNode:XMLNode = sectionXML.childNodes[2];
		
		if(optionsNode != undefined){
			
			var totalOptions:Number = optionsNode.childNodes.length;
			
			for(var x:Number=0;x<totalOptions;x++){
				
				var o:Option = new Option();
				o.setXML(optionsNode.childNodes[x]);
				
				o.section_id = section_id;
				
				options.push(o);
				
				totalLetters += o.title.length;
				
			}
			
		}
		
	}
	
	public function toString():String{
		return "Section [title=" +title + ", section_id=" + section_id + "]";
	}
	
}
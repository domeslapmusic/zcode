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

import tv.zarate.application.Config;

import tv.zarate.projects.webv3.Section;
import tv.zarate.projects.webv3.Language;
import tv.zarate.projects.webv3.Literals;

class tv.zarate.projects.webv3.WebConfig extends Config{
	
	public var sections:/*Section*/Array; // this is a typed array, only Section objects go inside
	public var languages:/*Language*/Array; // same but with Language objects
	public var initialSection:Section;
	public var literals:Literals;
	
	public function WebConfig(){
		
		super();
		
		sections = new Array();
		languages = new Array();
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function xmlLoaded(success:Boolean,callback:Function):Void{
		
		if(success){
			
			var sectionsXML:XMLNode = dataXML.firstChild.childNodes[0];
			var totalSections:Number = sectionsXML.childNodes.length;
			
			for(var x:Number=0;x<totalSections;x++){
				
				var s:Section = new Section();
				s.setXML(sectionsXML.childNodes[x]);
				
				if(s.selected){ initialSection = s; }
				
				sections.push(s);
				
			}
			
			var languagesNode:XMLNode = dataXML.firstChild.childNodes[1];
			var totalLanguages:Number = languagesNode.childNodes.length;
			
			for(var x:Number=0;x<totalLanguages;x++){
				
				var l:Language = new Language();
				l.setXML(languagesNode.childNodes[x]);
				
				languages.push(l);
				
			}
			
			var literalsNode:XMLNode = dataXML.firstChild.childNodes[2];
			
			literals = new Literals();
			literals.setXML(literalsNode);
			
		}
		
		super.xmlLoaded(success,callback);
		
	}
	
}
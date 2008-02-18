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
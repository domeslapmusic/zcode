import tv.zarate.Application.Config;

import tv.zarate.Projects.webv3.Section;
import tv.zarate.Projects.webv3.Language;

class tv.zarate.Projects.webv3.WebConfig extends Config{
	
	public var sections:/*Section*/Array; // this is a typed array, only Section objects go inside
	public var languages:/*Language*/Array; // same but with Language objects
	public var initialSection:Section;
	
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
			
		}
		
		super.xmlLoaded(success,callback);
		
	}
	
}
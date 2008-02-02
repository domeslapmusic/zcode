import tv.zarate.Projects.webv3.Option;

class tv.zarate.Projects.webv3.Section{
	
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
class tv.zarate.Projects.webv3.Option{
	
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
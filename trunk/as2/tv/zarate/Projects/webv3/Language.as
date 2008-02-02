class tv.zarate.Projects.webv3.Language{
	
	public var language_id:String = "";
	public var title:String = "";
	public var change:String = "";
	public var shortID:String = "";
	public var selected:Boolean = false;
	
	public function Language(){}
	
	public function setXML(languageXML:XMLNode):Void{
		
		language_id = languageXML.attributes["language_id"];
		shortID = languageXML.attributes["shortID"];
		selected = (languageXML.attributes["selected"] == "true")? true:false;
		title = languageXML.childNodes[0].firstChild.nodeValue;
		change = languageXML.childNodes[1].firstChild.nodeValue;
		
	}
	
	public function toString():String{
		return "Language [title=" +title + ", language_id=" + language_id + "]";
	}
	
}
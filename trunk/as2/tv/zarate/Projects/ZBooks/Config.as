class tv.zarate.Projects.ZBooks.Config{
	
	public var owner:String = "";
	public var showURL:Boolean = false;
	public var edit:Boolean = false;
	public var user_id:Number = 0;
	public var defaultTarget:String = "";
	public var name:String = "";
	
	public function Config(){}

	public function setXML(configNode:XMLNode):Void{
		
		name = configNode.firstChild.childNodes[0].attributes["username"];
		edit = (configNode.firstChild.childNodes[0].attributes["edit"] == "true")? true:false;
		defaultTarget = configNode.firstChild.childNodes[0].attributes["defaultTarget"];
		showURL = (configNode.firstChild.childNodes[0].attributes["showURL"] == "1")? true:false;
		user_id = Number(configNode.firstChild.childNodes[0].attributes["user_id"]);
		
	}
	
}
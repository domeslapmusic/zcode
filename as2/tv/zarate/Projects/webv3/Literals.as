class tv.zarate.Projects.webv3.Literals{
	
	public static var WANT_TO_SEND_EMAIL:String = "want_to_send_email";
	public static var SENDING_EMAIL:String = "sending_email";
	public static var MAIL_SENT_OK:String = "mail_sent_ok";
	public static var MAIL_SENT_PROBLEM:String = "mail_sent_problem";
	public static var SPACE_WARNING:String = "space_warning";
	
	private var literals:Object;
	
	public function Literals(){}
	
	public function getLiteral(id:String):String{
		return literals[id];
	}
	
	public function setXML(literalsXML:XMLNode):Void{
		
		literals = new Object();
		
		var totalLiterals:Number = literalsXML.childNodes.length;
		
		for(var x:Number=0;x<totalLiterals;x++){
			
			var id:String = literalsXML.childNodes[x].attributes["id"];
			var title:String = literalsXML.childNodes[x].firstChild.nodeValue;
			
			literals[id] = title;
			
		}
		
	}
	
}
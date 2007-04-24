class tv.zarate.Projects.ZBooks.Bookmark{

	public var id:String = "";
	public var title:String = "";
	public var url:String = "";
	public var date:String = "";
	public var isPrivate:Boolean = false;
	public var labels:String = "";
	public var isPDF:Boolean = false;
	
	public function Bookmark(){}

	public function setXML(bookXML:XMLNode):Void{
		
		id = bookXML.attributes["id"];
		title = unescape(bookXML.childNodes[0].childNodes[0].nodeValue);
		url = unescape(bookXML.childNodes[1].childNodes[0].nodeValue);
		date = bookXML.attributes["date"];
		isPrivate = bookXML.attributes["private"];
		labels = unescape(bookXML.childNodes[2].childNodes[0].nodeValue);
		isPDF = (url.indexOf(".pdf") != -1);
		
	}
	
	public function toString():String{
		return "[Bookmark, id="+ id +", title="+ title +", url="+ url +", date="+ date +", isPrivate="+ isPrivate+ ", labels=" + labels + "]";
	}
	
}
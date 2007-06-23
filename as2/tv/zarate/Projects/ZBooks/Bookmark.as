class tv.zarate.Projects.ZBooks.Bookmark{

	public var id:String = "";
	public var title:String = "";
	public var url:String = "";
	public var date:String = "";
	public var isPrivate:Boolean = false;
	public var labels:String = "";
	public var isPDF:Boolean = false;

	public function Bookmark(){}

	public function setData(bookRaw:String):Void{

		var data:Array = bookRaw.split("_");

		id = data[0];
		title = unescape(data[3]);
		url = unescape(data[4]);
		date = data[2];
		isPrivate = data[1];
		labels = unescape(data[5]);
		isPDF = (url.indexOf(".pdf") != -1);

	}

	public function toString():String{
		return "[Bookmark, id="+ id +", title="+ title +", url="+ url +", date="+ date +", isPrivate="+ isPrivate+ ", labels=" + labels + "]";
	}

}
import tv.zarate.Projects.ZBooks.Bookmark;

class tv.zarate.Projects.ZBooks.Label{

	public var title:String = "";
	public var id:String = "";
	public var pages:Number = 0;
	public var currentPage:Number = 0;
	public var totalBookmarks:Number = 0;
	public var owner:String = "";
	public var isPrivate:String = "";

	public var bookmarks:/*Bookmark*/Array;

	public function Label(){

		bookmarks = new Array();

	}

	public function setData(labelXML:XMLNode):Void{

		title = labelXML.childNodes[0].childNodes[0].nodeValue;
		id = labelXML.attributes["id"];

		var bookmarksNode:XMLNode = labelXML.childNodes[1];

		pages = Number(bookmarksNode.attributes["pages"]);
		currentPage = Number(bookmarksNode.attributes["currentPage"]);
		totalBookmarks = Number(bookmarksNode.attributes["total"]);
		owner = bookmarksNode.attributes["owner"];

		var bookmarksRaw:String = bookmarksNode.firstChild.nodeValue;
		var booksData:Array = bookmarksRaw.split("*");

		var bookmarksInPage:Number = booksData.length - 1;

		for(var x:Number=0;x<bookmarksInPage;x++){

			var book:Bookmark = new Bookmark();
			book.setData(booksData[x]);

			bookmarks.push(book);

		}

	}

	public function toString():String{
		return "[Label id=" + id + ", title=" + title + ", private=" + isPrivate + "]";
	}

}
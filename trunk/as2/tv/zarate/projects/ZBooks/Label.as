/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
* 
*/

import tv.zarate.projects.ZBooks.Bookmark;

class tv.zarate.projects.ZBooks.Label{

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
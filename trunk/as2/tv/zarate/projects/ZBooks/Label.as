/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
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
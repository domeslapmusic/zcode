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

class tv.zarate.projects.ZBooks.Bookmark{

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
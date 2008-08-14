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

class tv.zarate.projects.ZBooks.Config{

	public var owner:String = "";
	public var showURL:Boolean = false;
	public var edit:Boolean = false;
	public var user_id:Number = 0;
	public var defaultTarget:String = "";
	public var name:String = "";
	public var key:String = "";

	public function Config(){}

	public function setXML(configNode:XMLNode):Void{

		name = configNode.firstChild.childNodes[0].attributes["username"];
		edit = (configNode.firstChild.childNodes[0].attributes["edit"] == "true")? true:false;
		defaultTarget = configNode.firstChild.childNodes[0].attributes["defaultTarget"];
		showURL = (configNode.firstChild.childNodes[0].attributes["showURL"] == "1")? true:false;
		user_id = Number(configNode.firstChild.childNodes[0].attributes["user_id"]);
		key = configNode.firstChild.childNodes[0].attributes["key"];

	}

	public function toString():String{
		return "[Config name=" + name + ", edit=" + edit + ", key=" + key + "]";
	}

}
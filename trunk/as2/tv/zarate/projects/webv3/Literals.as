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

class tv.zarate.projects.webv3.Literals{
	
	public static var WANT_TO_SEND_EMAIL:String = "want_to_send_email";
	public static var SENDING_EMAIL:String = "sending_email";
	public static var MAIL_SENT_OK:String = "mail_sent_ok";
	public static var MAIL_SENT_PROBLEM:String = "mail_sent_problem";
	public static var SPACE_WARNING:String = "space_warning";
	public static var SPACE_WARNING_HTML:String = "space_warning_html";
	
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
		
		var spaceWarning:Array = literals[SPACE_WARNING].split("__");
		literals[SPACE_WARNING] = spaceWarning[0];
		literals[SPACE_WARNING_HTML] = spaceWarning[1];
		
	}
	
}
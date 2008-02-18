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

class tv.zarate.Projects.webv3.Literals{
	
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
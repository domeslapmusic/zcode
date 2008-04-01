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

class tv.zarate.utils.StringUtils{
	
	public static function replaceEntities(s:String):String{
		
		s = replace(s,"&gt;",">");
		s = replace(s,"&lt;","<");
		s = replace(s,"&quot;","\"");
		s = replace(s,"&nbsp;"," ");
		s = replace(s,"&amp;","&");
		return s;
		
	}
	
	public static function replace(s:String,search:String,replace:String):String{
		return s.split(search).join(replace);
	}
	
	public static function highlight(field:TextField,search:String,format:TextFormat):Void{
		
		var text:String = field.text;
		
		if(text.indexOf(search) == -1 || search == "" || search == " " || search == undefined) return;
		
		var searchLength:Number = search.length;
		var arr:Array = text.split(search);
		var prevPosition:Number = 0;
		var lng:Number = arr.length-1;
		
		for(var x:Number=0;x<lng;x++){
			
			prevPosition += arr[x].length;
			field.setTextFormat(prevPosition,prevPosition+searchLength,format);
			prevPosition += searchLength;
			
		}
		
	}
	
	public static function highlightHTML(field:TextField,search:String,cssClass:String):Void{
		
		var text:String = field.text;		
		if(text.indexOf(search) == -1 || search == "" || search == " " || search == undefined) return;
		
		field.htmlText = replace(field.htmlText,search,"<span class=\"" + cssClass + "\">" + search + "</span>");
		
	}
	
}
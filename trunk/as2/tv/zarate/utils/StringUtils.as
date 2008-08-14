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
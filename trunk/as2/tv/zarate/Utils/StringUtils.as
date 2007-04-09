/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
*/

class tv.zarate.Utils.StringUtils{
	
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
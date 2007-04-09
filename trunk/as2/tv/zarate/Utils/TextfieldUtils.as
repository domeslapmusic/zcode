/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
*/

class tv.zarate.Utils.TextfieldUtils{
	
	public static function createField(m:MovieClip,width:Number,height:Number,autoSize:String,multiline:Boolean,depth:Number):TextField{
		
		if(autoSize == null) autoSize = "left";
		if(depth == null) depth = 100;
		if(width == null) width = 0;
		if(height == null) height = 0;
		
		m.createTextField("field",depth,0,0,width,height);
		var field:TextField = m.field;
		field.autoSize = autoSize;
		if(multiline) field.multiline = field.wordWrap = true;
		
		return field;
		
	}
	
	public static function createMultilineField(m:MovieClip,width:Number,depth:Number):TextField{
		return createField(m,width,10,"center",true,depth);
	}
	
	public static function createInputField(m:MovieClip,width:Number,height:Number,multiline:Boolean,depth:Number):TextField{
		
		var field:TextField = createField(m,width,height,null,multiline,depth);
		field.autoSize = false;
		field.type = "input";
		
		return field;
		
	}
	
}
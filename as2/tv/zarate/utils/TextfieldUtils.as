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

class tv.zarate.utils.TextfieldUtils{

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

	public static function createMultiline(m:MovieClip,width:Number,height:Number,depth:Number):TextField{
		return createField(m,width,height,"center",true,depth);
	}

	public static function createInputField(m:MovieClip,width:Number,height:Number,multiline:Boolean,depth:Number):TextField{
		
		var field:TextField = createField(m,width,height,null,multiline,depth);
		field.autoSize = false;
		field.type = "input";
		
		return field;
		
	}

}
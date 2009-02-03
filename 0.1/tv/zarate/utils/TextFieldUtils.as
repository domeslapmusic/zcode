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

package tv.zarate.utils{

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	public class TextFieldUtils{
		
		public static function CreateField(width:Number=100,height:Number=100,autoSize:String="",multiline:Boolean=false):TextField{
			
			if(autoSize == ""){ autoSize = TextFieldAutoSize.LEFT; }
			
			var field:TextField = new TextField();
			field.autoSize = autoSize;
			field.width = width;
			field.height = height;
			
			if(multiline){ field.multiline = field.wordWrap = true; }
			
			return field;
			
		}
		
		public static function CreateMultiline(width:Number=100,height:Number=100):TextField{
			return CreateField(width,height,TextFieldAutoSize.CENTER,true);
		}

		public static function CreateInputField(width:Number=100,height:Number=100,multiline:Boolean=false):TextField{
			
			var field:TextField = CreateField(width,height,TextFieldAutoSize.NONE,multiline);
			field.type = TextFieldType.INPUT;
			
			return field;
			
		}
		
	}

}
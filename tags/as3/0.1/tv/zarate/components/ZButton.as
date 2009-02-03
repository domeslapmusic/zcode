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

package tv.zarate.components{
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import tv.zarate.utils.TextFieldUtils;
	import tv.zarate.utils.MovieClipUtils;
	
	public class ZButton extends Sprite{
		
		public var data:*;
		
		protected var field:TextField;
		protected var text:String;
		protected var margin:int = 5;
		protected var color:Number;
		
		public function ZButton(text:String,color:Number=0xdedede){
			
			super();
			
			this.text = text;
			this.color = color;
			
			draw();
			
		}
		
		protected function draw():void{
			
			buttonMode = true;
			
			field = TextFieldUtils.CreateField();
			field.text = text;
			field.x = field.y = margin;
			field.selectable = false;
			
			var bg:Sprite = new Sprite();
			MovieClipUtils.DrawRect(bg,field.width+margin*2,field.height+margin*2,color);
			
			addChild(bg);
			addChild(field);
			
		}
		
	}

}
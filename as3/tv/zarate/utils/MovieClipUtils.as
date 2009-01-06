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
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class MovieClipUtils{
		
		public static function DrawRect(sprite:Sprite,width:Number=100,height:Number=100,colour:Number=0x000000,alpha:Number=1,border:Number=0,borderColour:Number=0x000000,borderAlpha:Number=1):Sprite{
			
			var rect:Sprite = new Sprite();
			
			if(border > 0){
				
				var rectBorder:Shape = new Shape();
				rectBorder.graphics.beginFill(borderColour,borderAlpha);
				rectBorder.graphics.drawRect(0,0,width,height);
				rectBorder.graphics.endFill();
				
			}
		
			var inner:Shape = new Shape();
			inner.graphics.beginFill(colour,alpha);
			inner.graphics.drawRect(border,border,width-border*2,height-border*2);
			inner.graphics.endFill();
			
			if(border > 0){ rect.addChild(rectBorder); }
			rect.addChild(inner);
			
			sprite.addChild(rect);
			
			return rect;
			
		}
		
		public static function CentreHorizontal(master:DisplayObject,slave:DisplayObject):void{
			slave.x = Math.round((master.width - slave.width)/2);
		}
		
		public static function CentreVertical(master:DisplayObject,slave:DisplayObject):void{
			slave.y = Math.round((master.height - slave.height)/2);
		}
		
		public static function CentreFromWidth(width:Number,target:DisplayObject):void{
			target.x = Math.round((width-target.width)/2);
		}
		
		public static function CentreFromHeight(height:Number,target:DisplayObject):void{
			target.y = Math.round((height-target.height)/2);
		}
		
		public static function CentreClips(master:DisplayObject,slave:DisplayObject):void{
			
			CentreHorizontal(master,slave);
			CentreVertical(master,slave);
			
		}
		
		public static function MaxResize(sprite:DisplayObject,maxWidth:Number,maxHeight:Number):void{
			
			var appAspectRatio:Number = maxWidth/maxHeight;
			var contentAspectRatio:Number = sprite.width/sprite.height;
			var limitingAspect:String = (appAspectRatio > contentAspectRatio)? "h":"w";
			
			if(limitingAspect == "h"){
				
				sprite.height = maxHeight;
				sprite.scaleX = sprite.scaleY;
				
			} else {
				
				sprite.width = maxWidth;
				sprite.scaleY = sprite.scaleX;
				
			}
			
		}
		
		public static function IsRoot(sprite:Sprite):Boolean{
			
			// TODO, double check this. Got info from reference:
			// http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObject.html#parent
			// http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObject.html#root
			
			return (sprite.parent.toString() == "[object Stage]");
			
		}
		
		public static function RemoveChildren(displayObjectContainer:DisplayObjectContainer):void{
			
			while(displayObjectContainer.numChildren > 0){ displayObjectContainer.removeChildAt(0); }
			
		}
		
	}

}
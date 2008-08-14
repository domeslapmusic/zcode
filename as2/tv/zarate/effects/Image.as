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

import flash.filters.BlurFilter;
import tv.zarate.utils.Delegate;

class tv.zarate.effects.Image{

	public static function ChangeProperty(mc:MovieClip,property:String,to:Number,callback:Function,speed:Number):Void{
		
		if(speed == null){ speed = 3; }
		
		if(mc.smart_mc != null){
			
			delete mc.smart_mc.onEnterFrame;
			mc.smart_mc.removeMovieClip();
			
		}
		
		var d:Number = mc.getNextHighestDepth();
		var smart_mc:MovieClip;
		
		smart_mc = mc.createEmptyMovieClip("smart_"+d,d);
		mc.smart_mc = smart_mc;
		
		smart_mc.onEnterFrame = function():Void{
			
			mc[property] += (to - mc[property])/speed;
			
			var diff:Number = Math.abs(Math.abs(to) - Math.abs(mc[property]));
			
			if(diff <= 1){
				
				mc.smart_mc = null;
				delete this.onEnterFrame;
				this.removeMovieClip();
				if(callback != null){ callback(); }
				
			}
			
		}
		
	}
	
	public static function Fade(mc:MovieClip,to:Number,callback:Function,speed:Number):Void{
		ChangeProperty(mc,"_alpha",to,callback,speed);
	}
	
	public static function Blur(mc:MovieClip,to:Number,callback:Function,speed:Number):Void{
		
		if(speed == null){ speed = 4; }
		
		if(mc.smart_mc != null){
			
			delete mc.smart_mc.onEnterFrame;
			mc.smart_mc.removeMovieClip();
			
		}
		
		var d:Number = mc.getNextHighestDepth();
		var smart_mc:MovieClip;
		
		smart_mc = mc.createEmptyMovieClip("smart_"+d,d);
		mc.smart_mc = smart_mc;
		
		var blur:BlurFilter = (mc.filters[0] != null)? mc.filters[0] : new BlurFilter(0,0);
		
		if(blur.blurX > to){ speed *= -1; }
		
		var filters:Array = new Array();
		filters.push(blur);
		
		smart_mc.onEnterFrame = function():Void{
			
			blur.blurX += speed;
			blur.blurY += speed;
			
			mc.filters = filters;
			
			var diff:Number = Math.abs(Math.abs(to) - Math.abs(blur.blurX));
			
			if(diff <= 1){
				
				if(to == 0){ mc.filters = new Array(); }
				
				mc.smart_mc = null;
				delete this.onEnterFrame;
				this.removeMovieClip();
				if(callback != null){ callback(); }
				
			}
			
		}
		
	}
	
}
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
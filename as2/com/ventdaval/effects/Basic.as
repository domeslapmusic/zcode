import flash.filters.BlurFilter;
import flash.filters.ColorMatrixFilter;

class com.ventdaval.effects.Basic{

	public static function FadeBrightness(mc:MovieClip,init:Number,end:Number,speed:Number,callback:Function):Void{
		
		/* 
		* 0 > normal
		* 255 > white
		* -255 > black
		*/ 
		
		if(speed == null){ speed = 10; } 
		
		var col:Color = new Color(mc);
		col.setTransform({rb:init,gb:init,bb:init});
		
		mc.onEnterFrame = function():Void{
			
			init += (end-init)/speed;
			
			var b:Number = (Math.abs(init))/15;
			mc.filters = [new BlurFilter(b,b,2)];
			col.setTransform({rb:init,gb:init,bb:init});
			
			if(Math.abs(end-init)<1){
				
				init = end;
				col.setTransform({rb:init,gb:init,bb:init});
				
				if(callback != null){ callback(); }
				delete mc.onEnterFrame;
				
			}
			
		}
		
	}
	
	public static function DesaturateMe(mc:MovieClip):Void{
		
		var matrix:Array = new Array(0.308600038290024,0.609399974346161,0.0820000022649765,0,0,0.308600008487701,0.609399974346161,0.0820000022649765,0,0,0.308600008487701,0.609399974346161,0.0820000246167183,0,0,0,0,0,1,0);
		var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
		var filterArray:Array = new Array();
		filterArray.push(filter);
		mc.filters = filterArray;
		
	}
	
}
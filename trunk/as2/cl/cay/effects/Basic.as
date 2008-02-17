import flash.filters.BlurFilter;
import flash.filters.ColorMatrixFilter;
import flash.display.BitmapData;
import flash.geom.Matrix;

class com.ventdaval.effects.Basic{

	public static function WetFloor(mc:MovieClip,height:Number,margin:Number):Void{
		
		// This method needs a "gradient" clip on the library!!
		// TODO: Create the gradient by code
		
		if(height == null){ height = 40; }
		if(margin == null){ margin = 2; }
		
		var width:Number = mc._width;
		var initHeight:Number = mc._height;
		
		var bmp:BitmapData = new BitmapData(width,height,true,0);
		
		var reflection_mc:MovieClip = mc.createEmptyMovieClip("reflection_mc",mc.getNextHighestDepth());
		reflection_mc.attachBitmap(bmp,0,"never",true);
		
		var gradient_mc:MovieClip = reflection_mc.attachMovie("gradient","gradient_mc",100);
		gradient_mc._width = width;
		gradient_mc._height = height;
		
		reflection_mc.blendMode = "layer";
		gradient_mc.blendMode = "alpha";
		
		reflection_mc._y = mc._height + margin;
		
		var matrix:Matrix = new Matrix();
		matrix.scale(1,-1);
		matrix.translate(0,initHeight);
		
		bmp.fillRect(bmp.rectangle,0);
		bmp.draw(mc,matrix);
		
	}
	
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
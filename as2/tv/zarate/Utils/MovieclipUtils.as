/*
*
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
*
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*
*/

import flash.filters.DropShadowFilter;

class tv.zarate.Utils.MovieclipUtils{

	public static function MakeDropShadow(mc:MovieClip,distance:Number,angle:Number,colour:Number,alpha:Number,blur:Number,strength:Number):Void{
		
		if(distance == null){ distance = 3; }
		if(angle == null){ angle = 45; }
		if(colour == null){ colour = 0x000000; }
		if(alpha == null){ alpha = 0.9; }
		if(blur == null){ blur = 5; }
		if(strength == null){ strength = 1; }
		
		var shadow:DropShadowFilter = new DropShadowFilter(distance,angle,colour,alpha,blur,blur,strength,3,false,false,false);
		
		var filters:Array = mc.filters;
		if(filters == null){ filters = new Array(); }
		filters.push(shadow);
		
		mc.filters = filters;
		
	}
	
	public static function CentreHorizontal(master_mc:MovieClip,slave_mc:MovieClip):Void{
		slave_mc._x = Math.round((master_mc._width - slave_mc._width)/2);
	}
	
	public static function CentreVertical(master_mc:MovieClip,slave_mc:MovieClip):Void{
		slave_mc._y = Math.round((master_mc._height - slave_mc._height)/2);
	}
	
	public static function CentreClips(master_mc:MovieClip,slave_mc:MovieClip):Void{
		
		CentreHorizontal(master_mc,slave_mc);
		CentreVertical(master_mc,slave_mc);
		
	}
	
	public static function isRoot(mc:MovieClip):Boolean{
		return (mc._parent == null);
	}

	public static function MaxResize(mc:Object,maxWidth:Number,maxHeight:Number):Void{
		
		var appAspectRatio:Number = maxWidth/maxHeight;
		var contentAspectRatio:Number = mc._width/mc._height;
		var limitingAspect:String = (appAspectRatio > contentAspectRatio)? "h":"w";
		
		if(limitingAspect == "h"){
			
			mc._height = maxHeight;
			mc._xscale = mc._yscale;
			
		} else {
			
			mc._width = maxWidth;
			mc._yscale = mc._xscale;
			
		}
		
	}

	public static function LocalToGlobal(mc:MovieClip):Object{
		
		var p:Object = {x:0,y:0};
		mc.localToGlobal(p);
		return p;
		
	}

	public static function RootToLocal(mc:MovieClip):Object{
		
		var p:Object = {x:_root._xmouse,y:_root._ymouse};
		mc.globalToLocal(p);
		return p;
		
	}

	public static function getFocusObject():Object{
		
		// Selection.getFocus() returns *String* ¬¬
		return eval(Selection.getFocus());
		
	}

	public static function hasFocus(o:Object):Boolean{
		return (getFocusObject() == o);
	}

	public static function resetColour(m:MovieClip):Void{
		
		var c:Color = new Color(m);
		c.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0,aa:100,ab:0});
		
	}
	
	public static function changeColour(mc:MovieClip,newColour:Number):Void{
		var c:Color = new Color(mc);
		c.setRGB(newColour);
	}

	public static function DrawCircle(mc:MovieClip,radius:Number,mainColour:Number,mainAlpha:Number,
											borderSize:Number,borderColour:Number,borderAlpha:Number):Void{
		
		if(mainAlpha == null){ mainAlpha = 100; }
		
		var c1:Number;
		var c2:Number;
		var x:Number;
		var y:Number;
		
		c1 = radius*(Math.SQRT2-1);
		c2 = radius*Math.SQRT2/2;
		x = radius + borderSize;
		y = radius + borderSize;
		
		mc.beginFill(mainColour,mainAlpha);
		
		mc.moveTo(x+radius,y);
		mc.curveTo(x+radius,y+c1,x+c2,y+c2);
		mc.curveTo(x+c1,y+radius,x,y+radius);
		mc.curveTo(x-c1,y+radius,x-c2,y+c2);
		mc.curveTo(x-radius,y+c1,x-radius,y);
		mc.curveTo(x-radius,y-c1,x-c2,y-c2);
		mc.curveTo(x-c1,y-radius,x,y-radius);
		mc.curveTo(x+c1,y-radius,x+c2,y-c2);
		mc.curveTo(x+radius,y-c1,x+radius,y);
		
		mc.endFill();
		
		/*
				if(borderSize != null){
			
			if(borderAlpha == null){ borderAlpha = 100; }
			
			c1 = radius*(Math.SQRT2-1);
			c2 = radius*Math.SQRT2/2;
			x = radius;
			y = radius;
			
			mc.beginFill(borderColour,borderAlpha);
			
			mc.moveTo(x+radius,y);
			mc.curveTo(x+radius,y+c1,x+c2,y+c2);
			mc.curveTo(x+c1,y+radius,x,y+radius);
			mc.curveTo(x-c1,y+radius,x-c2,y+c2);
			mc.curveTo(x-radius,y+c1,x-radius,y);
			mc.curveTo(x-radius,y-c1,x-c2,y-c2);
			mc.curveTo(x-c1,y-radius,x,y-radius);
			mc.curveTo(x+c1,y-radius,x+c2,y-c2);
			mc.curveTo(x+radius,y-c1,x+radius,y);
			
			mc.endFill();
			
			radius -= borderSize;
			
		} else {
			
			borderSize = 0;
			
		}
*/
		
	}
	
	public static function DrawSquare(mc:MovieClip,mainColour:Number,mainAlpha:Number,width:Number,height:Number,
										borderSize:Number,borderColour:Number,borderAlpha:Number):Void{
		
		
		if(borderSize == null){ borderSize = 0; }
		if(mainAlpha == null){ mainAlpha = 100; }
		
		var mainWidth:Number = width - (borderSize*2);
		var mainHeight:Number = height - (borderSize*2);
		
		var main_mc:MovieClip = mc.createEmptyMovieClip("main_mc",100);
		main_mc._x = main_mc._y = borderSize;
		
		main_mc.beginFill(mainColour,mainAlpha);
		main_mc.lineTo(0,mainHeight);
		main_mc.lineTo(mainWidth,mainHeight);
		main_mc.lineTo(mainWidth,0);
		main_mc.lineTo(0,0);
		main_mc.endFill();
		
		if(borderSize > 0){
			
			var border_mc:MovieClip = mc.createEmptyMovieClip("border_mc",50);
			DrawSquare(border_mc,borderColour,borderAlpha,width,height);
			
		}
		
	}

	public static function DrawRoundedSquare(mc:MovieClip,mainColour:Number,mainAlpha:Number,width:Number,height:Number,cornerRadius:Number,
										borderSize:Number,borderColour:Number,borderAlpha:Number){
		
		if(borderSize == null){ borderSize = 0; }
		if(mainAlpha == null){ mainAlpha = 100; }
		if(mainColour == null){ mainColour = 0x000000; }
		
		var maxWidth:Number = width - borderSize*2;
		var maxHeight:Number = height - borderSize*2;
		
		if(borderSize > 0){ DrawSimpleRoundedSquare(mc,borderColour,borderAlpha,width,height,cornerRadius); }
		DrawSimpleRoundedSquare(mc,mainColour,mainAlpha,maxWidth,maxHeight,cornerRadius,borderSize);
		
	}
	
	// *************************** PRIVATE METHODS ***************************
	
	private static function DrawSimpleRoundedSquare(mc:MovieClip,mainColour:Number,mainAlpha:Number,w:Number,h:Number,cornerRadius:Number,pos:Number):Void{
		
		if(pos == null){ pos = 0; }
		
		mc.beginFill(mainColour,mainAlpha);
		
		mc.moveTo(pos+cornerRadius,pos+0);
		mc.lineTo(pos+w-cornerRadius,pos+0);
		mc.curveTo(pos+w,pos+0,pos+w,pos+cornerRadius);
		mc.lineTo(pos+w,pos+cornerRadius);
		mc.lineTo(pos+w,pos+h-cornerRadius);
		mc.curveTo(pos+w,pos+h,pos+w-cornerRadius,pos+h);
		mc.lineTo(pos+w-cornerRadius,pos+h);
		mc.lineTo(pos+cornerRadius,pos+h);
		mc.curveTo(pos+0,pos+h,pos+0,pos+h-cornerRadius);
		mc.lineTo(pos+0,pos+h-cornerRadius);
		mc.lineTo(pos+0,pos+cornerRadius);
		mc.curveTo(pos+0,pos+0,pos+cornerRadius,pos+0);
		mc.lineTo(pos+cornerRadius,pos+0);
		
		mc.endFill();
		
	}
	
}
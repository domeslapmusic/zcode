/*
*
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
*
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*
*/

class tv.zarate.Utils.MovieclipUtils{

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

	public static function changeColour(mc:MovieClip,newColour:Number):Void{
		var c:Color = new Color(mc);
		c.setRGB(newColour);
	}

	public static function DrawSquare(mc:MovieClip,mainColour:Number,mainAlpha:Number,width:Number,height:Number,
										borderSize:Number,borderColour:Number,borderAlpha:Number):Void{


		if(borderSize == null) borderSize = 0;
		var mainWidth:Number = width-(borderSize*2);
		var mainHeight:Number = height-(borderSize*2);

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

			border_mc.beginFill(borderColour,borderAlpha);
			border_mc.lineTo(0,height);
			border_mc.lineTo(width,height);
			border_mc.lineTo(width,0);
			border_mc.lineTo(0,0);
			border_mc.endFill();

		}

	}

}
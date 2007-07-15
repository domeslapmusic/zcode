import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.Projects.zplayer.Player;
import tv.zarate.Projects.zplayer.Item;

class tv.zarate.Projects.zplayer.PlayerImage extends Player{

	private var image_mc:MovieClip;
	private var mask_mc:MovieClip;
	private var customCursor_mc:MovieClip;

	private var GRAB_CURSOR:String = "grab_mouse";
	private var GRABBING_CURSOR:String = "grabbing_mouse";

	public function PlayerImage(image:Item,base_mc:MovieClip){

		super(image,base_mc);

	}

	public function playItem():Void{

		image_mc = base_mc.createEmptyMovieClip("image_mc",100);

		var imageLoader_mc:MovieClip = image_mc.createEmptyMovieClip("imageLoader_mc",100);

		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(item.url,imageLoader_mc);

		mask_mc = base_mc.createEmptyMovieClip("mask_mc",200);
		MovieclipUtils.DrawSquare(mask_mc,0xff00ff,100,width,height);

		image_mc.setMask(mask_mc);

	}

	public function remove():Void{

		super.remove();

	}

	// **************** PRIVATE METHODS ****************

	private function onLoadError():Void{

		// TODO, handle error here

	}

	private function onLoadInit(mc:MovieClip):Void{

		checkImageDimensions();

		if(mc._width < width){

			image_mc._x = Math.round((width-image_mc._width)/2);

		}

		if(mc._height < height){

			image_mc._y = Math.round((height-image_mc._height)/2);

		}

	}

	private function checkImageDimensions():Void{

		if(image_mc._width > width || image_mc._height > height){

			addDragAndDrop();

		}

	}

	private function addDragAndDrop():Void{

		image_mc.onPress = Delegate.create(this,startDrag);
		image_mc.onRelease = image_mc.onReleaseOutside = Delegate.create(this,stopDrag);
		image_mc.onRollOver = Delegate.create(this,showCustomCursor,true);
		image_mc.onRollOut = Delegate.create(this,showCustomCursor,false);

		image_mc.enabled = true;

		var fitInScreen_mc:MovieClip = base_mc.attachMovie("fitinscreen_icon","fitInScreen_mc",300);
		fitInScreen_mc.onPress = Delegate.create(this,fitInScreen);

		fitInScreen_mc._x = width - fitInScreen_mc._width;

		var zoom_mc:MovieClip = base_mc.attachMovie("zoom_icon","zoom_mc",400);
		zoom_mc.onPress = Delegate.create(this,zoomImage);

		zoom_mc._x = fitInScreen_mc._x;
		zoom_mc._y = fitInScreen_mc._y + fitInScreen_mc._height + 10;

	}

	private function fitInScreen():Void{

		MovieclipUtils.MaxResize(image_mc,width,height);
		centreImage();

		image_mc.enabled = false;

		checkImageDimensions();

	}

	private function zoomImage():Void{

		image_mc._xscale = image_mc._yscale = 100;
		centreImage();

		checkImageDimensions();

	}

	private function centreImage():Void{

		image_mc._x = Math.round((width - image_mc._width)/2);
		image_mc._y = Math.round((height - image_mc._height)/2);

	}

	private function showCustomCursor(action:Boolean):Void{

		if(action){

			var o:Object = MovieclipUtils.RootToLocal(base_mc);

			customCursor_mc = base_mc.createEmptyMovieClip("customCursor_mc",500);
			customCursor_mc._x = o.x;
			customCursor_mc._y = o.y;

			changeCursorTo(GRAB_CURSOR);

			Mouse.addListener(this);
			Mouse.hide();

		} else {

			customCursor_mc.removeMovieClip();
			Mouse.show();
			Mouse.removeListener(this);

		}

	}

	private function changeCursorTo(linkage:String):Void{
		customCursor_mc.attachMovie(linkage,"cursorIcon_mc",100);
	}

	private function startDrag():Void{

		changeCursorTo(GRABBING_CURSOR);

		var canvasMargin:Number = 0;

		var minX:Number = (image_mc._width > width)? width-image_mc._width:image_mc._x;
		var minY:Number = (image_mc._height > height)? height-image_mc._height:image_mc._y;

		var maxX:Number = (image_mc._width > width)? canvasMargin:minX;
		var maxY:Number = (image_mc._height > height)? canvasMargin:minY;

		image_mc.startDrag(false,minX,minY,maxX,maxY);

	}

	private function stopDrag():Void{

		changeCursorTo(GRAB_CURSOR);
		image_mc.stopDrag();

	}

	private function onMouseMove():Void{

		var o:Object = MovieclipUtils.RootToLocal(base_mc);

		customCursor_mc._x = o.x;
		customCursor_mc._y = o.y;

	}

}
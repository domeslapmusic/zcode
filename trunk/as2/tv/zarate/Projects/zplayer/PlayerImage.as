import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.Projects.zplayer.Player;
import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpImage;
import tv.zarate.Projects.zplayer.LoadBar;

class tv.zarate.Projects.zplayer.PlayerImage extends Player{

	private var loadbar:LoadBar;
	private var image:zpImage;

	private var image_mc:MovieClip;
	private var mask_mc:MovieClip;
	private var customCursor_mc:MovieClip;
	private var soundLoaderChecker_mc:MovieClip;
	private var soundPositionChecker_mc:MovieClip;
	private var loadbar_mc:MovieClip;

	private var soundPath:String = "";
	private var hasSound:Boolean = false;
	private var sound:Sound;
	private var GRAB_CURSOR:String = "grab_mouse";
	private var GRABBING_CURSOR:String = "grabbing_mouse";
	private var autoInterval:Number;

	public function PlayerImage(_image:Item,base_mc:MovieClip,finishCallback:Function){

		image = zpImage(_image);

		soundPath = image.sound;
		hasSound = (soundPath != undefined);

		super(image,base_mc,finishCallback);

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

		if(hasSound){

			loadSound();

		}

	}

	public function remove():Void{

		super.remove();

		if(autoInterval != null){ clearInterval(autoInterval); }

		sound.stop();
		delete sound;

		Mouse.removeListener(this);

	}

	// **************** PRIVATE METHODS ****************

	private function loadSound():Void{

		sound = new Sound();
		sound.onLoad = Delegate.create(this,soundLoaded);
		sound.onSoundComplete = Delegate.create(this,finished);
		sound.loadSound(soundPath,true);

		loadbar_mc = base_mc.createEmptyMovieClip("loadbar_mc",600);
		loadbar = new LoadBar(loadbar_mc,width);
		loadbar.onDrag = Delegate.create(this,onDrag);

		soundLoaderChecker_mc = base_mc.createEmptyMovieClip("soundLoaderChecker_mc",700);
		soundLoaderChecker_mc.onEnterFrame = Delegate.create(this,checkSoundLoad);

		soundPositionChecker_mc = base_mc.createEmptyMovieClip("soundPositionChecker_mc",800);
		soundPositionChecker_mc.onEnterFrame = Delegate.create(this,checkSoundPosition);

	}

	private function onDrag(percent:Number):Void{

		var soundPosition:Number = (sound.duration * percent)/1000;
		sound.start(soundPosition);

	}

	private function checkSoundLoad():Void{

		var loaded:Number = sound.getBytesLoaded();
		var total:Number = sound.getBytesTotal();

		if(loaded >= total && total > 10){

			loadbar.update(1);
			delete soundLoaderChecker_mc.onEnterFrame;
			soundLoaderChecker_mc.removeMovieClip();

		} else {

			var percent:Number = loaded/total;
			loadbar.update(percent);

		}

	}

	private function checkSoundPosition():Void{

		var duration:Number = image.duration;
		var percentPos:Number = 0;

		percentPos = sound.position/duration;
		loadbar.updatePosition(percentPos);

	}

	private function soundLoaded(success:Boolean):Void{

		delete sound.onLoad;

		if(!success){

			trace("Impossible to load sound > " + soundPath);

		}

	}

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

		if(!hasSound){

			autoInterval = setInterval(this,"finished",5000);

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

	private function finished():Void{

		trace("finishing image");
		finishCallback();

	}

}
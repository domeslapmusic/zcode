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

import tv.zarate.utils.Delegate;
import tv.zarate.utils.MovieclipUtils;

import tv.zarate.projects.zplayer.zpConstants;

class tv.zarate.projects.zplayer.LoadBar{

	public var onDrag:Function;
	public var onToggle:Function;
	public var onSoundChange:Function;

	private var mainBar_mc:MovieClip;
	private var bar_mc:MovieClip;
	private var background_mc:MovieClip;
	private var base_mc:MovieClip;
	private var tracker_mc:MovieClip;
	private var play_mc:MovieClip;
	private var pause_mc:MovieClip;

	private var height:Number = 0;
	private var barHeight:Number = 10;
	private var border:Number = 1;
	private var maxWidth:Number = 0;
	private var maxTrackerPosition:Number = 0;
	private var updateTracker:Boolean = true;
	private var barPercentage:Number = 0.3;
	private var playing:Boolean = false;
	private var margin:Number = 10;
	private var currentVolume:Number = 100;

	public function LoadBar(_base_mc:MovieClip,width:Number){
		
		base_mc = _base_mc;
		
		height = zpConstants.LOAD_BAR_HEIGHT;
		
		maxWidth = Math.round(width * barPercentage);
		
		background_mc = base_mc.createEmptyMovieClip("background_mc",50);
		MovieclipUtils.DrawSquare(background_mc,0xffffff,100,width,height);
		
		mainBar_mc = base_mc.createEmptyMovieClip("mainBar_mc",100);
		
		var barBackground_mc:MovieClip = mainBar_mc.createEmptyMovieClip("barBackground_mc",100);
		MovieclipUtils.DrawSquare(barBackground_mc,0x726e6e,100,maxWidth,barHeight,border,0xaaaaaa,100);
		
		bar_mc = mainBar_mc.createEmptyMovieClip("bar_mc",200);
		bar_mc._y = border;
		
		bar_mc.onPress = Delegate.create(this,barPressed);
		
		tracker_mc = mainBar_mc.createEmptyMovieClip("tracker_mc",300);
		MovieclipUtils.DrawSquare(tracker_mc,0x33aa33,100,5,barHeight);
		
		tracker_mc.onPress = Delegate.create(this,startDrag);
		tracker_mc.onRelease = tracker_mc.onReleaseOutside = Delegate.create(this,stopDrag);
		
		maxTrackerPosition = maxWidth - tracker_mc._width;
		
		var toggleButton_mc:MovieClip = base_mc.createEmptyMovieClip("tracker_mc",400);
		toggleButton_mc._x = margin;
		
		play_mc = toggleButton_mc.attachMovie("play","play_mc",100);
		pause_mc = toggleButton_mc.attachMovie("pause","pause_mc",200);
		pause_mc._visible = false;
		
		toggleButton_mc.onPress = Delegate.create(this,togglePlay);
		
		mainBar_mc._x = toggleButton_mc._x + toggleButton_mc._width + 10; 
		
		var soundDown_mc:MovieClip = base_mc.attachMovie("lesssound","soundDown_mc",6000);
		soundDown_mc._x = mainBar_mc._x + mainBar_mc._width + margin;
		
		var soundUp_mc:MovieClip = base_mc.attachMovie("moresound","soundUp_mc",500);
		soundUp_mc._x = soundDown_mc._x + soundDown_mc._width;
		soundUp_mc._y = soundDown_mc._y;
		
		soundUp_mc.onPress = Delegate.create(this,manageSound,true);
		soundDown_mc.onPress = Delegate.create(this,manageSound,false);
		
		MovieclipUtils.CentreVertical(base_mc,mainBar_mc);
		MovieclipUtils.CentreVertical(base_mc,toggleButton_mc);
		MovieclipUtils.CentreVertical(base_mc,soundDown_mc);
		MovieclipUtils.CentreVertical(base_mc,soundUp_mc);
		
	}

	public function update(percent:Number):Void{
		
		// percent is a value between 0 and 1
		
		var w:Number = Math.round(maxWidth * percent);
		MovieclipUtils.DrawSquare(bar_mc,0xffffff,100,w,barHeight-border*2);
		
	}

	public function updatePosition(percent:Number):Void{
		
		if(updateTracker){
			
			var pos:Number = Math.round(maxTrackerPosition * percent);
			tracker_mc._x = pos;
			
		}
		
	}

	public function togglePlay():Void{
		
		playing = !playing;
		pause_mc._visible = playing;
		
		onToggle(playing);
		
	}
	
	public function remove():Void{
		base_mc.removeMovieClip();
	}

	// **************** PRIVATE METHODS ****************

	private function startDrag():Void{
		
		updateTracker = false;
		tracker_mc.startDrag(false,0,tracker_mc._y,bar_mc._width-tracker_mc._width,tracker_mc._y);
		
	}

	private function stopDrag():Void{
		
		tracker_mc.stopDrag();
		
		calculateOnDrag();
		
		updateTracker = true;
		
	}

	private function barPressed():Void{
		
		var localX:Number = MovieclipUtils.RootToLocal(bar_mc).x;
		
		tracker_mc._x = localX;
		
		calculateOnDrag();
		
	}

	private function calculateOnDrag():Void{
		
		var trackerPercentPosition:Number = tracker_mc._x/maxTrackerPosition;
		onDrag(trackerPercentPosition);
		
	}
	
	private function manageSound(up:Boolean):Void{
		
		var mod:Number = (up)? 10:-10;
		
		var newVol:Number = currentVolume + mod;
		
		if(newVol < 0){ newVol = 0; }
		if(newVol > 100){ newVol = 100; }
		
		currentVolume = newVol;
		
		onSoundChange(newVol);
		
	}
	
}
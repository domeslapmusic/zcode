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
import tv.zarate.utils.TextfieldUtils;

import tv.zarate.effects.Image;

import tv.zarate.projects.zplayer.Player;
import tv.zarate.projects.zplayer.zpVideo;
import tv.zarate.projects.zplayer.Item;
import tv.zarate.projects.zplayer.LoadBar;

class tv.zarate.projects.zplayer.PlayerVideo extends Player{

	private var loadbar:LoadBar;

	private var video_mc:MovieClip;
	private var loadbar_mc:MovieClip;
	private var checkLoad_mc:MovieClip;
	private var bigPlayIcon_mc:MovieClip;
	private var intro_mc:MovieClip;

	private var videoObj:Video;
	private var stream_ns:NetStream;
	private var connection_nc:NetConnection;
	private var sound:Sound;
	private var videoDuration:Number = 0;
	private var timeElapsed:Number = 0;
	private var currentVolume:Number = 0;
	private var playing:Boolean = false;

	public function PlayerVideo(video:Item,base_mc:MovieClip,finishCallback:Function){
		
		super(video,base_mc,finishCallback);
		
	}

	public function playItem():Void{
		
		// specific black background for videos
		var bg_mc:MovieClip = base_mc.createEmptyMovieClip("bg_mc",50);
		MovieclipUtils.DrawSquare(bg_mc,0x000000,100,width,height);
		
		// create connection to load video
		clearConnection();
		
		connection_nc = new NetConnection();
		connection_nc.connect(null);
		
		stream_ns = new NetStream(connection_nc);
		
		video_mc = base_mc.attachMovie("VideoDisplay","video_mc",100);
		
		videoObj = video_mc.video;
		videoObj.attachVideo(stream_ns);
		
		checkLoad_mc = video_mc.createEmptyMovieClip("checkLoad_mc",100);
		checkLoad_mc.onEnterFrame = Delegate.create(this,checkLoad);
		
		stream_ns.onStatus = Delegate.create(this,statusHandler);
		stream_ns.onMetaData = Delegate.create(this,setMetaData);
		
		MovieclipUtils.MaxResize(video_mc,width,height);
		centreVideo();
		
		startChecking(true);
		
		stream_ns.play(item.url);
		stream_ns.pause(true);
		
		// load bar to show *video* download progress
		
		loadbar_mc = base_mc.createEmptyMovieClip("loadbar_mc",300);
		loadbar = new LoadBar(loadbar_mc,width);
		loadbar.onDrag = Delegate.create(this,onDrag);
		loadbar.onToggle = Delegate.create(this,onToggle);
		loadbar.onSoundChange = Delegate.create(this,updateSound);
		
		loadbar_mc._y = height - loadbar_mc._height;
		
		video_mc.attachAudio(stream_ns);		
		sound = new Sound(video_mc);
		
		// load intro image
		
		intro_mc = base_mc.createEmptyMovieClip("intro_mc",150);
		intro_mc._alpha = 0;
		
		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(zpVideo(item).intro,intro_mc);
		
		// add play icon
		
		var bigPlay_mc:MovieClip = base_mc.createEmptyMovieClip("bigPlay_mc",200);
		
		var bigPlayBackground_mc:MovieClip = bigPlay_mc.createEmptyMovieClip("bigPlayBackground_mc",100);
		MovieclipUtils.DrawSquare(bigPlayBackground_mc,0xffff00,0,width,height);
		
		bigPlayIcon_mc = bigPlay_mc.attachMovie("bigplay","bigPlayIcon_mc",200);
		
		MovieclipUtils.CentreClips(base_mc,bigPlayIcon_mc);
		
		bigPlay_mc.onPress = Delegate.create(this,bigPlayPressed);
		
	}

	public function remove():Void{
		
		super.remove();
		clearConnection();
		
	}

	// **************** PRIVATE METHODS ****************
	
	private function onLoadInit(mc:MovieClip):Void{
		
		Image.Fade(mc,100);
		
	}
	
	private function bigPlayPressed():Void{
		
		loadbar.togglePlay();
		
	}
	
	private function onDrag(percent:Number):Void{
		
		var videoPosition:Number = videoDuration * percent;
		stream_ns.seek(videoPosition);
		
	}

	private function onToggle(playing:Boolean):Void{
		
		if(intro_mc != null){ intro_mc.removeMovieClip(); }
		
		stream_ns.pause(!playing);
		bigPlayIcon_mc._visible = !playing;
		
	}
	
	private function startChecking(action:Boolean):Void{
		
		if(action){
			
			video_mc.onEnterFrame = Delegate.create(this,checkPosition);
			
		} else {
			
			delete video_mc.onEnterFrame;
			
		}
		
	}

	private function checkPosition():Void{
		
		timeElapsed = stream_ns.time;
		
		if(timeElapsed >= videoDuration && videoDuration > 0){
			
			loadbar.togglePlay();			
			stream_ns.seek(0);
			timeElapsed = 0;
			//finishCallback(); // just dont calling finish callback for the time being
			
		}
		
		var percentPos:Number = timeElapsed/videoDuration;
		loadbar.updatePosition(percentPos);
		
	}

	private function setPosition(position:Number):Void{
		stream_ns.seek(position);
	}

	private function checkLoad():Void{
		
		var loaded:Number = stream_ns.bytesLoaded;
		var total:Number = stream_ns.bytesTotal;
		
		if(loaded >= total && total > 10){
			
			loadbar.update(1);
			delete checkLoad_mc.onEnterFrame;
			checkLoad_mc.removeMovieClip();
			
			delete checkLoad_mc;
			
		} else {
			
			var percent:Number = loaded/total;
			loadbar.update(percent);
			
		}
		
	}

	private function setVolume(v:Number):Void{
		sound.setVolume(v);
	}

	private function clearConnection():Void{
		
		if(connection_nc != null){
			
			connection_nc.close();
			stream_ns.play(null);
			stream_ns.close();
			
			delete connection_nc;
			delete stream_ns;
			
		}
		
	}

	private function centreVideo():Void{
		
		video_mc._x = Math.round((width - video_mc._width)/2);
		video_mc._y = Math.round((height - video_mc._height)/2);
		
	}

	private function updateSound(vol:Number):Void{
		sound.setVolume(vol);
	}
	
	private function setMetaData(stream:Object):Void{
		videoDuration = stream.duration;
	}

	private function statusHandler(infObj:Object){
		
		// void for the time being
		
	}

}
import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.effects.Image;

import tv.zarate.Projects.zplayer.Player;
import tv.zarate.Projects.zplayer.zpVideo;
import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.LoadBar;

class tv.zarate.Projects.zplayer.PlayerVideo extends Player{

	private var loadbar:LoadBar;

	private var video_mc:MovieClip;
	private var loadbar_mc:MovieClip;
	private var checkLoad_mc:MovieClip;
	private var bigPlay_mc:MovieClip;
	private var intro_mc:MovieClip;

	private var videoObj:Video;
	private var stream_ns:NetStream;
	private var connection_nc:NetConnection;
	private var sound:Sound;
	private var videoDuration:Number = 0;
	private var timeElapsed:Number = 0;
	private var currentVolume:Number = 0;

	public function PlayerVideo(video:Item,base_mc:MovieClip,finishCallback:Function){
		
		super(video,base_mc,finishCallback);
		
	}

	public function playItem():Void{
		
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
		
		loadbar_mc = base_mc.createEmptyMovieClip("loadbar_mc",200);
		loadbar = new LoadBar(loadbar_mc,width);
		loadbar.onDrag = Delegate.create(this,onDrag);
		loadbar.onToggle = Delegate.create(this,onToggle);
		loadbar.onSoundChange = Delegate.create(this,updateSound);
		
		loadbar_mc._y = height - loadbar_mc._height;
		
		video_mc.attachAudio(stream_ns);		
		sound = new Sound(video_mc);
		
		// load intro image
		
		intro_mc = base_mc.createEmptyMovieClip("intro_mc",750);
		intro_mc._alpha = 0;
		
		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(zpVideo(item).intro,intro_mc);
		
		// add play icon
		
		bigPlay_mc = base_mc.attachMovie("bigplay","bigPlay_mc",800);
		MovieclipUtils.CentreClips(base_mc,bigPlay_mc);
		
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
		removeBigPlay();
		
	}
	
	private function removeBigPlay():Void{
		
		if(bigPlay_mc != null){
			
			intro_mc.removeMovieClip();
			bigPlay_mc.removeMovieClip();
			bigPlay_mc = null;
			
		}
		
	}
	
	private function onDrag(percent:Number):Void{
		
		var videoPosition:Number = videoDuration * percent;
		stream_ns.seek(videoPosition);
		
	}

	private function onToggle(playing:Boolean):Void{
		
		removeBigPlay();
		stream_ns.pause(!playing);
		
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
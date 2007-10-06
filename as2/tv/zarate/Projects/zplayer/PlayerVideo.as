import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.Player;
import tv.zarate.Projects.zplayer.zpVideo;
import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.LoadBar;

class tv.zarate.Projects.zplayer.PlayerVideo extends Player{

	private var loadbar:LoadBar;

	private var video_mc:MovieClip;
	private var loadbar_mc:MovieClip;
	private var checkLoad_mc:MovieClip;
	private var totalTime_mc:MovieClip;

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
		
		loadbar_mc = base_mc.createEmptyMovieClip("loadbar_mc",200);
		loadbar = new LoadBar(loadbar_mc,width);
		loadbar.onDrag = Delegate.create(this,onDrag);
		loadbar.onToggle = Delegate.create(this,onToggle);
		loadbar.onSoundChange = Delegate.create(this,updateSound);
		
		loadbar_mc._y = height - loadbar_mc._height;
		
		totalTime_mc = base_mc.createEmptyMovieClip("totalTime_mc",300);
		
		var field:TextField = TextfieldUtils.createField(totalTime_mc);
		field.text = "Loading...";
		
		video_mc.attachAudio(stream_ns);
		
		sound = new Sound(video_mc);
		
	}

	public function remove():Void{
		
		super.remove();
		clearConnection();
		
	}

	// **************** PRIVATE METHODS ****************

	private function onDrag(percent:Number):Void{
		
		var videoPosition:Number = videoDuration * percent;
		
		//trace("onDrag videoPosition > " + videoPosition + " -- percent > " + percent)
		
		stream_ns.seek(videoPosition);
		
	}

	private function onToggle(playing:Boolean):Void{
		
		//trace("onToggle > " + playing)
		
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
			
			stream_ns.pause(true);
			startChecking(false);
			stream_ns.seek(0);
			timeElapsed = 0;
			//finishCallback(); // just dont calling finish callback for the time being
			
		}
		
		var percentPos:Number = timeElapsed/videoDuration;
		loadbar.updatePosition(percentPos);
		
		totalTime_mc.field.text = timeElapsed + " -- " + videoDuration;
		
	}

	private function setPosition(position:Number):Void{
		
		trace("setPosition > " + position)
		
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
		
		/*
		for(var x:String in stream){
			trace("meta > " + x + ' : ' + stream[x] )
		}
		*/
		videoDuration = stream.duration;
		
	}

	private function statusHandler(infObj:Object){
		
		/*
		for(var x:String in infObj){
			trace("status > " + x + ' : ' + infObj[x] )
		}
		*/
		
	}

}
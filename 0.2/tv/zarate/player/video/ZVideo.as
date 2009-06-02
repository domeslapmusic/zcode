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

package tv.zarate.player.video{
	
	import flash.display.Sprite;
	import flash.net.NetStream;
	import flash.net.NetConnection;
	import flash.media.Video;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.NetStatusEvent;
	import flash.events.IOErrorEvent;
	
	import tv.zarate.player.iPlayer;
	import tv.zarate.player.events.evLoadProgress;
	import tv.zarate.player.events.evLoadFinished;
	import tv.zarate.player.events.evPlayerFinished;
	import tv.zarate.player.video.evOnMetaData;
	
	/**
	* Subscribe to this event to monitor player's load progress.
	* @eventType tv.zarate.player.events.evLoadProgress.LOAD_PROGRESS
	*/
	[Event(name="load_progress",type="tv.zarate.player.events.evLoadProgress")]
	
	/**
	* Subscribe to this event to monitor when the video has been fully loaded.
	* @eventType tv.zarate.player.events.evLoadFinished.LOAD_FINISHED
	*/
	[Event(name="load_finished",type="tv.zarate.player.events.evLoadFinished")]
	
	/**
	* Subscribe to this event to monitor when the video finishes.
	* @eventType tv.zarate.player.events.evPlayerFinished.PLAYER_FINISHED
	*/
	[Event(name="player_finished",type="tv.zarate.player.events.evPlayerFinished")]
	
	/**
	* Subscribe to receive metadata information. Remeber that metadata information doesn't follow any standard and the information contained is up to whoever encoded the video.
	* @eventType tv.zarate.player.video.evOnMetaData.META_DATA
	*/
	[Event(name="meta_data",type="tv.zarate.player.video.evOnMetaData")]
	
	/**
	* Subscribe to this event to be notified if the video cannot be found.
	* @eventType flash.events.IOErrorEvent
	*/
	[Event(name="ioError",type="flash.events.IOErrorEvent")]
	
	public class ZVideo extends Sprite implements iPlayer{
		
		protected var stream_ns:NetStream;
		protected var connection_nc:NetConnection;
		protected var video:Video;
		protected var videoSound:SoundTransform;
		
		protected var duration:Number;
		protected var videoURL:String;
		protected var loadingTimer:Timer;
		protected var autoplay:Boolean;
		protected var initialVolume:Number = 1;
		protected var _playing:Boolean;
		protected var _bytesLoaded:Number;
		protected var _bytesTotal:Number;
		
		public function ZVideo(){
			
			super();
			
		}
		
		public function load(url:String,autoplay:Boolean=false):void{
			
			videoURL = url;
			this.autoplay = autoplay;
			_playing = autoplay;
			
			createVideo();
			
		}
		
		public function isPlaying():Boolean{
			return _playing;
		}
		
		public function toggle():Boolean{
			
			if(_playing){
				pause();
			} else {
				play();
			}
			
			return _playing;
			
		}
		
		public function play():void{
			
			stream_ns.resume();
			_playing = true;
			
		}
		
		public function pause():void{
			
			if(stream_ns != null){ stream_ns.pause(); }
			_playing = false;
			
		}
		
		public function reset():void{
			setTime(0);
		}
		
		public function getDuration():Number{
			return duration;
		}
		
		public function setTime(pos:Number):void{
			
			var t:Number = getTime();
			
			if(pos < 0){ pos = 0; }
			if(pos > t){ pos = t; }
			
			stream_ns.seek(pos);
			
		}
		
		public function getTime():Number{
			return stream_ns.time;
		}
		
		public function getTimePercentage():Number{
			return getTime()/getDuration();
		}
		
		public function setVolume(volume:Number):Number{
			
			if(volume < 0){ volume = 0; }
			if(volume > 1){ volume = 1; }
			
			if(videoSound == null){
				
				initialVolume = volume;
				
			} else {
				
				videoSound.volume = volume;
				if(stream_ns != null){ stream_ns.soundTransform = videoSound; } // people might call setVolume before load
				
			}
			
			return getVolume();
			
		}
		
		public function getVolume():Number{
			return (videoSound != null)? videoSound.volume : initialVolume;
		}
		
		public function get bytesLoaded():Number{
			return _bytesLoaded;
		}
		
		public function get bytesTotal():Number{
			return _bytesTotal;
		}
		
		// ******************* PRIVATE METHODS *******************
		
		protected function createVideo():void{
			
			loadingTimer = new Timer(100);
			loadingTimer.addEventListener(TimerEvent.TIMER,checkBytesLoaded);
			loadingTimer.start();
			
			videoSound = new SoundTransform(initialVolume,0);
			
			if(connection_nc != null){
				
				connection_nc.close();
				stream_ns.play(null);
				stream_ns.close();
				
				connection_nc = null;
				stream_ns = null;
				
			}
			
			connection_nc = new NetConnection();
			connection_nc.connect(null);
			
			stream_ns = new NetStream(connection_nc);
			
			// I don't bloody understand why we have to listen to a standard event for NetStatusEvent.NET_STATUS
			// but we need a stupid client object for the metadata. Until I find out, we'll have to get over it.
			
			var netClient:Object = new Object();
			netClient.onMetaData = onMetaData;
			
			stream_ns.addEventListener(NetStatusEvent.NET_STATUS,onPlayStatus);
			
			stream_ns.client = netClient;
			stream_ns.soundTransform = videoSound;
			stream_ns.play(videoURL);
			
			video = new Video(160,120);
			video.attachNetStream(stream_ns);
			
			addChild(video);
			
		}
		
		protected function checkBytesLoaded(e:TimerEvent):void{
			
			_bytesLoaded = stream_ns.bytesLoaded;
			_bytesTotal = stream_ns.bytesTotal;
			
			dispatchEvent(new evLoadProgress(this,_bytesLoaded,_bytesTotal,(_bytesLoaded/_bytesTotal)));
			
			if(_bytesLoaded >= _bytesTotal && _bytesTotal > 0){
				
				loadingTimer.stop();
				dispatchEvent(new evLoadFinished(this));
				
			}
			
		}
		
		protected function onMetaData(metadata:Object):void{
			
			if(!autoplay){ pause(); }
			
			duration = metadata.duration;
			dispatchEvent(new evOnMetaData(this,metadata));
			
		}
		
		protected function onPlayStatus(e:NetStatusEvent):void{
			
			switch(e.info.code){
				
				case "NetStream.Play.Stop": 
					
					dispatchEvent(new evPlayerFinished(this));
					break;
					
				case "NetStream.Play.StreamNotFound":
					
					loadingTimer.stop();
					dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
					break;
				
			}
			
		}
		
	}

}
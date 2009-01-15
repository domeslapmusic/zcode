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
	
	import tv.zarate.player.iPlayer;
	import tv.zarate.player.events.evLoadProgress;
	import tv.zarate.player.events.evLoadFinished;
	import tv.zarate.player.video.evOnMetaData;
	
	public class ZVideo extends Sprite implements iPlayer{
		
		private var stream_ns:NetStream;
		private var connection_nc:NetConnection;
		private var video:Video;
		private var videoSound:SoundTransform;
		private var videoURL:String;
		private var duration:Number;
		private var loadingTimer:Timer;
		private var _playing:Boolean;
		private var autoplay:Boolean;
		private var _bytesLoaded:Number;
		private var _bytesTotal:Number;
		private var initialVolume:Number = 1;
		
		public function ZVideo(){
			
			super();
			
		}
	
		public function load(url:String,autoplay:Boolean=false):void{
			
			videoURL = url;
			this.autoplay = autoplay;
			_playing = autoplay;
			
			createVideo();
			
		}
		
		public function get playing():Boolean{
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
		
		private function createVideo():void{
			
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

			var netClient:Object = new Object();
			netClient.onMetaData = onMetaData;
			netClient.onPlayStatus = onPlayStatus;

			stream_ns.client = netClient;
			stream_ns.soundTransform = videoSound;
			stream_ns.play(videoURL);
			
			video = new Video(160,120);
			video.attachNetStream(stream_ns);
			
			addChild(video);
			
		}
		
		private function checkBytesLoaded(e:TimerEvent):void{
			
			_bytesLoaded = stream_ns.bytesLoaded;
			_bytesTotal = stream_ns.bytesTotal;
			
			dispatchEvent(new evLoadProgress(this,_bytesLoaded,_bytesTotal,(_bytesLoaded/_bytesTotal)));
			
			if(_bytesLoaded >= _bytesTotal){
				
				loadingTimer.stop();
				dispatchEvent(new evLoadFinished(this));
				
			}
			
		}
		
		private function onMetaData(metadata:Object):void{
			
			for(var x:String in metadata){
				//zlog(x + " -- " + metadata[x]);
			}
			
			if(!autoplay){ pause(); }
			
			duration = metadata.duration;
			dispatchEvent(new evOnMetaData(this,metadata));
			
		}
		
		private function onPlayStatus(e:NetStatusEvent):void{
			//zlog("NetStatusEvent > " + e);
		}
		
	}

}
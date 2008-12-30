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

package tv.zarate.player.audio{
	
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import flash.media.Sound;
	//import flash.media.SoundTransform;
	
	import tv.zarate.player.iPlayer;
	
	import tv.zarate.player.events.evLoadProgress;
	import tv.zarate.player.events.evLoadFinished;
	
	public class ZAudio extends Sprite implements iPlayer{
		
		private var mainSound:Sound;
		private var soundPath:String;
		
		private var duration:Number;
		private var loadingTimer:Timer;
		private var _playing:Boolean;
		private var autoplay:Boolean;
		private var _bytesLoaded:Number;
		private var _bytesTotal:Number;
		
		public function ZAudio(){
			
			super();
			
		}
		
		public function load(url:String,autoplay:Boolean=false):void{
			
			soundPath = url;
			this.autoplay = autoplay;
			_playing = autoplay;
			
			loadSound();
			
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
			
			//stream_ns.resume();
			_playing = true;
			
		}
		
		public function pause():void{
			
			//stream_ns.pause();
			_playing = false;
			
		}
		
		public function reset():void{
			setTime(0);
		}
		
		public function getDuration():Number{
			return duration;
		}
		
		public function setTime(pos:Number):void{
			//stream_ns.seek(pos);
		}
		
		public function getTime():Number{
			return 0//stream_ns.time;
		}
		
		public function setVolume(volume:Number):void{
			
			//videoSound.volume = volume;
			//if(stream_ns != null){ stream_ns.soundTransform = videoSound; } // people might call setVolume before load
			
		}
		
		public function getVolume():Number{
			return 0//videoSound.volume;
		}
		
		public function get bytesLoaded():Number{
			return _bytesLoaded;
		}
		
		public function get bytesTotal():Number{
			return _bytesTotal;
		}
		
		// ******************* PRIVATE METHODS *******************
		
		private function loadSound():void{
			
			loadingTimer = new Timer(100);
			loadingTimer.addEventListener(TimerEvent.TIMER,checkBytesLoaded);
			loadingTimer.start();
			
			mainSound = new Sound();
			mainSound.addEventListener(Event.COMPLETE,loadComplete);
			mainSound.addEventListener(IOErrorEvent.IO_ERROR,loadError);
			mainSound.load(new URLRequest(soundPath));
			
		}
		
		private function checkBytesLoaded(e:TimerEvent):void{
			
			_bytesLoaded = mainSound.bytesLoaded;
			_bytesTotal = mainSound.bytesTotal;
			
			dispatchEvent(new evLoadProgress(this,_bytesLoaded,_bytesTotal,(_bytesLoaded/_bytesTotal)));
			
			if(_bytesLoaded >= _bytesTotal){
				
				loadingTimer.stop();
				dispatchEvent(new evLoadFinished(this));
				
			}
			
		}
		
		private function loadComplete(e:Event):void{
			
			zlog("loadComplete > " + e + " -- " + autoplay);
			
			if(autoplay){
				
				mainSound.play();
				
			}
			
		}
		
		private function loadError(e:IOErrorEvent):void{
			
			zlog("loadError > " + e);
			
		}
		
		/*
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
		*/
	}

}
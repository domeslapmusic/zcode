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
	
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	
	import tv.zarate.player.iPlayer;
	import tv.zarate.player.events.evLoadProgress;
	import tv.zarate.player.events.evLoadFinished;
	
	public class ZAudio extends EventDispatcher implements iPlayer{
		
		private var soundPath:String;
		private var mainSound:Sound;
		private var audioTransform:SoundTransform;
		private var audioChannel:SoundChannel;
		
		private var loadingTimer:Timer;
		private var _playing:Boolean;
		private var autoplay:Boolean;
		private var _bytesLoaded:Number;
		private var _bytesTotal:Number;
		private var lastPosition:Number = 0;
		
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
			
			audioChannel = mainSound.play(lastPosition);
			audioChannel.soundTransform = audioTransform;
			
			_playing = true;
			
		}
		
		public function pause():void{
			
			lastPosition = audioChannel.position;
			audioChannel.stop();
			
			_playing = false;
			
		}
		
		public function reset():void{
			setTime(0);
		}
		
		public function getDuration():Number{
			return mainSound.length;
		}
		
		public function setTime(pos:Number):void{
			
			if(pos < 0){ pos = 0; }
			if(pos > getDuration()){ pos = getDuration(); }
			
			lastPosition = pos;
			play();
			
			// The if below is ugly but the only way to move the position
			// of the sound is calling sound.play() method.
			
			if(!playing){ pause(); }
			
		}
		
		public function getTime():Number{
			return audioChannel.position;
		}
		
		public function setVolume(volume:Number):void{
			
			if(volume < 0){ volume = 0; }
			if(volume > 1){ volume = 1; }
			
			audioTransform.volume = volume;
			audioChannel.soundTransform = audioTransform;
			
		}
		
		public function getVolume():Number{
			return audioTransform.volume;
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
			
			audioTransform = new SoundTransform();
			
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
			if(autoplay){ play(); }
		}
		
		private function loadError(e:IOErrorEvent):void{
			zlog("loadError > " + e);
		}
		
	}

}
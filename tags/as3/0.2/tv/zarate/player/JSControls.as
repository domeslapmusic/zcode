/*
*
* MIT License
* 
* Copyright (c) 2009, Juan Delgado - Zarate
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

package tv.zarate.player{
	
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	
	import tv.zarate.player.iPlayer;
	import tv.zarate.player.video.ZVideo;
	import tv.zarate.player.video.evOnMetaData;
	import tv.zarate.player.events.evLoadProgress;
	import tv.zarate.player.events.evLoadFinished;
	import tv.zarate.player.events.evPlayerFinished;
	
	public class JSControls{
		
		protected var player:iPlayer;
		
		protected var progressJSCallback:String = "";
		protected var finishJSCallback:String = "";
		protected var playerFinishedJSCallback:String = "";
		protected var metadataJSCallback:String = "";
		protected var ioErrorJSCallback:String = "";
		
		public function JSControls(player:ZVideo){
			
			this.player = player;
			
			if(isVideo()){
				
				if(player.stage == null){
					
					player.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
					
				} else {
					
					onResize();
					
				}
				
			}
			
			listenToJS();
			
		}
		
		// ******************* PRIVATE METHODS *******************
		
		protected function listenToJS():void{
			
			Security.allowDomain("*");
			
			ExternalInterface.addCallback("isPlaying",isPlayingCallback);
			ExternalInterface.addCallback("load",loadCallback);
			ExternalInterface.addCallback("toggle",toggleCallback);
			ExternalInterface.addCallback("play",playCallback);
			ExternalInterface.addCallback("pause",pauseCallback);
			ExternalInterface.addCallback("reset",resetCallback);
			ExternalInterface.addCallback("getDuration",getDurationCallback);
			ExternalInterface.addCallback("setTime",setTimeCallback);
			ExternalInterface.addCallback("getTime",getTimeCallback);
			ExternalInterface.addCallback("setVolume",setVolumeCallback);
			ExternalInterface.addCallback("setVolume",getVolumeCallback);
			ExternalInterface.addCallback("getTimePercentage",getTimePercentageCallback);
			ExternalInterface.addCallback("addEventListener",addListenerCallback);
			
		}
		
		protected function playCallback():void{
			player.play();
		}
		
		protected function pauseCallback():void{
			player.pause();
		}
		
		protected function toggleCallback():Boolean{
			
			player.toggle();
			return player.isPlaying();
			
		}
		
		protected function resetCallback():void{
			player.reset();
		}
		
		protected function isPlayingCallback():Boolean{
			return player.isPlaying();
		}
		
		protected function getDurationCallback():Number{
			return player.getDuration();
		}
		
		protected function setTimeCallback(position:Number):void{
			player.setTime(position);
		}
		
		protected function getTimeCallback():Number{
			return player.getTime();
		}
		
		protected function setVolumeCallback(volume:Number):Number{
			return player.setVolume(volume);
		}
		
		protected function getVolumeCallback():Number{
			return player.getVolume();
		}
		
		protected function getTimePercentageCallback():Number{
			return player.getTimePercentage();
		}
		
		protected function loadCallback(url:String,autoplay:Boolean=false,jsCallback:String=null):void{
			player.load(url,autoplay);
		}
		
		protected function addListenerCallback(eventType:String,callback:String):void{
			
			switch(eventType){
				
				case evLoadProgress.LOAD_PROGRESS:
					
					progressJSCallback = callback;
					player.addEventListener(evLoadProgress.LOAD_PROGRESS,loadProgress);
					break;
				
				case evLoadFinished.LOAD_FINISHED:
					
					finishJSCallback = callback;
					player.addEventListener(evLoadFinished.LOAD_FINISHED,loadFinished);
					break;
				
				case evPlayerFinished.PLAYER_FINISHED:
					
					playerFinishedJSCallback = callback;
					player.addEventListener(evPlayerFinished.PLAYER_FINISHED,playerFinished);
					break;
				
				case evOnMetaData.META_DATA:
					
					metadataJSCallback = callback;
					player.addEventListener(evOnMetaData.META_DATA,metaData);
					break;
				
				case IOErrorEvent.IO_ERROR:
					
					ioErrorJSCallback = callback;
					player.addEventListener(IOErrorEvent.IO_ERROR,ioError);
					break;
				
			}
			
		}
		
		protected function loadProgress(e:evLoadProgress):void{
			ExternalInterface.call(progressJSCallback,e.bytesLoaded,e.bytesTotal);
		}
		
		protected function loadFinished(e:evLoadFinished):void{
			ExternalInterface.call(finishJSCallback);
		}
		
		protected function playerFinished(e:evPlayerFinished):void{
			ExternalInterface.call(playerFinishedJSCallback);
		}
		
		protected function metaData(e:evOnMetaData):void{
			
			var o : Object = new Object();
			
			for(var data:String in e.metadata){
				
				var propName : String = escape(data);
				var propVal : String  = escape(e.metadata[data]);
				
				o[propName] = propVal;
				
			}
			
			onResize();
			ExternalInterface.call(metadataJSCallback,o);
			
		}
		
		protected function ioError(e:IOErrorEvent):void{
			ExternalInterface.call(ioErrorJSCallback);
		}
		
		protected function addedToStage(e:Event):void{
			
			ZVideo(player).stage.addEventListener(Event.RESIZE,onResize);
			onResize();
			
		}
		
		protected function onResize(e:Event=null):void{
			
			ZVideo(player).width = ZVideo(player).stage.stageWidth;
			ZVideo(player).height = ZVideo(player).stage.stageHeight;
			
		}
		
		protected function isVideo():Boolean{
			return (player is ZVideo);
		}
		
	}
	
}
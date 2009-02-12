/* You can compile this using Flex SDK only.
* 
* mxmlc ZVideoDemo.as -source-path ../../../../ -output bin/zvideo.swf -target-player 9 -use-network=false
* 
*/ 

package tv.zarate.demo.players{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import tv.zarate.application.Model;
	
	import tv.zarate.components.ZButton;
	import tv.zarate.utils.MovieClipUtils;
	import tv.zarate.utils.TextFieldUtils;
	import tv.zarate.utils.Time;
	
	import tv.zarate.player.video.ZVideo;
	import tv.zarate.player.video.evOnMetaData;
	import tv.zarate.player.events.evLoadProgress;
	import tv.zarate.player.events.evLoadFinished;
	import tv.zarate.player.events.evPlayerFinished;
	
	public class ZVideoDemo extends Model{
		
		private var player:ZVideo;
		
		private var statusField:TextField;
		private var timeField:TextField;
		private var videoBar:Sprite;
		private var margin:int = 10;
		
		public function ZVideoDemo(){
			
			super();
			
		}
		
		override protected function frameworkReady():void{
			
			// Field to display what's going on
			statusField = TextFieldUtils.CreateMultiline(_view.getAppWidth() - margin * 2,190);
			statusField.border = true;
			
			MovieClipUtils.CentreFromWidth(_view.getAppWidth(),statusField);
			statusField.y = _view.getAppHeight() - statusField.height - margin;
			
			addChild(statusField);
			
			// Get flv path from config xml
			var flvPath:String = _conf.dataXML.video;
			
			// Let's go for the player now
			player = new ZVideo();
			player.setVolume(0);
			
			// Adding listeners to all possible events, pick up only the ones you need
			player.addEventListener(evLoadProgress.LOAD_PROGRESS,loadProgress);
			player.addEventListener(evLoadFinished.LOAD_FINISHED,loadFinished);
			player.addEventListener(evPlayerFinished.PLAYER_FINISHED,playerFinished);
			player.addEventListener(evOnMetaData.META_DATA,metaData);
			
			// Ready to load, autoplay set to true
			player.load(flvPath,true);
			
		}
		
		private function metaData(e:evOnMetaData):void{
			
			for(var data:String in e.metadata){
				
				var status:String = "metaData " + data + " --- " + e.metadata[data];
				updateStatus(status);
				
			}
			
			// Let's do some layout
			player.width = 320;
			player.height = 240;
			
			MovieClipUtils.CentreFromWidth(_view.getAppWidth(),player);
			player.y = margin;
			
			player.buttonMode = true;
			player.addEventListener(MouseEvent.CLICK,toggleVideo);
			
			addChild(player);
			
			
			// Control buttons
			var playButton:ZButton = new ZButton("Play");
			playButton.x = player.x;
			playButton.y = player.y + player.height + margin;
			
			playButton.addEventListener(MouseEvent.CLICK,playPressed);
			
			addChild(playButton);
			
			var pauseButton:ZButton = new ZButton("Pause");
			pauseButton.x = playButton.x + playButton.width + margin;
			pauseButton.y = playButton.y;
			
			pauseButton.addEventListener(MouseEvent.CLICK,pausePressed);
			
			addChild(pauseButton);
			
			
			// Time
			timeField = TextFieldUtils.CreateField();
			timeField.text = "00:00";
			timeField.border = true;
			
			timeField.x = player.x + player.width - timeField.width;
			timeField.y = player.y + player.height + margin;
			
			addChild(timeField);
			
			var barX:int = pauseButton.x + pauseButton.width + margin;
			var barWidth:int = player.width - pauseButton.width - playButton.width - timeField.width - margin * 3;
			
			// A nice bar to display video position
			videoBar = MovieClipUtils.DrawRect(this,barWidth,10);
			videoBar.width = 0;
			
			videoBar.x = barX;
			videoBar.y = player.y + player.height + margin;
			
			addChild(videoBar);
			
			// Let's monitor video status
			addEventListener(Event.ENTER_FRAME,checkVideoStatus);
			
		}
		
		private function playPressed(e:MouseEvent):void{
			
			if(!player.isPlaying()){
				
				player.play();
				
			}
			
		}
		
		private function pausePressed(e:MouseEvent):void{
			
			if(player.isPlaying()){
				
				player.pause();
				
			}
			
		}
		
		private function toggleVideo(e:MouseEvent):void{
			
			if(player.isPlaying()){
				
				player.pause();
				
			} else {
				
				player.play();
				
			}
			
		}
		
		private function checkVideoStatus(e:Event):void{
			
			videoBar.scaleX = player.getTimePercentage();
			
			var t:Time = Time.getTimeFromSeconds(player.getTime());
			timeField.text = Time.getFriendlyStringFromTime(t);
			
		}
		
		private function loadProgress(e:evLoadProgress):void{
			
			var percentage:Number = Math.round((e.bytesLoaded/e.bytesTotal)*100);
			
			var status:String = "loadProgress > " + percentage + "%";
			updateStatus(status);
			
		}
		
		private function loadFinished(e:evLoadFinished):void{
			
			var status:String = "loadFinished";
			updateStatus(status);
			
		}
		
		private function playerFinished(e:evPlayerFinished):void{
			
			var status:String = "playerFinished";
			updateStatus(status);
			
		}
		
		private function updateStatus(s:String):void{
			
			statusField.appendText(s + "\n");
			statusField.scrollV = statusField.maxScrollV;
			
		}
		
	}

}
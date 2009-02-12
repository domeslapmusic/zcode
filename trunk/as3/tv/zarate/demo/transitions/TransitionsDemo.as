package tv.zarate.demo.transitions{
	
	import mx.core.BitmapAsset;
	
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import flash.net.URLRequest;
	
	import tv.zarate.application.Model;
	import tv.zarate.utils.MovieClipUtils;
	import tv.zarate.transitions.Transition3D;
	import tv.zarate.components.ZButton;
	
	// You can compile this using Flex SDK only.
	// You need PPV GreatWhite, GTween beta 5 and Penner's equations
	// Set your own paths and try something like this to compile:
	// 
	// mxmlc TransitionsDemo.as -source-path ../../../../ -source-path C:\projects\GTween -source-path C:\projects\PPV\src  -output bin/transitions.swf -target-player 9 -use-network=false
	
	public class TransitionsDemo extends Model{
		
		private var loader:Loader;
		private var ready:Boolean = true;
		
		public function TransitionsDemo(){
			
			super();
			
		}
		
		override protected function frameworkReady():void{
			
			loadImage();
			
		}
		
		private function loadImage():void{
			
			// Example loading an image, but should work with any DisplayObject
			
			// Get image path from config xml
			var imagePath:String = _conf.dataXML.image;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,imageLoaded);
			loader.load(new URLRequest(imagePath));
			
		}
		
		private function imageLoaded(e:Event):void{
			
			// Some layout and buttons
			
			MovieClipUtils.CentreFromWidth(stage.stageWidth,loader);
			loader.y = 10;
			
			addChild(loader);
			
			var buttons:Sprite = new Sprite();
			
			var goButton:ZButton = new ZButton("Go for it");
			goButton.addEventListener(MouseEvent.CLICK,goForIt);
			
			var resetButton:ZButton = new ZButton("Reset");
			resetButton.addEventListener(MouseEvent.CLICK,resetPlease);
			resetButton.x = goButton.x + goButton.width + 10;
			
			buttons.addChild(goButton);
			buttons.addChild(resetButton);
			
			MovieClipUtils.CentreFromWidth(stage.stageWidth,buttons);
			buttons.y = loader.y + loader.height + 50;
			
			addChild(buttons);
			
		}
		
		private function goForIt(e:MouseEvent):void{
			
			if(ready){
				
				ready = false;
				
				// This is where the good stuff happens
				Transition3D.Wadus(loader,10,10);
				
			} else {
				
				resetPlease();
				
			}
			
		}
		
		private function resetPlease(e:MouseEvent=null):void{
			
			ready = true;
			
			MovieClipUtils.RemoveChildren(this);
			loadImage();
			
		}
		
	}

}
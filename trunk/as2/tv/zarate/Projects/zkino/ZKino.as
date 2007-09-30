import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.effects.Image;

import tv.zarate.Application.SimpleModel;
import tv.zarate.Projects.zkino.Frame;

class tv.zarate.Projects.zkino.ZKino extends SimpleModel{
	
	private var frames:Array;
	private var currentFrame:Number = 0;
	private var currentInterval:Number = 0;
	private var playing:Boolean = true;
	private var totalFrames:Number = 0;
	private var currentImage_mc:MovieClip;
	private var nextImage_mc:MovieClip;
	
	public function ZKino(m:MovieClip){
		
		super();
		
	}
	
	public static function main(m:MovieClip):Void{
		
		var instance:ZKino = new ZKino();
		instance.config(m);
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function applicationReady():Void{
		
		frames = new Array();
		
		totalFrames = confObj.dataXML.firstChild.childNodes.length;
		
		for(var x:Number=0;x<totalFrames;x++){
			
			var node:XMLNode = confObj.dataXML.firstChild.childNodes[x];			
			var f:Frame = new Frame(node.attributes["path"],Number(node.attributes["delay"]));
			
			frames.push(f);
			
		}
		
		showFrame();
		
	}
	
	private function showFrame():Void{
		
		var frame:Frame = frames[currentFrame];
		
		var depth:Number = timeLine_mc.getNextHighestDepth();
		nextImage_mc = timeLine_mc.createEmptyMovieClip("image_" + depth,depth);
		nextImage_mc._alpha = 30;
		
		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(frame.path,nextImage_mc);
		
	}
	
	private function onLoadInit():Void{
		
		currentImage_mc.removeMovieClip();
		
		currentImage_mc = nextImage_mc;
		currentImage_mc.onPress = Delegate.create(this,toggleKino);
		
		Image.Fade(currentImage_mc,100);
		
		var frame:Frame = frames[currentFrame];
		
		currentInterval = setInterval(this,"changeFrame",frame.delay);
		
	}
	
	private function changeFrame():Void{
		
		clearInterval(currentInterval);
		
		currentFrame++;
		
		if(currentFrame >= frames.length){ currentFrame = 0; }
		
		showFrame();
		
	}
	
	private function toggleKino():Void{
		
		if(playing){
			
			clearInterval(currentInterval);
			
		} else {
			
			showFrame();
			
		}
		
		playing = !playing;
		
	}
	
}
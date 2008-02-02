import tv.zarate.Application.Model;
import tv.zarate.Application.Config;

class tv.zarate.Application.View{

	private var model:Model;
	private var conf:Config;
	
	private var view_mc:MovieClip;

	private var width:Number = 0;
	private var height:Number = 0;

	private var initialized:Boolean = false;
	
	public function View(){}

	public function config(_view_mc:MovieClip,isRoot:Boolean,_model:Model,_conf:Config):Void{
		
		if(isRoot){ 
			
			Stage.addListener(this); 
			Stage.scaleMode = "noScale";
			Stage.align = "TL";
			
		}
		
		view_mc = _view_mc;
		model = _model;
		conf = _conf;
		
		initialLayout();
		
	}

	public function enable():Void{
		
		view_mc.enabled = view_mc.tabChildren = true;
		
	}
	
	public function disable():Void{
		
		view_mc.enabled = view_mc.tabChildren = false;
		
	}
	
	public function setSize(w:Number,h:Number):Void{
		
		if(w != null){ width = w; }
		if(h != null){ height = h; }
		
		if(!initialized){
			
			initialized = true;
			
		} else {
			
			layout();
			
		}
		
	}

	// ******************** PRIVATE METHODS ********************

	private function onResize():Void{
		setSize(Stage.width,Stage.height);
	}

	// This method is called just once per instantiation
	private function initialLayout():Void{}

	// This method is called everytime the setSize method is called
	private function layout():Void{}

}
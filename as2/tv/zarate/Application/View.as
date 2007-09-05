class tv.zarate.Application.View{

	private var view_mc:MovieClip;

	private var width:Number = 0;
	private var height:Number = 0;

	public function View(){
		
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		
	}

	public function config(_view_mc:MovieClip,isRoot:Boolean):Void{
		
		if(isRoot){ Stage.addListener(this); }
		
		view_mc = _view_mc;
		initialLayout();
		
	}

	public function setSize(w:Number,h:Number,updateLayout:Boolean):Void{
		
		if(w != null){ width = w; }
		if(h != null){ height = h; }
		
		if(updateLayout || updateLayout == null){ layout(); }
		
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
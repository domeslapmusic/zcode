import tv.zarate.Utils.MovieclipUtils;

class tv.zarate.components.Common{

	private var base_mc:MovieClip;
	private var back_mc:MovieClip;

	private var width:Number = 0;
	private var height:Number = 0;

	private var BACKGROUND_DEPTH:Number = 30;

	public function Common(_base_mc:MovieClip){

		base_mc = _base_mc;
		doInitialLayout();

	}

	public function setSize(w:Number,h:Number):Void{

		if(w != null){ width = w;}
		if(h != null){ height = h;}

		layout();

	}

	public function enable():Void{

		base_mc.enabled = true;
		base_mc.tabChildren = base_mc.tabEnabled = true;

	}

	public function disable():Void{

		base_mc.enabled = false;
		base_mc.tabChildren = base_mc.tabEnabled = false;

	}

	public function remove():Void{

		base_mc.removeMovieClip();

	}

	// ************************ PRIVATE FUNCTIONS ************************

	private function doInitialLayout():Void{

		back_mc = base_mc.createEmptyMovieClip("back_mc",BACKGROUND_DEPTH);
		back_mc._alpha = 0;

	}

	private function layout():Void{

		drawBackground();

	}

	private function drawBackground():Void{

		back_mc.clear();
		MovieclipUtils.DrawSquare(back_mc,0x000000,100,width,height);

	}

}
import tv.zarate.Projects.zplayer.Item;

class tv.zarate.Projects.zplayer.Player{

	private var item:Item;

	private var base_mc:MovieClip;
	private var width:Number = 0;
	private var height:Number = 0;
	private var margin:Number = 10;
	private var finishCallback:Function;

	public function Player(_item:Item,_base_mc:MovieClip,_finishCallback:Function){

		item = _item;
		base_mc = _base_mc;
		finishCallback = _finishCallback;

	}

	public function setSize(w:Number,h:Number):Void{

		if(w != null){ width = w; }
		if(h != null){ height = h; }

	}

	public function remove():Void{

		base_mc.removeMovieClip();

	}

	public function playItem():Void{}

	// **************** PRIVATE METHODS ****************

}
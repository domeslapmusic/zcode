import tv.zarate.Utils.TextfieldUtils;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.Projects.zplayer.zpConfig;
import tv.zarate.Projects.zplayer.zpModel;
import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.Player;
import tv.zarate.Projects.zplayer.zpConstants;
import tv.zarate.Projects.zplayer.PlayerVideo;
import tv.zarate.Projects.zplayer.PlayerImage;
import tv.zarate.Projects.zplayer.ItemsBand;

class tv.zarate.Projects.zplayer.zpView{

	private var config:zpConfig;
	private var model:zpModel;
	private var currentPlayer:Player;
	private var itemsBand:ItemsBand;

	private var base_mc:MovieClip;
	private var title_mc:MovieClip;
	private var player_mc:MovieClip;
	private var background_mc:MovieClip;
	private var items_mc:MovieClip;

	private var width:Number = 0;
	private var height:Number = 0;
	private var margin:Number = 10;
	private var maxWidth:Number = 0;
	private var playerWidth:Number = 0;
	private var playerHeight:Number = 0;
	private var itemsBandHeight:Number = 0;
	private var items:/*Item*/Array;
	private var showItemsBand:Boolean = false;
	private var selectItemCallback:Function;

	private var BACKGROUND_DEPTH:Number = 50;
	private var TITLE_DEPTH:Number = 100;
	private var PLAYER_DEPTH:Number = 200;
	private var ITEMS_DEPTH:Number = 300;

	public function zpView(){

		Stage.addListener(this);

	}

	public function conf(_model:zpModel,_config:zpConfig,_base_mc:MovieClip,_items:/*Item*/Array,_selectItemCallback:Function):Void{

		model = _model;
		config = _config;
		base_mc = _base_mc;
		items = _items;
		selectItemCallback = _selectItemCallback;

		showItemsBand = (items.length > 1);
		itemsBandHeight = (showItemsBand)? 50:0;

	}

	public function start():Void{

		doInitialLayout();
		onResize();

	}

	public function setSize(w:Number,h:Number):Void{

		if(w != null){ width = w; }
		if(h != null){ height = h; }

		maxWidth = width - margin * 2;

		playerWidth = maxWidth;

		itemsBand.setSize(maxWidth,itemsBandHeight);

		layout();

	}

	public function showItem(item:Item,finishCallback:Function):Void{

		if(currentPlayer != null){

			currentPlayer.remove();

		}

		updateTitle(item.title);

		player_mc = base_mc.createEmptyMovieClip("player_mc",PLAYER_DEPTH);
		player_mc._x = margin;
		player_mc._y = title_mc._y + title_mc._height + margin;

		playerHeight = height - player_mc._y - itemsBandHeight - margin * 2;

		switch(item.type){

			case(zpConstants.TYPE_VIDEO):
				currentPlayer = new PlayerVideo(item,player_mc,finishCallback); break;

			case(zpConstants.TYPE_IMAGE):
				currentPlayer = new PlayerImage(item,player_mc,finishCallback); break;

		}

		itemsBand.setCurrentItem(item);

		currentPlayer.setSize(playerWidth,playerHeight);
		currentPlayer.playItem();

	}

	// **************** PRIVATE METHODS ****************

	private function onResize():Void{
		setSize(Stage.width,Stage.height);
	}

	private function doInitialLayout():Void{

		// this method is called just once
		// width and height are NOT ready at this
		// point

		background_mc = base_mc.createEmptyMovieClip("background_mc",BACKGROUND_DEPTH);

		title_mc = base_mc.createEmptyMovieClip("title_mc",TITLE_DEPTH);
		title_mc._x = title_mc._y = margin;

		var field:TextField = TextfieldUtils.createField(title_mc,100,20,"none");
		field.border = true;

		if(showItemsBand){

			showItems();

		}

	}

	private function layout():Void{

		// this method is called everytime
		// the Stage is resized and *at least* once

		title_mc.field._width = maxWidth;

		background_mc.clear();
		MovieclipUtils.DrawSquare(background_mc,0xffff00,100,width,height);

		items_mc._x = margin;
		items_mc._y = height - itemsBandHeight - margin;

	}

	private function showItems():Void{

		items_mc = base_mc.createEmptyMovieClip("items_mc",ITEMS_DEPTH);

		itemsBand = new ItemsBand();
		itemsBand.config(items,items_mc,selectItemCallback);

	}

	private function updateTitle(s:String):Void{
		title_mc.field.text = s;
	}

}
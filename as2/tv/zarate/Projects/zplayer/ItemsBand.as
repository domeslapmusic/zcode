import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.Item;

class tv.zarate.Projects.zplayer.ItemsBand{

	private var base_mc:MovieClip;
	private var items_mc:MovieClip;
	private var description_mc:MovieClip;

	private var items:/*Item*/Array;
	private var itemClips:/*MovieClip*/Array;
	private var currentItem_mc:MovieClip;
	private var width:Number = 0;
	private var height:Number = 0;
	private var selectCallback:Function;

	private var OVER:String = "over";
	private var OUT:String = "out";

	public function ItemsBand(){}

	public function setSize(w:Number,h:Number):Void{

		if(w != null){ width = w; }
		if(h != null){ height = h; }

		layout();

	}

	public function setCurrentItem(i:Item):Void{

		if(currentItem_mc != null){

			currentItem_mc.enabled = true;

		}

		var totalItems:Number = itemClips.length;
		for(var x:Number=0;x<totalItems;x++){

			if(i.order == itemClips[x].order){

				currentItem_mc = itemClips[x];
				currentItem_mc.enabled = false;
				break;

			}

		}

	}

	public function config(_items:/*Item*/Array,_base_mc:MovieClip,_selectCallback:Function):Void{

		items = _items;
		base_mc = _base_mc;
		selectCallback = _selectCallback;

		doInitialLayout();

	}

	// **************** PRIVATE METHODS ****************

	private function doInitialLayout():Void{

		items_mc = base_mc.createEmptyMovieClip("items_mc",100);

	}

	private function layout():Void{

		var nextX:Number = 0;

		var totalItems:Number = items.length;

		itemClips = new Array();

		for(var x:Number=0;x<totalItems;x++){

			var item:Item = items[x];

			var item_mc:MovieClip = items_mc.createEmptyMovieClip("item_"+x,100+x);
			item_mc.order = item.order;

			itemClips.push(item_mc);

			var image_mc:MovieClip = item_mc.createEmptyMovieClip("image_mc",100);
			image_mc.loadMovie(item.thumb)

			item_mc._x = nextX;
			nextX += 50 + 5;

			item_mc.onPress = Delegate.create(this,itemPressed,x,item_mc);
			item_mc.onRollOver = Delegate.create(this,manageItem,OVER,x,item_mc);
			item_mc.onRollOut = Delegate.create(this,manageItem,OUT,x,item_mc);

		}

	}

	private function manageItem(action:String,order:Number,item_mc:MovieClip):Void{

		if(action == OVER){

			var item:Item = items[order];

			description_mc = base_mc.createEmptyMovieClip("description_mc",200);

			var background_mc:MovieClip = description_mc.createEmptyMovieClip("background_mc",100);
			MovieclipUtils.DrawSquare(background_mc,0xff00ff,100,width,60);

			var text_mc:MovieClip = description_mc.createEmptyMovieClip("text_mc",200);

			var field:TextField = TextfieldUtils.createMultilineField(text_mc,width);
			field.border = true;
			field.html = true;
			field.htmlText = item.info;

			description_mc._y -= description_mc._height;

		} else {

			description_mc.removeMovieClip();

		}

	}

	private function itemPressed(order:Number,item_mc:MovieClip):Void{

		if(currentItem_mc != null){

			currentItem_mc.enabled = true;

		}

		manageItem(OUT,order,item_mc);

		currentItem_mc = item_mc;

		var item:Item = items[order];
		selectCallback(item);

	}

}
import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpConstants;
import tv.zarate.Projects.zplayer.zpImage;
import tv.zarate.Projects.zplayer.InfoBand;
import tv.zarate.Projects.zplayer.Thumbnail;

class tv.zarate.Projects.zplayer.ItemsBand{

	private var currentItem:Item;
	
	private var base_mc:MovieClip;
	private var background_mc:MovieClip;
	private var backgroundMask_mc:MovieClip;
	private var items_mc:MovieClip;
	private var description_mc:MovieClip;
	private var pagination_mc:MovieClip;
	private var pages_mc:MovieClip;
	private var prev_mc:MovieClip;
	private var next_mc:MovieClip;
	private var toggleInfo_mc:MovieClip;

	private var items:/*Item*/Array;
	private var width:Number = 0;
	private var height:Number = 0;
	private var itemsMargin:Number = 5;
	private var totalPages:Number = 1;
	private var itemsPerPage:Number = 1;
	private var currentPage:Number = 0;
	private var selectCallback:Function;
	private var updateInfoCallback:Function;
	private var toggleInfoCallback:Function;

	private var OVER:String = "over";
	private var OUT:String = "out";

	public function ItemsBand(){}

	public function setSize(w:Number,h:Number):Void{
		
		if(w != null){ width = w; }
		if(h != null){ height = h; }
		
		layout();
		
	}

	public function setCurrentItem(i:Item):Void{
		
		if(currentItem != null){
			
			enableItem(currentItem,true);
			
		}
		
		currentItem = i;
		
		enableItem(currentItem,false);
		
	}

	public function config(_items:/*Item*/Array,_base_mc:MovieClip,_selectCallback:Function,_updateInfoCallback:Function,_toggleInfoCallback:Function):Void{
		
		items = _items;
		base_mc = _base_mc;
		selectCallback = _selectCallback;
		updateInfoCallback = _updateInfoCallback;
		toggleInfoCallback = _toggleInfoCallback;
		
		doInitialLayout();
		
	}

	// **************** PRIVATE METHODS ****************

	private function doInitialLayout():Void{
		
		background_mc = base_mc.attachMovie("itemsbg","background_mc",50);
		backgroundMask_mc = base_mc.createEmptyMovieClip("backgroundMask_mc",60);
		
		background_mc.setMask(backgroundMask_mc);
		
		pagination_mc = base_mc.createEmptyMovieClip("pagination_mc",200);
		
		prev_mc = pagination_mc.attachMovie("prev","prev_mc",100);
		prev_mc.onPress = Delegate.create(this,updatePage,false);
		
		next_mc = pagination_mc.attachMovie("next","next_mc",200);
		next_mc._x = Math.round(prev_mc._width + 1);
		
		next_mc.onPress = Delegate.create(this,updatePage,true);
		
		pages_mc = base_mc.createEmptyMovieClip("pagination_mc",400);
		var field:TextField = TextfieldUtils.createField(pages_mc);
		field.setNewTextFormat(new TextFormat("Verdana",12,0xffffff,true));
		
		toggleInfo_mc = base_mc.attachMovie("info","toggleInfo_mc",901);
		toggleInfo_mc.onPress = toggleInfoCallback;
		
	}

	private function layout():Void{
		
		background_mc._width = width;
		
		backgroundMask_mc.clear();
		//MovieclipUtils.DrawSquare(backgroundMask_mc,0xff00ff,100,background_mc._width,50);
		MovieclipUtils.DrawRoundedSquare(backgroundMask_mc,0xff0000,100,background_mc._width,background_mc._height,10);
		
		calculatePages();
		createItems();
		
		toggleInfo_mc._x = width - toggleInfo_mc._width - 5;
		toggleInfo_mc._y = pages_mc._y + pages_mc._height + 10;
		
	}

	private function createItems():Void{
		
		var margin:Number = 10;
		var nextX:Number = margin;
		
		var initItem:Number = itemsPerPage * currentPage;
		var endItem:Number = initItem + itemsPerPage;
		
		if(endItem > items.length){ endItem = items.length; }
		
		items_mc.removeMovieClip();
		items_mc = base_mc.createEmptyMovieClip("items_mc",100);
		
		for(var x:Number=initItem;x<endItem;x++){
			
			var item_mc:MovieClip = items_mc.createEmptyMovieClip("item_"+x,100+x);
			
			var item:Item = items[x];
			item.clip = item_mc;
			
			var thumb:Thumbnail = new Thumbnail(item_mc,item);
			
			item_mc._x = nextX;
			item_mc._y = margin;
			nextX += zpConstants.THUMB_SIZE + itemsMargin;
			
			item_mc.onPress = Delegate.create(this,itemPressed,item);
			item_mc.onRollOver = Delegate.create(this,manageItem,OVER,item);
			item_mc.onRollOut = Delegate.create(this,manageItem,OUT,item);
			
			if(item == currentItem){
				
				setCurrentItem(item);
				
			}
			
		}
		
	}
	
	private function manageItem(action:String,item:Item):Void{
		updateInfoCallback((action == OVER),item.info);
	}

	private function itemPressed(item:Item):Void{
		
		setCurrentItem(item);		
		manageItem(OUT,item);
		
		selectCallback(item);
		
	}

	private function updatePage(next:Boolean):Void{
		
		var mod:Number = (next)? 1:-1;
		
		currentPage += mod;
		
		if(currentPage <= 0){
			
			currentPage = 0;
			
			prev_mc.enabled = false;
			next_mc.enabled = true;
			
		}
		
		if(currentPage >= totalPages){
			
			currentPage = totalPages;
			
			prev_mc.enabled = true;
			next_mc.enabled = false;
			
		}
		
		createItems();
		updatePageNumber();
		
	}
	
	private function enableItem(item:Item,enable:Boolean):Void{
		
		if(enable){
			
			item.enable();
			
		} else {
			
			item.disable();
			
		}
		
	}
	
	private function calculatePages():Void{
		
		var total:Number = 0;
		
		itemsPerPage = Math.floor(width / (zpConstants.THUMB_SIZE + itemsMargin));
		
		totalPages = Math.floor(items.length / itemsPerPage);
		
		if(total < 2){
			
			pagination_mc._x = width - pagination_mc._width;
			pagination_mc._y = zpConstants.THUMB_SIZE - pagination_mc._height;
			
		} else {
			
			pagination_mc._visible = false;
			
		}
		
		updatePageNumber();
		
	}

	private function updatePageNumber():Void{
		
		pages_mc.field.text = (currentPage + 1) + "/" + (totalPages + 1);
		pages_mc._x = width - pages_mc._width;
		
	}
	
}
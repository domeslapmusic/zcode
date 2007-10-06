import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpConstants;
import tv.zarate.Projects.zplayer.zpImage;
import tv.zarate.Projects.zplayer.InfoBand;

class tv.zarate.Projects.zplayer.ItemsBand{

	private var currentItem:Item;
	
	private var base_mc:MovieClip;
	private var background_mc:MovieClip;
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
			
			enableItem(currentItem.clip,true);
			
		}
		
		currentItem = i;
		
		enableItem(currentItem.clip,false);
		
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
		
		calculatePages();
		createItems();
		
		toggleInfo_mc._x = width - toggleInfo_mc._width - 5;
		toggleInfo_mc._y = pages_mc._y + pages_mc._height + 10;
		
	}

	private function createItems():Void{
		
		var titleFormat:TextFormat = new TextFormat("Verdana",10,0xffffff,true);
		var margin:Number = 10;
		var nextX:Number = margin;
		
		var initItem:Number = itemsPerPage * currentPage;
		var endItem:Number = initItem + itemsPerPage;
		
		if(endItem > items.length){ endItem = items.length; }
		
		items_mc.removeMovieClip();
		items_mc = base_mc.createEmptyMovieClip("items_mc",100);
		
		for(var x:Number=initItem;x<endItem;x++){
			
			var item:Item = items[x];
			
			var item_mc:MovieClip = items_mc.createEmptyMovieClip("item_"+x,100+x);
			item_mc.order = item.order;
			
			item.clip = item_mc;
			
			var image_mc:MovieClip = item_mc.createEmptyMovieClip("image_mc",100);
			image_mc.loadMovie(item.thumb)
			
			var titleBg_mc:MovieClip = item_mc.createEmptyMovieClip("titleBg_mc",200);
			MovieclipUtils.DrawSquare(titleBg_mc,0x000000,75,zpConstants.THUMB_SIZE,20);
			
			titleBg_mc._y = zpConstants.THUMB_SIZE - titleBg_mc._height;
			
			var itemType_mc:MovieClip = item_mc.createEmptyMovieClip("itemType_mc",300);
			
			var field:TextField = TextfieldUtils.createField(itemType_mc);
			field.text = (item.type == zpConstants.TYPE_VIDEO)? "VIDEO" : ((zpImage(item).sound != undefined)? "SONIDO":"FOTO");
			field.setTextFormat(titleFormat);
			
			MovieclipUtils.CentreClips(titleBg_mc,itemType_mc);
			itemType_mc._y += titleBg_mc._y;
			
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
	
	private function enableItem(item_mc:MovieClip,enable:Boolean):Void{
		
		item_mc.enabled = enable;
		item_mc._alpha = (enable)? 100:40;
		
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
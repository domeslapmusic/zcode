/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

import tv.zarate.utils.Delegate;
import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.TextfieldUtils;

import tv.zarate.effects.Image;

import tv.zarate.projects.zplayer.Item;
import tv.zarate.projects.zplayer.zpConstants;
import tv.zarate.projects.zplayer.zpImage;
import tv.zarate.projects.zplayer.InfoBand;
import tv.zarate.projects.zplayer.Thumbnail;

class tv.zarate.projects.zplayer.ItemsBand{

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
			
			var thumb:Thumbnail = new Thumbnail(item);
			
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
		
		if(action == OVER){
			
			var triangleSize:Number = 15;
			
			description_mc = base_mc.createEmptyMovieClip("description_mc",1200);
			
			var background_mc:MovieClip = description_mc.createEmptyMovieClip("background_mc",100);
			MovieclipUtils.DrawRoundedSquare(background_mc,0x4f7ec4,100,200,100,10,1,0x003366);
			
			var triangle_mc:MovieClip = description_mc.createEmptyMovieClip("triangle_mc",200);
			
			triangle_mc.beginFill(0x4f7ec4);
			triangle_mc.moveTo(0,0);
			triangle_mc.lineTo(triangleSize/2,triangleSize);
			triangle_mc.lineTo(triangleSize,0);			
			triangle_mc.endFill();
			
			triangle_mc._x = (item.clip._width-triangle_mc._width)/2;
			triangle_mc._y = background_mc._height - 2;
			
			MovieclipUtils.MakeDropShadow(description_mc);
			
			description_mc._x = item.clip._x;
			
			if(description_mc._x + description_mc._width > width){ 
				
				triangle_mc._x += 80;
				description_mc._x = width - description_mc._width - 10;
				
			}
			
			description_mc._y -= description_mc._height - triangleSize;
			
			description_mc._alpha = 0;
			description_mc._xscale = 0;
			description_mc._yscale = 0;
			
			Image.ChangeProperty(description_mc,"_xscale",100,null,2);
			Image.ChangeProperty(description_mc,"_yscale",100,null,2);
			Image.ChangeProperty(description_mc,"_alpha",100,Delegate.create(this,animationReady,item),2);
			
		} else {
			
			description_mc.removeMovieClip();
			
		}
		
	}

	private function animationReady(item:Item):Void{
		
		var margin:Number = 5;
		
		var css:TextField.StyleSheet = new TextField.StyleSheet();
		css.setStyle("p",{fontFamily:"Verdana",fontSize:"10",color:"#ffffff"});
		
		var text_mc:MovieClip = description_mc.createEmptyMovieClip("text_mc",400);
		text_mc._x = text_mc._y = margin;
		
		var field:TextField = TextfieldUtils.createField(text_mc,description_mc.background_mc._width-margin*2,description_mc.background_mc._height-margin*2,"none",true);
		field.styleSheet = css;
		field.html = true;
		field.htmlText = "<p>" + item.info + "</p>";
		
	}
	
	private function itemPressed(item:Item):Void{
		
		setCurrentItem(item);		
		manageItem(OUT,item);
		
		selectCallback(item);
		
	}

	private function updatePage(next:Boolean):Void{
		
		var mod:Number = (next)? 1:-1;
		
		currentPage += mod;
		
		checkPagButtons();
		createItems();
		updatePageNumber();
		
	}
	
	private function checkPagButtons():Void{
		
		if(currentPage <= 0){
			
			currentPage = 0;
			
			prev_mc.enabled = false;
			next_mc.enabled = true;
			
		}
		
		if((currentPage+1) >= totalPages){
			
			prev_mc.enabled = true;
			next_mc.enabled = false;
			
		}
		
	}
	
	private function enableItem(item:Item,enable:Boolean):Void{
		
		if(enable){
			
			item.enable();
			
		} else {
			
			item.disable();
			
		}
		
	}
	
	private function calculatePages():Void{
		
		itemsPerPage = Math.floor(width / (zpConstants.THUMB_SIZE + itemsMargin));
		totalPages = Math.ceil(items.length / itemsPerPage);
		
		if(totalPages > 1){
			
			pagination_mc._x = width - pagination_mc._width;
			pagination_mc._y = zpConstants.THUMB_SIZE - pagination_mc._height;
			
		} else {
			
			pagination_mc._visible = false;
			pages_mc._visible = false;
			
		}
		
		updatePageNumber();
		checkPagButtons();
		
	}

	private function updatePageNumber():Void{
		
		pages_mc.field.text = (currentPage+1) + "/" + totalPages; // pages are 0 based, so we add one just to show to the user
		pages_mc._x = width - pages_mc._width;
		
	}
	
}
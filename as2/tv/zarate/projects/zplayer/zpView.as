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

import tv.zarate.utils.TextfieldUtils;
import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.Delegate;

import tv.zarate.application.View;

import tv.zarate.projects.zplayer.zpModel;
import tv.zarate.projects.zplayer.zpConstants;
import tv.zarate.projects.zplayer.Item;
import tv.zarate.projects.zplayer.Player;
import tv.zarate.projects.zplayer.PlayerVideo;
import tv.zarate.projects.zplayer.PlayerImage;
import tv.zarate.projects.zplayer.ItemsBand;
import tv.zarate.projects.zplayer.InfoBand;
import tv.zarate.projects.zplayer.zpImage;

class tv.zarate.projects.zplayer.zpView extends View{
	
	private var model:zpModel;
	private var currentPlayer:Player;
	private var itemsBand:ItemsBand;
	private var infoBand:InfoBand;

	private var view_mc:MovieClip;
	private var title_mc:MovieClip;
	private var player_mc:MovieClip;
	private var background_mc:MovieClip;
	private var items_mc:MovieClip;

	private var margin:Number = 1;
	private var titleMargin:Number = 10;
	private var maxWidth:Number = 0;
	private var playerWidth:Number = 0;
	private var playerHeight:Number = 0;
	private var itemsBandHeight:Number = 0;
	private var showItemsBand:Boolean = false;
	private var selectItemCallback:Function;

	private var BACKGROUND_DEPTH:Number = 50;
	private var TITLE_DEPTH:Number = 100;
	private var PLAYER_DEPTH:Number = 200;
	private var INFO_DEPTH:Number = 300;
	private var ITEMS_DEPTH:Number = 400;

	public function zpView(){
		
		super();
		
	}

	public function zpConf(_selectItemCallback:Function):Void{
		
		selectItemCallback = _selectItemCallback;
		
		showItemsBand = (model.items.length > 1);
		itemsBandHeight = (showItemsBand)? 110:0;
		
		if(showItemsBand){
			
			showItems();
			
		}
		
		layout();
		
	}
	
	public function showItem(item:Item,finishCallback:Function):Void{
		
		if(currentPlayer != null){
			
			currentPlayer.remove();
			infoBand.remove();
			
		}
		
		updateTitle(item.title);
		
		player_mc = view_mc.createEmptyMovieClip("player_mc",PLAYER_DEPTH);
		player_mc._x = margin;
		player_mc._y = title_mc._y + title_mc._height + margin;
		
		playerHeight = height - player_mc._y - itemsBandHeight - margin;
		
		switch(item.type){
			
			case(zpConstants.TYPE_VIDEO):
				currentPlayer = new PlayerVideo(item,player_mc,finishCallback); break;
				
			case(zpConstants.TYPE_IMAGE):
				currentPlayer = new PlayerImage(item,player_mc,finishCallback); break;
			
		}
		
		itemsBand.setCurrentItem(item);
		
		currentPlayer.setSize(playerWidth,playerHeight);
		currentPlayer.playItem();
		
		if(item.info != ""){
			
			var info_mc:MovieClip = view_mc.createEmptyMovieClip("info_mc",INFO_DEPTH);
			infoBand = new InfoBand(info_mc,width,item.info);
			
			info_mc._y = player_mc._y + player_mc._height - info_mc._height;
			
			if((item.type == zpConstants.TYPE_IMAGE && zpImage(item).sound != undefined) || item.type == zpConstants.TYPE_VIDEO){ info_mc._y -= zpConstants.LOAD_BAR_HEIGHT; }
			
		}
		
	}

	// **************** PRIVATE METHODS ****************

	private function initialLayout():Void{
		
		// this method is called just once
		// width and height are NOT ready at this
		// point
		
		background_mc = view_mc.createEmptyMovieClip("background_mc",BACKGROUND_DEPTH);
		items_mc = view_mc.createEmptyMovieClip("items_mc",ITEMS_DEPTH);
		
		title_mc = view_mc.createEmptyMovieClip("title_mc",TITLE_DEPTH);
		title_mc._x = titleMargin;
		title_mc._y = 5;
		
		var titleBorder_mc:MovieClip = title_mc.createEmptyMovieClip("titleBorder_mc",200);
		
		var field:TextField = TextfieldUtils.createField(title_mc,100,20,"none");
		field.setNewTextFormat(new TextFormat("Verdana",12,0xffffff));
		
	}

	private function layout():Void{
		
		// this method is called everytime
		// the Stage is resized and *at least* once
		
		maxWidth = width - margin * 2;
		playerWidth = maxWidth;
		
		title_mc.field._width = width - titleMargin * 2;
		
		title_mc.titleBorder_mc._x = -titleMargin;
		title_mc.titleBorder_mc._y = title_mc._height + 5;
		MovieclipUtils.DrawSquare(title_mc.titleBorder_mc,0xffffff,100,width,1);
		
		background_mc.clear();
		
		MovieclipUtils.DrawRoundedSquare(background_mc,0x4f7ec4,100,width,height,10);
		
		items_mc._x = margin;
		items_mc._y = height - itemsBandHeight - margin;
		
		itemsBand.setSize(maxWidth,itemsBandHeight);
		
	}

	private function showItems():Void{
		
		var updateInfoCallback:Function = Delegate.create(this,updateInfo);
		var toggleInfoCallback:Function = Delegate.create(this,toggleInfo);
		
		itemsBand = new ItemsBand();
		itemsBand.config(model.items,items_mc,selectItemCallback,updateInfoCallback,toggleInfoCallback);
		
	}

	private function toggleInfo():Void{
		infoBand.toggleVisibility();
	}
	
	private function updateInfo(over:Boolean,txt:String):Void{
		
		if(over){
			
			infoBand.updateText(txt);
			
		} else {
			
			infoBand.resetText();
			
		}
		
	}
	
	private function updateTitle(s:String):Void{
		title_mc.field.text = s;
	}

}
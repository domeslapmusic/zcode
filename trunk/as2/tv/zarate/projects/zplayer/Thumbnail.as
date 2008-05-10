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

import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.TextfieldUtils;

import tv.zarate.projects.zplayer.zpConstants;
import tv.zarate.projects.zplayer.zpImage;
import tv.zarate.projects.zplayer.Item;
import tv.zarate.projects.zplayer.ImagePreloader;

class tv.zarate.projects.zplayer.Thumbnail{

	private var imageLoader:ImagePreloader;
	
	private var item_mc:MovieClip;
	private var itemType_mc:MovieClip;
	private var border_mc:MovieClip;

	public function Thumbnail(item:Item){
		
		var borderSize:Number = 1;
		
		item.thumbnail = this;
		
		var titleFormat:TextFormat = new TextFormat("Verdana",10,0xffffff,true);
		
		item_mc = item.clip;
		
		var imageLoader_mc:MovieClip = item_mc.createEmptyMovieClip("imageLoader_mc",1200);
		imageLoader = new ImagePreloader(imageLoader_mc,zpConstants.THUMB_SIZE,false);
		
		border_mc = item_mc.createEmptyMovieClip("border_mc",50);
		border_mc._x = border_mc._y = -borderSize;
		
		MovieclipUtils.DrawSquare(border_mc,0xffffff,100,zpConstants.THUMB_SIZE + borderSize * 2,zpConstants.THUMB_SIZE + borderSize * 2);
		
		border_mc._visible = false;
		
		var image_mc:MovieClip = item_mc.createEmptyMovieClip("image_mc",100);
		
		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(item.thumb,image_mc);
		
		itemType_mc = item_mc.createEmptyMovieClip("itemType_mc",300);
		itemType_mc._visible = false;
		
		var titleBg_mc:MovieClip = itemType_mc.createEmptyMovieClip("titleBg_mc",100);
		MovieclipUtils.DrawSquare(titleBg_mc,0x000000,75,zpConstants.THUMB_SIZE,20);
		
		titleBg_mc._y = zpConstants.THUMB_SIZE - titleBg_mc._height;
		
		var titleTxt_mc:MovieClip = itemType_mc.createEmptyMovieClip("titleTxt_mc",200);
		
		var field:TextField = TextfieldUtils.createField(titleTxt_mc);
		field.text = (item.type == zpConstants.TYPE_VIDEO)? "VIDEO" : ((zpImage(item).sound != undefined)? "SONIDO":"IMAGEN");
		field.setTextFormat(titleFormat);
		
		MovieclipUtils.CentreClips(titleBg_mc,titleTxt_mc);
		titleTxt_mc._y += titleBg_mc._y;
		
	}

	public function remove():Void{
		item_mc.removeMovieClip();
	}

	public function enable():Void{
		
		border_mc._visible = false;
		item_mc.enabled = true;
		
	}
	
	public function disable():Void{
		
		border_mc._visible = true;
		item_mc.enabled = false;
		
	}
	
	// **************** PRIVATE METHODS ****************
	
	private function onLoadError():Void{
		
		trace("Cannot load thumbnail");
		
	}
	
	private function onLoadProgress(mc:MovieClip,loaded:Number,total:Number):Void{
		
		var percent:Number = loaded / total;
		imageLoader.update(percent);
		
	}
	
	private function onLoadInit():Void{
		
		imageLoader.remove();
		itemType_mc._visible = true;
		
	}
	
}
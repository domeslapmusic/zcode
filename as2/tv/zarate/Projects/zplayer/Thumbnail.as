import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.zpConstants;
import tv.zarate.Projects.zplayer.zpImage;
import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.ImagePreloader;

class tv.zarate.Projects.zplayer.Thumbnail{

	private var imageLoader:ImagePreloader;
	
	private var item_mc:MovieClip;
	private var itemType_mc:MovieClip

	public function Thumbnail(_item_mc:MovieClip,item:Item){
		
		item.thumbnail = this;
		
		var titleFormat:TextFormat = new TextFormat("Verdana",10,0xffffff,true);
		
		item_mc = _item_mc;
		
		var imageLoader_mc:MovieClip = item_mc.createEmptyMovieClip("imageLoader_mc",1200);
		imageLoader = new ImagePreloader(imageLoader_mc,zpConstants.THUMB_SIZE,false);
		
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
		field.text = (item.type == zpConstants.TYPE_VIDEO)? "VIDEO" : ((zpImage(item).sound != undefined)? "SONIDO":"FOTO");
		field.setTextFormat(titleFormat);
		
		MovieclipUtils.CentreClips(titleBg_mc,titleTxt_mc);
		titleTxt_mc._y += titleBg_mc._y;
		
	}

	public function remove():Void{
		item_mc.removeMovieClip();
	}

	public function enable():Void{
		
		item_mc.enabled = true;
		item_mc.filters = new Array();
		
	}
	
	public function disable():Void{
		
		item_mc.enabled = false;
		MovieclipUtils.MakeDropShadow(item_mc);
		
	}
	
	// **************** PRIVATE METHODS ****************
	
	private function onLoadProgress(mc:MovieClip,loaded:Number,total:Number):Void{
		
		var percent:Number = loaded / total;
		imageLoader.update(percent);
		
	}
	
	private function onLoadInit():Void{
		
		imageLoader.remove();
		itemType_mc._visible = true;
		
	}
	
}
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.zpConstants;
import tv.zarate.Projects.zplayer.zpImage;
import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.ImagePreloader;

class tv.zarate.Projects.zplayer.Thumbnail{

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
		field.text = (item.type == zpConstants.TYPE_VIDEO)? "VÍDEO" : ((zpImage(item).sound != undefined)? "SONIDO":"IMAGEN");
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
	
	private function onLoadProgress(mc:MovieClip,loaded:Number,total:Number):Void{
		
		var percent:Number = loaded / total;
		imageLoader.update(percent);
		
	}
	
	private function onLoadInit():Void{
		
		imageLoader.remove();
		itemType_mc._visible = true;
		
	}
	
}
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.zpConstants;

class tv.zarate.Projects.zplayer.InfoBand{

	private var base_mc:MovieClip;
	private var field:TextField;

	private var height:Number = 0;
	private var margin:Number = 5;
	private var defaultText:String = "";
	private var displaying:Boolean = false;

	public function InfoBand(_base_mc:MovieClip,width:Number,txt:String){
		
		base_mc = _base_mc;
		
		height = zpConstants.INFO_BAND_HEIGHT;
		
		var background_mc:MovieClip = base_mc.attachMovie("infobg","background_mc",100);
		background_mc._width = width;
		
		var text_mc:MovieClip = base_mc.createEmptyMovieClip("text_mc",200);
		text_mc._x = text_mc._y = margin;
		
		var css:TextField.StyleSheet = new TextField.StyleSheet();
		css.setStyle("p",{fontFamily:"Verdana",fontSize:"10",color:"#000000"});
		
		field = TextfieldUtils.createField(text_mc,width - margin * 2,height - margin * 2,"none",true);
		field.html = true;
		field.styleSheet = css;
		
		defaultText = txt;
		
		updateText(txt);
		
	}
	
	public function remove():Void{
		base_mc.removeMovieClip();
	}
	
	public function updateText(txt:String):Void{
		field.htmlText = "<p>" + txt + "</p>";
	}
	
	public function resetText():Void{
		updateText(defaultText);
		
	}
	
	public function toggleVisibility():Void{
		
		displaying = !displaying;
		base_mc._visible = !displaying;
		
	}
	
}
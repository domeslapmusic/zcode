import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;

import tv.zarate.Projects.zplayer.zpConstants;

class tv.zarate.Projects.zplayer.ImagePreloader{

	private var base_mc:MovieClip;
	private var bar_mc:MovieClip;
	private var numberField:TextField;
	
	private var size:Number = 0;
	private var border:Number = 1;
	private var showNumber:Boolean = true;

	public function ImagePreloader(_base_mc:MovieClip,_size:Number,_showNumber:Boolean){
		
		base_mc = _base_mc;
		size = _size;
		if(_showNumber != null){ showNumber = _showNumber; }
		
		var background_mc:MovieClip = base_mc.createEmptyMovieClip("background_mc",100);
		MovieclipUtils.DrawSquare(background_mc,0x000000,40,size,size);
		MovieclipUtils.MakeDropShadow(background_mc);
		
		bar_mc = base_mc.createEmptyMovieClip("bar_mc",200);
		bar_mc._rotation = 180;
		bar_mc._x = bar_mc._y = size - border;
		
		if(showNumber){
			
			var f:TextFormat = new TextFormat("RP",40,0xffffff);
			f.align = "center";
			
			var number_mc:MovieClip = base_mc.createEmptyMovieClip("number_mc",300);
			number_mc._alpha = 75;
			
			numberField = TextfieldUtils.createField(number_mc,size,40,"none");
			numberField.embedFonts = true;
			numberField.setNewTextFormat(f);
			
			MovieclipUtils.CentreClips(base_mc,number_mc);
			MovieclipUtils.MakeDropShadow(number_mc);
			
		}
		
		update(0);
		
	}

	public function update(percent:Number):Void{
		
		// percent is a value between 0 and 1
		
		var height:Number = Math.round((size - border * 2) * percent);
		
		bar_mc.clear();
		MovieclipUtils.DrawSquare(bar_mc,0xffffff,80,size - border * 2,height);
		
		if(showNumber){ numberField.text = Math.round(percent * 100) + "%"; }
		
	}

	public function remove():Void{
		base_mc.removeMovieClip();
	}

	// **************** PRIVATE METHODS ****************
	
}
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

class tv.zarate.projects.zplayer.InfoBand{

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
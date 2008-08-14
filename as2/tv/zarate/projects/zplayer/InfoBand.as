/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
* 
*/

import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.TextfieldUtils;
import tv.zarate.utils.StyleSheetObject;

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
		
		var pStyle:StyleSheetObject = new StyleSheetObject("Verdana",10,"#000000");
		
		var css:TextField.StyleSheet = new TextField.StyleSheet();
		css.setStyle("p",pStyle);
		
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
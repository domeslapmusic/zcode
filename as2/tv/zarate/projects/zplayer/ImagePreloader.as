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

import tv.zarate.projects.zplayer.zpConstants;

class tv.zarate.projects.zplayer.ImagePreloader{

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
		
		if(showNumber){
			
			var f:TextFormat = new TextFormat("Verdana",10,0xffffff);
			f.align = "center";
			
			var number_mc:MovieClip = base_mc.createEmptyMovieClip("number_mc",300);
			number_mc._alpha = 75;
			
			numberField = TextfieldUtils.createField(number_mc);
			numberField.setNewTextFormat(f);
			
			MovieclipUtils.CentreClips(base_mc,number_mc);
			MovieclipUtils.MakeDropShadow(number_mc);
			
		} else {
			
			var background_mc:MovieClip = base_mc.createEmptyMovieClip("background_mc",100);
			MovieclipUtils.DrawSquare(background_mc,0x000000,40,size,size);
			MovieclipUtils.MakeDropShadow(background_mc,1,null,2,null,2,5);
			
			bar_mc = base_mc.createEmptyMovieClip("bar_mc",200);
			bar_mc._rotation = 180;
			bar_mc._x = bar_mc._y = size - border;			
			
		}
		
		update(0);
		
	}

	public function update(percent:Number):Void{
		
		// percent is a value between 0 and 1
		
		var height:Number = Math.round((size - border * 2) * percent);
		
		bar_mc.clear();
		MovieclipUtils.DrawSquare(bar_mc,0xffffff,80,size - border * 2,height);
		
		if(showNumber){ numberField.text = "Cargando contenido...\n" + Math.round(percent * 100) + "%"; }
		
	}

	public function remove():Void{
		base_mc.removeMovieClip();
	}

	// **************** PRIVATE METHODS ****************
	
}
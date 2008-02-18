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
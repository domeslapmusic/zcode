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

import tv.zarate.Projects.zplayer.Item;

class tv.zarate.Projects.zplayer.Player{

	private var item:Item;

	private var base_mc:MovieClip;
	private var width:Number = 0;
	private var height:Number = 0;
	private var margin:Number = 10;
	private var finishCallback:Function;

	public function Player(_item:Item,_base_mc:MovieClip,_finishCallback:Function){

		item = _item;
		base_mc = _base_mc;
		finishCallback = _finishCallback;

	}

	public function setSize(w:Number,h:Number):Void{

		if(w != null){ width = w; }
		if(h != null){ height = h; }

	}

	public function remove():Void{

		base_mc.removeMovieClip();

	}

	public function playItem():Void{}

	// **************** PRIVATE METHODS ****************

}
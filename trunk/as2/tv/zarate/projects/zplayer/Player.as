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

import tv.zarate.projects.zplayer.Item;

class tv.zarate.projects.zplayer.Player{

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
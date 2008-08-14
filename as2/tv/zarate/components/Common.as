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

class tv.zarate.components.Common{

	private var base_mc:MovieClip;
	private var back_mc:MovieClip;

	private var width:Number = 0;
	private var height:Number = 0;

	private var BACKGROUND_DEPTH:Number = 30;

	public function Common(_base_mc:MovieClip){

		base_mc = _base_mc;
		doInitialLayout();

	}

	public function setSize(w:Number,h:Number):Void{

		if(w != null){ width = w;}
		if(h != null){ height = h;}

		layout();

	}

	public function enable():Void{

		base_mc.enabled = true;
		base_mc.tabChildren = base_mc.tabEnabled = true;

	}

	public function disable():Void{

		base_mc.enabled = false;
		base_mc.tabChildren = base_mc.tabEnabled = false;

	}

	public function remove():Void{

		base_mc.removeMovieClip();

	}

	// ************************ PRIVATE FUNCTIONS ************************

	private function doInitialLayout():Void{

		back_mc = base_mc.createEmptyMovieClip("back_mc",BACKGROUND_DEPTH);
		back_mc._alpha = 0;

	}

	private function layout():Void{

		drawBackground();

	}

	private function drawBackground():Void{

		back_mc.clear();
		MovieclipUtils.DrawSquare(back_mc,0x000000,100,width,height);

	}

}
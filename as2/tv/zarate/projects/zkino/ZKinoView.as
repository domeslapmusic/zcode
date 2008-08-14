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

import tv.zarate.effects.Image;

import tv.zarate.application.View;
import tv.zarate.projects.zkino.Frame;

class tv.zarate.projects.zkino.ZKinoView extends View{
	
	private var currentImage_mc:MovieClip;
	private var nextImage_mc:MovieClip;
	private var toggleCallback:Function;
	private var loadFinishCallback:Function;
	
	public function ZKinoView(){
		
		super();
		
	}
	
	public function specificConfig(_toggleCallback:Function,_loadFinishCallback:Function):Void{
		
		toggleCallback = _toggleCallback;
		loadFinishCallback = _loadFinishCallback;
		
	}
	
	public function showFrame(frame:Frame):Void{
		
		var depth:Number = view_mc.getNextHighestDepth();
		nextImage_mc = view_mc.createEmptyMovieClip("image_" + depth,depth);
		nextImage_mc._alpha = 30;
		
		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(frame.path,nextImage_mc);
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function onLoadInit():Void{
		
		currentImage_mc.removeMovieClip();
		
		currentImage_mc = nextImage_mc;
		currentImage_mc.onPress = toggleCallback;
		
		Image.Fade(currentImage_mc,100);
		
		loadFinishCallback();
		
	}
	
}
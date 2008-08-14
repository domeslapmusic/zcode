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
import tv.zarate.utils.Delegate;

import tv.zarate.application.View;

import tv.zarate.projects.demo.zcode.HelloConfig;
import tv.zarate.projects.demo.zcode.Image;

class tv.zarate.projects.demo.zcode.HelloView extends View{

	private var conf:HelloConfig;
	
	private var background_mc:MovieClip;
	private var images_mc:MovieClip;
	private var imageWidth:Number = 0;
	
	public function HelloView(){
		
		super();
		
	}

	public function drawImages():Void{
		
		imageWidth = Math.round(width/conf.images.length);
		
		loadImage(0);
		
	}
	
	// ******************** PRIVATE METHODS ********************

	private function loadImage(counter:Number):Void{
		
		var image_mc:MovieClip = images_mc.createEmptyMovieClip("image_"+counter,100+counter);
		
		var callback:Function = Delegate.create(this,imageLoaded,counter);
		
		var image:Image = conf.images[counter];
		image.clip_mc = image_mc;
		image.load(callback);
		
	}
	
	private function imageLoaded(image:Image,counter:Number):Void{
		
		image.clip_mc._x = counter * imageWidth;
		image.clip_mc._width = imageWidth;
		image.clip_mc._yscale = image.clip_mc._xscale;
		
		counter++;
		
		if(counter < conf.images.length){
			
			loadImage(counter);
			
		}
		
	}
	
	private function initialLayout():Void{
		
		// Initial layout is called once per application
		// Create here objects that you are going to use later on
		// For example application's background
		
		background_mc = view_mc.createEmptyMovieClip("background_mc",100);
		images_mc = view_mc.createEmptyMovieClip("images_mc",200);
		
		layout();
		
	}

	private function layout():Void{
		
		// The layout method is called everytime the setSize
		// method is called
		
		background_mc.clear();
		MovieclipUtils.DrawSquare(background_mc,0x212121,100,width,height);
		
	}

}
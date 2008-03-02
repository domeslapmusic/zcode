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
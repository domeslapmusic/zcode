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
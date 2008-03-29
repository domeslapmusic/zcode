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

import tv.zarate.utils.Delegate;
import tv.zarate.utils.Trace;

class tv.zarate.application.Launcher{
	
	private var timeLine_mc:MovieClip;
	private var container_mc:MovieClip;
	
	public function Launcher(m:MovieClip){
		
		Trace.trc("ZCode Launcher");
		
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		Stage.addListener(this); 
		
		timeLine_mc = m;
		timeLine_mc.onEnterFrame = Delegate.create(this,checkSpace);
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function checkSpace():Void{
		
		if(Stage.width > 0 && Stage.height > 0){
			
			delete timeLine_mc.onEnterFrame;
			timeLine_mc.onEnterFrame = null;
			
			container_mc = timeLine_mc.createEmptyMovieClip("container_mc",200);
			
			var loader:MovieClipLoader = new MovieClipLoader();
			loader.addListener(this);
			loader.loadClip(timeLine_mc.fv_application,container_mc);
			
		}
		
	}
	
	private function onResize():Void{
		setSize(Stage.width,Stage.height);
	}
	
	private function setSize(w:Number,h:Number):Void{}
	
}
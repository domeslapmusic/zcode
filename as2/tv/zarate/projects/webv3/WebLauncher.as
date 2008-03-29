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

import tv.zarate.application.Launcher;
import tv.zarate.projects.webv3.Preload;

class tv.zarate.projects.webv3.WebLauncher extends Launcher{
	
	var preload:Preload;
	
	public function WebLauncher(m:MovieClip){
		
		super(m);
		
		preload = new Preload(m.createEmptyMovieClip("preload_mc",1000),Stage.width,Stage.height,"interface.");
		preload.update(0);
		
	}
	
	public static function main(m:MovieClip):Void{
		var instance:WebLauncher = new WebLauncher(m);
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function onLoadProgress(mc:MovieClip,loaded:Number,total:Number):Void{
		preload.update(loaded/total);
	}
	
	private function onLoadComplete():Void{
		
		preload.update(1);
		preload.remove();
		
		container_mc.fv_xmlPath = timeLine_mc.fv_xmlPath;
		
	}
	
	private function onLoadInit():Void{
		onResize();
	}
	
	private function setSize(w:Number,h:Number):Void{
		
		container_mc.application.setSize(w,h);
		preload.setSize(w,h);
		
	}
	
}
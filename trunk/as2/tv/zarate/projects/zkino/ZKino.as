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
import tv.zarate.utils.MovieclipUtils;

import tv.zarate.application.Model;

import tv.zarate.projects.zkino.Frame;
import tv.zarate.projects.zkino.ZKinoView;
import tv.zarate.projects.zkino.ZKinoConfig;

class tv.zarate.projects.zkino.ZKino extends Model{
	
	private var view:ZKinoView;
	private var conf:ZKinoConfig;
	
	private var currentFrame:Number = 0;
	private var currentInterval:Number = 0;
	private var playing:Boolean = true;
	private var totalFrames:Number = 0;
	
	public function ZKino(){
		
		view = new ZKinoView();
		conf = new ZKinoConfig();
		
		super();
		
	}
	
	public static function main(m:MovieClip):Void{
		
		var instance:ZKino = new ZKino();
		instance.config(m);
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function frameworkReady():Void{
		
		var toggleCallback:Function = Delegate.create(this,toggleKino);
		var loadFinishCallback:Function = Delegate.create(this,loadFinished);
		
		view.specificConfig(toggleCallback,loadFinishCallback);
		
		showFrame();
		
	}
	
	private function showFrame():Void{
		
		var frame:Frame = conf.frames[currentFrame];
		
		view.showFrame(frame);
		currentInterval = setInterval(this,"changeFrame",frame.delay);
		
	}
	
	private function changeFrame():Void{
		
		clearInterval(currentInterval);
		
		currentFrame++;
		
		if(currentFrame >= conf.frames.length){ 
			
			if(conf.loop){
				
				currentFrame = 0; 
				showFrame();
				
			}
			
		} else {
			
			showFrame();
			
		}
		
	}
	
	private function loadFinished():Void{
		
		// nothing now
		
	}
	
	private function toggleKino():Void{
		
		if(playing){
			
			clearInterval(currentInterval);
			
		} else {
			
			showFrame();
			
		}
		
		playing = !playing;
		
	}
	
}
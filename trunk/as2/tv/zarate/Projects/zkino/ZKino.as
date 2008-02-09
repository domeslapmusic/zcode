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

import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.Application.Model;

import tv.zarate.Projects.zkino.Frame;
import tv.zarate.Projects.zkino.ZKinoView;

class tv.zarate.Projects.zkino.ZKino extends Model{
	
	private var view:ZKinoView;
	
	private var frames:Array;
	private var currentFrame:Number = 0;
	private var currentInterval:Number = 0;
	private var playing:Boolean = true;
	private var totalFrames:Number = 0;
	
	public function ZKino(){
		
		view = new ZKinoView();
		
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
		
		view.config2(toggleCallback,loadFinishCallback);
		
		frames = new Array();
		
		totalFrames = conf.dataXML.firstChild.childNodes.length;
		
		for(var x:Number=0;x<totalFrames;x++){
			
			var node:XMLNode = conf.dataXML.firstChild.childNodes[x];			
			var f:Frame = new Frame(node.attributes["path"],Number(node.attributes["delay"]));
			
			frames.push(f);
			
		}
		
		var frame:Frame = frames[currentFrame];
		
		view.showFrame(frame);
		
		currentInterval = setInterval(this,"changeFrame",frame.delay);
		
	}
	
	private function changeFrame():Void{
		
		clearInterval(currentInterval);
		
		currentFrame++;
		
		if(currentFrame >= frames.length){ currentFrame = 0; }
		
		
		
		var frame:Frame = frames[currentFrame];
		view.showFrame(frame);
		
	}

	private function loadFinished():Void{
		
		
	}
	
	private function toggleKino():Void{
		
		if(playing){
			
			clearInterval(currentInterval);
			
		} else {
			
			var frame:Frame = frames[currentFrame];
			view.showFrame();
			
		}
		
		playing = !playing;
		
	}
	
}
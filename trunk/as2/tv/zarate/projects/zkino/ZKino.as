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
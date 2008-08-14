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
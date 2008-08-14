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
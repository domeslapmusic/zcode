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
import tv.zarate.utils.FlashVars;
import tv.zarate.utils.RightClick;
import tv.zarate.utils.Trace;
import tv.zarate.utils.MovieclipUtils;

import tv.zarate.application.Config;
import tv.zarate.application.View;

class tv.zarate.application.Model{

	public var flashvars:FlashVars;
	
	private var conf:Config;
	private var view:View;
	private var rightClickMenu:RightClick;

	private var timeLine_mc:MovieClip;

	public function Model(){
		
		Trace.trc("zFramework up and running");
		
	}

	public function config(m:MovieClip):Void{
		
		timeLine_mc = m;
		timeLine_mc.onEnterFrame = Delegate.create(this,waitForStage);
		timeLine_mc.application = this;
		
	}

	public function setSize(w:Number,h:Number):Void{
		view.setSize(w,h);
	}
	
	public function enable():Void{
		
		timeLine_mc.enabled = timeLine_mc.tabChildren = true;
		view.enable();
		
	}
	
	public function disable():Void{
		
		timeLine_mc.enabled = timeLine_mc.tabChildren = false;
		view.disable();
		
	}
	
	public function remove():Void{
		timeLine_mc.removeMovieClip();
	}

	// ******************** PRIVATE METHODS ********************

	private function waitForStage():Void{
		
		// IE takes at least 1 frame to get actual dimensions
		
		if(Stage.width > 0 && Stage.height > 0){
			
			delete timeLine_mc.onEnterFrame;
			initialize();
			
		}
		
	}

	private function initialize():Void{
		
		flashvars = new FlashVars(timeLine_mc);
		
		var xmlPath:String = flashvars.initString("fv_xmlPath","");
		
		if(conf == null){ conf = new Config(); }
		conf.flashvars = flashvars;
		conf.loadXML(xmlPath,Delegate.create(this,configReady));
		
	}

	private function configReady(success:Boolean):Void{
		
		if(success){
			
			rightClickMenu = new RightClick();
			timeLine_mc.menu = rightClickMenu;
			
			if(view == null){ view = new View(); }
			view.config(timeLine_mc.createEmptyMovieClip("view_mc",100),MovieclipUtils.isRoot(timeLine_mc),this,conf);
			
			frameworkReady();
			
		} else {
			
			trace("Impossible to create config object :(");
			
		}
		
	}

	// Model childs override this method.
	// From this point onwards the common part is done
	private function frameworkReady():Void{}

}
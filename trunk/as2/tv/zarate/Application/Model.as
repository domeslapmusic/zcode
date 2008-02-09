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
import tv.zarate.Utils.FlashVars;
import tv.zarate.Utils.RightClick;
import tv.zarate.Utils.Trace;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.Application.Config;
import tv.zarate.Application.View;

class tv.zarate.Application.Model{

	private var conf:Config;
	private var flashvars:FlashVars;
	private var view:View;
	private var rightClickMenu:RightClick;

	private var timeLine_mc:MovieClip;

	public function Model(){
		
		Trace.trc("zFramework up and running");
		
	}

	public function config(m:MovieClip):Void{
		
		timeLine_mc = m;
		timeLine_mc.onEnterFrame = Delegate.create(this,waitForStage);
		
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
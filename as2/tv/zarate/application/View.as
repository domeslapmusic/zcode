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

import tv.zarate.application.Model;
import tv.zarate.application.Config;

class tv.zarate.application.View{

	private var model:Model;
	private var conf:Config;
	
	private var view_mc:MovieClip;

	private var width:Number = 0;
	private var height:Number = 0;

	private var initialized:Boolean = false;
	
	public function View(){}

	public function config(_view_mc:MovieClip,isRoot:Boolean,_model:Model,_conf:Config):Void{
		
		if(isRoot){ 
			
			Stage.addListener(this); 
			Stage.scaleMode = "noScale";
			Stage.align = "TL";
			
		}
		
		view_mc = _view_mc;
		model = _model;
		conf = _conf;
		
		initialLayout();
		
	}

	public function enable():Void{
		
		view_mc.enabled = view_mc.tabChildren = true;
		
	}
	
	public function disable():Void{
		
		view_mc.enabled = view_mc.tabChildren = false;
		
	}
	
	public function setSize(w:Number,h:Number):Void{
		
		if(w != null){ width = w; }
		if(h != null){ height = h; }
		
		if(!initialized){
			
			initialized = true;
			
		} else {
			
			layout();
			
		}
		
	}

	// ******************** PRIVATE METHODS ********************

	private function onResize():Void{
		setSize(Stage.width,Stage.height);
	}

	// This method is called just once per instantiation
	private function initialLayout():Void{}

	// This method is called everytime the setSize method is called
	private function layout():Void{}

}
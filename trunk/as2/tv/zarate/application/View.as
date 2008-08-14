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

import tv.zarate.application.Model;
import tv.zarate.application.Config;

class tv.zarate.application.View{

	public var width:Number = 0;
	public var height:Number = 0;
	
	private var model:Model;
	private var conf:Config;
	
	private var view_mc:MovieClip;
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
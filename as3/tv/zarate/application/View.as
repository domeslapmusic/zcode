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

package tv.zarate.application{

	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	import flash.events.Event;
	
	import tv.zarate.application.Model;
	import tv.zarate.application.Config;
	
	import tv.zarate.utils.MovieClipUtils;
	import tv.zarate.utils.FlashVars;
	
	public class View extends Sprite{
		
		protected var _model:Model;
		protected var _conf:Config;
		protected var flashvars:FlashVars;
		
		protected var appWidth:int;
		protected var appHeight:int;
		
		private var initialized:Boolean = false;
		
		public function View(){
			
			super();
			
		}
		
		public function config(model:Model,conf:Config,isRoot:Boolean):void{
			
			_model = model;
			_conf = conf;
			
			if(isRoot){
				
				_model.stage.scaleMode = StageScaleMode.NO_SCALE;
				_model.stage.align = StageAlign.TOP_LEFT;
				_model.stage.addEventListener(Event.RESIZE,onResize);
				
			}
			
			onResize();
			initialLayout();
			
		}
		
		public function enable():void{}
		public function disable():void{}
		
		public function setSize(w:int,h:int):void{
			
			appWidth = w;
			appHeight = h;
			
			if(!initialized){
				
				initialized = true;
				
			} else {
				
				layout();
				
			}
			
		}
		
		// ********************* PROTECTED METHODS *********************
		
		protected function onResize(e:Event=null):void{
			setSize(_model.stage.stageWidth,_model.stage.stageHeight);
		}

		// This method is called just once per instantiation
		protected function initialLayout():void{}

		// This method is called everytime the setSize method is called
		protected function layout():void{}
		
	}

}
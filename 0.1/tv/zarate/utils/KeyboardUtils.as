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

package tv.zarate.utils{
	
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class KeyboardUtils{
		
		private static var _instance:KeyboardUtils;
		private var dic:Dictionary;
		private var stage:DisplayObject;
		
		public static function getInstance(stage:DisplayObject=null):KeyboardUtils{
			
			if(_instance == null){ _instance = new KeyboardUtils(stage); }
			return _instance;
			
		}
		
		public function KeyboardUtils(stage:DisplayObject=null){
			
			this.stage = stage;
			dic = new Dictionary();
			
		}
		
		public function register(object:DisplayObject,downCallback:Function=null,upCallback:Function=null):void{
			
			if(dic[object] == null){ // only add the object once
				
				var o:Object = new Object();
				o.downCallback = downCallback;
				o.upCallback = upCallback;
				
				dic[object] = o;
				
				if(object.stage == null){ // the object hasnt been added to the display list already
					
					object.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
					
				} else {
					
					addListeners(object);
					
				}
				
				object.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStage);
				
			}
			
		}
		
		private function addedToStage(e:Event):void{
			addListeners(DisplayObject(e.currentTarget));
		}
		
		private function removedFromStage(e:Event):void{
			
			var o:Object = dic[e.currentTarget];
			
			if(o.downCallback != null){ stage.removeEventListener(KeyboardEvent.KEY_DOWN,o.downCallback); }
			if(o.upCallback != null){ stage.removeEventListener(KeyboardEvent.KEY_UP,o.upCallback); }
			
		}
		
		private function addListeners(object:DisplayObject):void{
			
			var o:Object = dic[object];
			
			if(o.downCallback != null){ stage.addEventListener(KeyboardEvent.KEY_DOWN,o.downCallback); }
			if(o.upCallback != null){ stage.addEventListener(KeyboardEvent.KEY_UP,o.upCallback); }
			
		}
		
	}

}
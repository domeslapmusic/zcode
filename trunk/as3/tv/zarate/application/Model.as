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
	
	import flash.events.IOErrorEvent;
	
	import tv.zarate.application.View;
	import tv.zarate.application.Config;
	import tv.zarate.application.evConfigReady;
	import tv.zarate.utils.FlashVars;
	import tv.zarate.utils.MovieClipUtils;

	public class Model extends Sprite{
		
		protected var _conf:Config;
		protected var _view:View;
		protected var flashvars:FlashVars;
		
		public function Model(){
			
			super();
			
			initialize();
			
		}
		
		// ********************* PROTECTED METHODS *********************
		
		protected function initialize():void{
			
			flashvars = new FlashVars(this.root.loaderInfo);
			
			if(_conf == null){ _conf = new Config(); }
			_conf.addEventListener(evConfigReady.TYPE_LIT,configReady);
			_conf.addEventListener(IOErrorEvent.IO_ERROR,configFail);
			_conf.loadXML(flashvars.initString("fv_xmlPath",""));
			
		}
		
		protected function configReady(e:evConfigReady):void{
			
			if(_view == null){ _view = new View(); }
			_view.config(this,_conf,MovieClipUtils.IsRoot(this));
			
			addChild(_view);
			
			frameworkReady();
			
		}
		
		protected function configFail(e:IOErrorEvent):void{
			zlog("configFail > " + e);
		}
		
		/*
		* This method is called once the common part
		* of the framework is ready. Please override
		* in child classes
		*/
		
		protected function frameworkReady():void{}
		
	}

}
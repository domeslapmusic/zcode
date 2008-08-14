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

class tv.zarate.projects.webv3.Preload{
	
	private var preloadField:TextField;
	private var preload_mc:MovieClip;
	private var base_mc:MovieClip;
	private var txt:String;
	
	public function Preload(_base_mc:MovieClip,w:Number,h:Number,_txt:String,xml:XML){
		
		base_mc = _base_mc;
		txt = _txt;
		
		if(xml != null){
			
			base_mc.onEnterFrame = Delegate.create(this,checkXML,xml);
			
		}
		
		initialLayout(w,h);
		layout(w,h);
		
	}
	
	public function remove():Void{
		
		delete base_mc.onEnterFrame;
		base_mc.removeMovieClip();
		
	}
	
	public function update(percent:Number):Void{
		updateField(percent);
	}
	
	public function setSize(w:Number,h:Number):Void{
		layout(w,h);
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function initialLayout(w:Number,h:Number):Void{
		
		preload_mc = base_mc.createEmptyMovieClip("preload_mc",200);
		
		preloadField = preload_mc.createTextField("field",100,0,0,0,0);
		preloadField.autoSize = "left";
		preloadField.setNewTextFormat(new TextFormat("Verdana",50,0xffffff));
		
		updateField(0);
		
	}
	
	private function updateField(percent:Number):Void{
		
		var p:Number = (isNaN(percent))? 0:percent;
		preloadField.text = txt + Math.round(p*100) + "%";
		
	}
	
	private function layout(w:Number,h:Number):Void{
		
		preload_mc._x = Math.round((w-preload_mc._width)/2);
		preload_mc._y = Math.round((h-preload_mc._height)/2);
		
	}
	
	private function checkXML(xml:XML):Void{
		update(xml.getBytesLoaded()/xml.getBytesTotal());
	}
	
}
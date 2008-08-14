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

import cl.cay.effects.Basic;

class tv.zarate.projects.demo.zcode.Image{
	
	public var path:String = "";
	public var url:String = "";
	public var clip_mc:MovieClip;
	public var loadCallback:Function;
	
	public function Image(){}
	
	public function setXML(imageXML:XMLNode):Void{
		
		path = imageXML.attributes["path"];
		url = imageXML.attributes["url"];
		
	}
	
	public function load(callback:Function):Void{
		
		loadCallback = callback;
		
		var loader:MovieClipLoader = new MovieClipLoader();
		loader.addListener(this);
		loader.loadClip(path,clip_mc);
		
	}
	
	public function toString():String{
		return "Image [path=" + path + ", url= " + url + "]";
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function onLoadInit():Void{
		
		var url:String = url;
		
		clip_mc.onPress = function():Void{ getURL(url); }
		
		Basic.WetFloor(clip_mc);
		
		loadCallback(this);
		
	}
	
}
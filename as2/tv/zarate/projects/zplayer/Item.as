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

import tv.zarate.projects.zplayer.Thumbnail;

class tv.zarate.projects.zplayer.Item{

	public var thumbnail:Thumbnail;
	
	public var url:String = "";
	public var info:String = "";
	public var title:String = "";
	public var type:String = "";
	public var thumb:String = "";
	public var order:Number = -1;
	public var clip:MovieClip;

	public function Item(){}

	public function setXML(x:XMLNode):Void{}
	
	public function toString():String{ return ""; }

	public function enable():Void{
		thumbnail.enable();
	}
	
	public function disable():Void{
		thumbnail.disable();
	}
	
	// **************** PRIVATE METHODS ****************
	
	private function setThumb(path:String):Void{
		
		var ext:String = path.substr(path.lastIndexOf("."));
		thumb = path.substr(0,path.lastIndexOf(".")) + "_t" + ext;
		
	}
	
}
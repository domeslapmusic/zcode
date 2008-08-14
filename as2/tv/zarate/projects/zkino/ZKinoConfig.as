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

import tv.zarate.application.Config;

import tv.zarate.projects.zkino.Frame;

class tv.zarate.projects.zkino.ZKinoConfig extends Config{
	
	public var frames:/*Frame*/Array;
	public var loop:Boolean = true;
	
	public function ZKinoConfig(){
		
		super();
		
		frames = new Array();
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function xmlLoaded(success:Boolean,callback:Function):Void{
		
		if(success){
			
			var optionsNode:XMLNode = dataXML.firstChild.childNodes[0];
			loop = (optionsNode.attributes["loop"] == "true")? true:false;
			
			var framesNode:XMLNode = dataXML.firstChild.childNodes[1];
			var totalFrames:Number = framesNode.childNodes.length;
			
			for(var x:Number=0;x<totalFrames;x++){
				
				var f:Frame = new Frame();
				f.setXML(framesNode.childNodes[x]);
				
				frames.push(f);
				
			}
			
			
		}
		
		super.xmlLoaded(success,callback);
		
	}
	
}
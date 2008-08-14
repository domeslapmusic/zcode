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

import com.xfactorstudio.xml.xpath.XPath;

import tv.zarate.projects.demo.zcode.Image;

class tv.zarate.projects.demo.zcode.HelloConfig extends Config{

	public var images:/*Image*/Array;
	
	public function HelloConfig(){
		
		super();
		
		images = new Array();
		
	}

	// ******************** PRIVATE METHODS ********************

	private function xmlLoaded(success:Boolean,callback:Function):Void{
		
		// You usually parse whatever you need from the xml
		// and then expose it as public variables whoever might need it
		// Remember that both the Model and the View have access to
		// this class
		
		// Using XPath is entirely your decision.
		// ZCode does *NOT* include it by default
		
		var imageNodes/*XMLNode*/:Array = XPath.selectNodes(dataXML,"data/image");
		var totalImages:Number = imageNodes.length;
		
		for(var x:Number=0;x<totalImages;x++){
			
			var i:Image = new Image();
			i.setXML(imageNodes[x]);
			
			images.push(i);
			
		}
		
		super.xmlLoaded(success,callback);
		
	}
	
}
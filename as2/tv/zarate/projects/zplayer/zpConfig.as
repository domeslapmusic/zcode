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
import tv.zarate.utils.FlashVars;
import tv.zarate.utils.MathUtils;

import tv.zarate.application.Config;

import tv.zarate.projects.zplayer.Item;
import tv.zarate.projects.zplayer.zpVideo;
import tv.zarate.projects.zplayer.zpImage;
import tv.zarate.projects.zplayer.zpConstants;

class tv.zarate.projects.zplayer.zpConfig extends Config{

	public var imageDelay:Number = 5;

	public function zpConfig(){
		
		super();
		
	}
	
	public function getItems():/*Item*/Array{
		
		var items:/*Item*/Array = new Array();
		
		var itemsNode:XMLNode = dataXML.firstChild.childNodes[0];
		var totalItems:Number = itemsNode.childNodes.length;
		
		for(var x:Number=0;x<totalItems;x++){
			
			var itemNode:XMLNode = itemsNode.childNodes[x];
			var type:String = itemNode.attributes["type"];
			var i:Item;
			
			switch(type){
				
				case(zpConstants.TYPE_VIDEO):
					
					i = new zpVideo();
					i.setXML(itemNode);
					break;
					
				case(zpConstants.TYPE_IMAGE):
					
					i = new zpImage();
					i.setXML(itemNode);
					break;
				
			}
			
			i.order = x;
			items.push(i);
			
		}
		
		if(items.length > 1){
			
			// if more than one item, 
			// we random between first 3 elements
			
			var maxElement:Number = Math.min(2,items.length-1);			
			var rnd:Number = MathUtils.getRandom(maxElement);
			
			var randItem:Item = items[rnd];
			
			items.splice(rnd,1);
			items.splice(0,0,randItem);
			
		}
		
		return items;
		
	}
	
	// **************** PRIVATE METHODS ****************

}
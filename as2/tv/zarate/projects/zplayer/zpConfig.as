/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
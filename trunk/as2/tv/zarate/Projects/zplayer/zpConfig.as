import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.FlashVars;
import tv.zarate.Utils.MathUtils;

import tv.zarate.Application.Config;

import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpVideo;
import tv.zarate.Projects.zplayer.zpImage;
import tv.zarate.Projects.zplayer.zpConstants;

class tv.zarate.Projects.zplayer.zpConfig extends Config{

	public var imageDelay:Number = 5;

	private static var _instance:zpConfig;

	public static function getInstance():zpConfig{
		
		if(_instance == null){ _instance = new zpConfig(); }
		return _instance;
		
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

	private function zpConfig(){}
	
}
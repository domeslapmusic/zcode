import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.FlashVars;

import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpVideo;
import tv.zarate.Projects.zplayer.zpImage;
import tv.zarate.Projects.zplayer.zpConstants;

class tv.zarate.Projects.zplayer.zpConfig{

	public var imageDelay:Number = 5;

	private var xmlPath:String = "zplayer.xml";
	private var dataXML:XML;

	public function zpConfig(m:MovieClip,callback:Function){

		var flashvars:FlashVars = new FlashVars(m);

		xmlPath = flashvars.initString("xmlPath",xmlPath);

		loadXML(callback);

	}

	// **************** PRIVATE METHODS ****************

	private function loadXML(callback:Function):Void{

		dataXML = new XML();
		dataXML.ignoreWhite = true;
		dataXML.onLoad = Delegate.create(this,xmlLoaded,callback);
		dataXML.load(xmlPath);

	}

	private function xmlLoaded(success:Boolean,callback:Function):Void{

		var items:/*Item*/Array = new Array();

		if(success){

			var settingsNode:XMLNode = dataXML.firstChild.childNodes[0];

			imageDelay = settingsNode.attributes["imageDelay"];

			var itemsNode:XMLNode = dataXML.firstChild.childNodes[1];
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

				items.push(i);

			}

		}

		callback(success,items);

	}

}
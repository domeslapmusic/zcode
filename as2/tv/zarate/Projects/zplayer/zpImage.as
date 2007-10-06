import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpConstants;

class tv.zarate.Projects.zplayer.zpImage extends Item{

	public var sound:String = "";
	public var duration:Number = 0; // duration in miliseconds

	public function zpImage(){}

	public function setXML(xmlNode:XMLNode):Void{
		
		type = zpConstants.TYPE_IMAGE;
		
		url = xmlNode.attributes["url"];
		thumb = xmlNode.attributes["thumb"];
		sound = xmlNode.attributes["sound"];
		title = xmlNode.childNodes[0].firstChild.nodeValue;
		info = xmlNode.childNodes[1].firstChild.nodeValue;
		
		if(sound != undefined){
			
			var durationData:Array = String(xmlNode.attributes["time"]).split(":");
			
			var mins:Number = Number(durationData[0]);
			var secs:Number = Number(durationData[1])
			
			duration = ((mins * 60) + secs) * 1000;
			
		}
		
	}

	public function toString():String{
		return "Image [url=" + url + ", title=" + title + "]";
	}

}
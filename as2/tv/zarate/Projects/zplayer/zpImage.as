import tv.zarate.projects.zplayer.Item;
import tv.zarate.projects.zplayer.zpConstants;

class tv.zarate.projects.zplayer.zpImage extends Item{

	public var sound:String = "";
	public var duration:Number = 0; // duration in miliseconds
	public var link:String = "";
	public var target:String = "_self";

	public function zpImage(){}

	public function setXML(xmlNode:XMLNode):Void{
		
		type = zpConstants.TYPE_IMAGE;
		
		url = xmlNode.attributes["url"];
		sound = xmlNode.attributes["sound"];
		link = xmlNode.attributes["link"];
		if(xmlNode.attributes["target"] != undefined){ target = xmlNode.attributes["target"]; }
		title = xmlNode.childNodes[0].firstChild.nodeValue;
		info = xmlNode.childNodes[1].firstChild.nodeValue;
		
		if(sound != undefined){
			
			var durationData:Array = String(xmlNode.attributes["time"]).split(":");
			
			var mins:Number = Number(durationData[0]);
			var secs:Number = Number(durationData[1])
			
			duration = ((mins * 60) + secs) * 1000;
			
		}
		
		setThumb(url);
		
	}

	public function toString():String{
		return "Image [url=" + url + ", title=" + title + "]";
	}

}
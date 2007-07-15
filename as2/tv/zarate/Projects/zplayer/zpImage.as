import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpConstants;

class tv.zarate.Projects.zplayer.zpImage extends Item{

	public var sound:String = "";

	public function zpImage(){}

	public function setXML(xmlNode:XMLNode):Void{

		type = zpConstants.TYPE_IMAGE;

		url = xmlNode.attributes["url"];
		thumb = xmlNode.attributes["thumb"];
		sound = xmlNode.attributes["sound"];
		title = xmlNode.childNodes[0].firstChild.nodeValue;
		info = xmlNode.childNodes[1].firstChild.nodeValue;

	}

	public function toString():String{
		return "Image [url=" + url + ", title=" + title + "]";
	}

}
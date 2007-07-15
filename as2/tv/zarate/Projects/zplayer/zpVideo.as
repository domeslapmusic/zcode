import tv.zarate.Projects.zplayer.Item;
import tv.zarate.Projects.zplayer.zpConstants;

class tv.zarate.Projects.zplayer.zpVideo extends Item{

	public function zpVideo(){}

	public function setXML(xmlNode:XMLNode):Void{

		type = zpConstants.TYPE_VIDEO;

		url = xmlNode.attributes["url"];
		thumb = xmlNode.attributes["thumb"];
		title = xmlNode.childNodes[0].firstChild.nodeValue;
		info = xmlNode.childNodes[1].firstChild.nodeValue;

	}

	public function toString():String{
		return "Video [url=" + url + ", title=" + title + "]";
	}

}
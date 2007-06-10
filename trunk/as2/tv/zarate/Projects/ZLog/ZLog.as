/*
*
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
*
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*
*/

import tv.zarate.Utils.Delegate;
import flash.external.ExternalInterface;

class tv.zarate.Projects.ZLog.ZLog{

	// clips
	private var receiving_lc:LocalConnection;
	private var fakeBR:String = "[br]";

	public function ZLog(m:MovieClip){

		receiving_lc = new LocalConnection();
		receiving_lc.allowDomain = function(domain:String):Boolean { return true; }
		receiving_lc.allowInsecureDomain = function(domain:String):Boolean { return true; }

		receiving_lc.log = Delegate.create(this,update);
		receiving_lc.connect("_ZLog");

		send("ZLog up and running...","",false);

	}

	public static function main(m:MovieClip):Void{
		var zlog:ZLog = new ZLog(m);
	}

	// PRIVATE METHODS

	private function update(s:Object,type:String,reset:Boolean):Void{

		if(s instanceof XML){

			var rawXML:String = fakeBR + getNodeString(XMLNode(s.firstChild),0);
			s = replaceEntities(rawXML);
			s = s.split(fakeBR).join("<br>");

		}

		send(s,type,reset);

	}

	private function getNodeString(node:XMLNode,depth:Number):String{

		var s:String = "";
		var spacer:String = "";

		for(var x:Number=0;x<depth;x++){ spacer += "&nbsp;&nbsp;&nbsp;"; }

		if(node.hasChildNodes()){

			var attString:String = "";

			for(var x:String in node.attributes){ attString += " " + x + '="' + node.attributes[x] + '" '; }
			if(attString != ""){ attString = attString.substring(0,attString.length-1); }

			s += spacer + "&lt;" + node.nodeName + attString + "&gt;" + fakeBR;

			var totalChilds:Number = node.childNodes.length;

			for(var x:Number=0;x<totalChilds;x++){

				var n:XMLNode = node.childNodes[x];

				if(n.hasChildNodes()){

					s += getNodeString(n,depth+1);

				} else {

					s += spacer + spacer + replaceEntities(n.toString())  + fakeBR;

				}

			}

			s += spacer + "&lt;/" + node.nodeName + "&gt;" + fakeBR;

		} else {

			s += spacer + replaceEntities(node.toString()) + fakeBR;

		}

		return s;

	}

	private function send(s:Object,type:String,reset:Boolean):Void{
		ExternalInterface.call("updateZLog",escape(s.toString()),type,reset);
	}

	private function replaceEntities(s:String):String{
		return s.split("<").join("&lt;").split(">").join("&gt;");
	}

}
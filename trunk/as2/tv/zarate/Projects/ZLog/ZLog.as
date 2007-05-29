import tv.zarate.Utils.Delegate;
import flash.external.ExternalInterface;

class tv.zarate.Projects.ZLog.ZLog{

	// clips
	private var receiving_lc:LocalConnection;

	public function ZLog(m:MovieClip){

		receiving_lc = new LocalConnection();
		receiving_lc.allowDomain = function(domain:String):Boolean { return true; }
		receiving_lc.allowInsecureDomain = function(domain:String):Boolean { return true; }
		receiving_lc.log = Delegate.create(this,updateJS);
		receiving_lc.connect("_ZLog");

	}

	public static function main(m:MovieClip):Void{
		var zlog:ZLog = new ZLog(m);
	}

	// PRIVATE METHODS

	private function updateJS(s:Object,type:String,reset:Boolean):Void{

		if(s instanceof XML){

			var rawXML:String = getNodeString(XMLNode(s));

			rawXML = rawXML.split("<").join("&lt;").split(">").join("&gt;");

			s = rawXML;

		}

		wadus(s,type,reset);

	}

	private function getNodeString(node:XMLNode):String{

		var s:String = "";

		if(node.hasChildNodes()){

			wadus2(node.nodeName +" childs")

			var totalChilds:Number = node.childNodes.length;

			for(var x:Number=0;x<totalChilds;x++){

				s += getNodeString(node.childNodes[x]);

			}


		} else {


			s += node.toString();

			wadus2(node.nodeName +" NO childs > " + node.toString())

		}

		return s;

	}

	private function wadus(s:Object,type:String,reset:Boolean){
		ExternalInterface.call("updateZLog",escape(s.toString()),type,reset);
	}

	private function wadus2(s:String):Void{

		ExternalInterface.call("alert",s);
	}

}
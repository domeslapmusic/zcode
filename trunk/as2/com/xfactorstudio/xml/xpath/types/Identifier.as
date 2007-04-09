import com.xfactorstudio.xml.xpath.types.QueryPart;
import com.xfactorstudio.xml.xpath.XPath;

class com.xfactorstudio.xml.xpath.types.Identifier extends QueryPart{
	public var nodeName:String = "identifier";
	public function Identifier(name:String){
		super();
		this.nodeValue = name;
	}
	
	public function execute(context:Array):Array {
		var ret:Array = XPath.getNamedNodes(context,this.nodeValue.toString());
		return ret;
	}
	
	public function clone():Identifier {
		var obj:Identifier = new Identifier();
		super.clone(obj);
		return obj;
	}
	
}
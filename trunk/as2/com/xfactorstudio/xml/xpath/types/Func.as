import com.xfactorstudio.xml.xpath.types.QueryPart;
import com.xfactorstudio.xml.xpath.XPathFunctions;

class com.xfactorstudio.xml.xpath.types.Func extends QueryPart{
	
	public var nodeName:String = "function";
	private var nodeValue:Number;
	
	public function Func(name:Number){
		super();
		nodeValue = name;
	}
	
	public function register(){
		this.parentNode["hasFunctions"] = true;
	}
	
	public function clone():Func {
		var obj:Func = new Func(nodeValue);
		super.clone(obj);
		return obj;
	}
	public function execute(context:Array,axis:Array):Object {

		for(var i:Number=0;i<this.childNodes.length;i++){
			switch(typeof(this.childNodes[i])){
				case "string":
				case "boolean":
				case "number":
					break;
				default:
					this.childNodes[i] = this.childNodes[i].execute(context);
					break
			}
		}
		return XPathFunctions.getFunction(nodeValue).call(this,this.childNodes,context[0],axis);
	}
	
}
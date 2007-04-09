import com.xfactorstudio.xml.xpath.types.QueryPart;
import com.xfactorstudio.xml.xpath.types.Predicate;

class com.xfactorstudio.xml.xpath.types.Group extends QueryPart{
	public var nodeName:String = "group";
	public function Group(){
		super();
	}
	
	public function clone():Group {
		var obj:Group = new Group();
		super.clone(obj);
		return obj;
	}
	
	public function execute(context:Array):Object {
		var result:Object;
		var p:Predicate = new Predicate();
		for(var j:Number=0;j<this.childNodes.length;j++){
			p.appendChild(this.childNodes[j]);
		}
		var retArray:Array = new Array();
		for(var i:Number=0;i<context.length;i++){
			var test:Predicate = p.clone();
			result = Predicate.staticEvaluate(test,context[i]);
		}
		return result;
	}
	
}
import com.xfactorstudio.xml.xpath.types.QueryPart;
import com.xfactorstudio.xml.xpath.XPathAxes;
import com.xfactorstudio.xml.xpath.Axes;


class com.xfactorstudio.xml.xpath.types.Axis extends QueryPart{
	public var nodeName:String = "axis";

	public function Axis(axis:Number){
		super();
		this.nodeValue = axis;
	
	}
	
	public function clone():Axis {
		var obj:Axis = new Axis();
		super.clone(obj);
		return obj;
	}
	
	public function execute(context:Array):Array {
		var retArray:Array = new Array();
		for(var i:Number=0;i<context.length;i++){
			retArray = retArray.concat(XPathAxes[Axes.getName(Number(this.nodeValue))].call(this,context[i]));
		}
		return retArray;
	}
}
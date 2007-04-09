import com.xfactorstudio.xml.xpath.types.QueryPart;
import com.xfactorstudio.xml.xpath.types.Path;
import com.xfactorstudio.xml.xpath.types.Func;
import com.xfactorstudio.xml.xpath.types.Operator;
import com.xfactorstudio.xml.xpath.Operators;
import com.xfactorstudio.xml.xpath.XPathFunctions;
import com.xfactorstudio.xml.xpath.types.Group;

class com.xfactorstudio.xml.xpath.types.Predicate extends QueryPart{
	public var nodeName:String = "predicate";
	public var hasGroups:Boolean = false;
	public var hasPaths:Boolean = false;
	public var hasFunctions:Boolean = false;
	public var hasUnions:Boolean = false;
	public var hasAdditiveExpressions:Boolean = false;
	public var hasMultiplicativeExpressions:Boolean = false;
	public var hasRelationalExpressions:Boolean = false;
	public var hasEqualityExpressions:Boolean = false;
	public var hasLogicalAndExpressions:Boolean = false;
	public var hasLogicalOrExpressions:Boolean = false;
	

	public function Predicate(){
		super();
	}
	
	public function appendChild(child:Object):Object{
		this.childNodes.push(child);
		this.childNodes[this.childNodes.length-1].parentNode = this;
		child.register();		
		
		return this.childNodes[this.childNodes.length-1];
	}
	
	public function execute(context:Array):Array{
		var retArray:Array = new Array();
		for(var i:Number=0;i<context.length;i++){
			var test:Predicate = this.clone();
			
			var val:Object = evaluate(test,context[i],context);
			if(typeof(val) == "number"){
				val = (val == Predicate.getChildIndex(context[i]));
			}else{
				val = XPathFunctions.toBoolean(val);
			}
			if(val){
				retArray.push(context[i]);
			}
		}

		return retArray;
	}
	
	public function clone():Predicate {
		var obj:Predicate = new Predicate();
		super.clone(obj);
		return obj;
	}

	public static function staticEvaluate(test:Object, contextNode:XMLNode, axis:Object):XMLNode {
		Predicate.solveGroups(test,contextNode);
		Predicate.solveFunctions(test,contextNode,axis);
		Predicate.solvePaths(test,contextNode);
		Predicate.solveUnions(test,contextNode);
		Predicate.solveMultiplicativeExpressions(test,contextNode);
		Predicate.solveAdditiveExpressions(test,contextNode);
		Predicate.solveRelationalExpressions(test,contextNode);
		Predicate.solveEqualityExpressions(test,contextNode);
		Predicate.solveLogicalAndExpressions(test,contextNode);
		Predicate.solveLogicalOrExpressions(test,contextNode);
		return test.childNodes[0];
		
	}
	public function evaluate(test:Object, contextNode:XMLNode, axis:Object):XMLNode {
		if(this.hasGroups)
			Predicate.solveGroups(test,contextNode);
		if(this.hasFunctions)
			Predicate.solveFunctions(test,contextNode,axis);
		if(this.hasPaths)
			Predicate.solvePaths(test,contextNode);
		if(this.hasUnions)
			Predicate.solveUnions(test,contextNode);
		if(this.hasMultiplicativeExpressions)
			Predicate.solveMultiplicativeExpressions(test,contextNode);
		if(this.hasAdditiveExpressions)
			Predicate.solveAdditiveExpressions(test,contextNode);
		if(this.hasRelationalExpressions)
			Predicate.solveRelationalExpressions(test,contextNode);
		if(this.hasEqualityExpressions)
			Predicate.solveEqualityExpressions(test,contextNode);
		if(this.hasLogicalAndExpressions)
			Predicate.solveLogicalAndExpressions(test,contextNode);
		if(this.hasLogicalOrExpressions)
			Predicate.solveLogicalOrExpressions(test,contextNode);
		return test.childNodes[0];
		
	}
	
	public static function solveEqualityExpressions(test:Object, contextNode:Object){
		for(var i:Number=0;i<test.childNodes.length;i++){
			if(test.childNodes[i] instanceof Operator){
				switch(test.childNodes[i].nodeValue){
					case Operators.EQUALS:		
						//This needs to check all the nodes not just the first
						//var val = false;
						//for(var n=0;n<test.childNodes[i-1].length;n++){
						//	if(Predicate.isEqualTo(test.childNodes[i-1][n],test.childNodes[i+1])){
						//		val = true;
						//	}
						//}
						//test.childNodes.splice(i-1,3,val);
						test.childNodes.splice(i-1,3,Predicate.isEqualTo(test.childNodes[i-1],test.childNodes[i+1]));
						i=i-2;
						break;
					case Operators.NOT_EQUALS:
						test.childNodes.splice(i-1,3,Predicate.isNotEqualTo(test.childNodes[i-1],test.childNodes[i+1]));
						i=i-2;
						break;
				}
			}
		}
	}

	
	static function solveMultiplicativeExpressions(test:Object,contextNode:XMLNode ){
		for(var i:Number=0;i<test.childNodes.length;i++){
			switch(test.childNodes[i].nodeValue){
				case Operators.MULTIPLY:
					test.childNodes.splice(i-1,3,Number(test.childNodes[i-1]) * Number(test.childNodes[i+1]));
					i=i-2;
					break;
				case Operators.MOD:
					test.childNodes.splice(i-1,3,Number(test.childNodes[i-1]) % Number(test.childNodes[i+1]));
					i=i-2;
					break;
				case Operators.DIV:
					test.childNodes.splice(i-1,3,Number(test.childNodes[i-1]) / Number(test.childNodes[i+1]));
					i=i-2;
					break;
			}
		}
	}
	
	static function solveAdditiveExpressions(test:Object, contextNode:XMLNode){
		for(var i:Number=0;i<test.childNodes.length;i++){
			switch(test.childNodes[i].nodeValue){
				case Operators.PLUS:
					test.childNodes.splice(i-1,3,Number(test.childNodes[i-1]) + Number(test.childNodes[i+1]));
					i=i-2;
					break;
				case Operators.MINUS:
					test.childNodes.splice(i-1,3,Number(test.childNodes[i-1]) - Number(test.childNodes[i+1]));
					i=i-2;
					break;
			}
		}
	}
	
	static function solveLogicalAndExpressions(test:Object, contextNode:XMLNode){
		for(var i:Number=0;i<test.childNodes.length;i++){
			if(test.childNodes[i].nodeValue == Operators.AND){
				var result:Boolean = (Predicate.isTrue(test.childNodes[i-1]) && Predicate.isTrue(test.childNodes[i+1]))? true : false;
					test.childNodes.splice(i-1,3,result);
					i=i-2;
			}
		}
	}
	
	static function solveLogicalOrExpressions(test:Object, contextNode:XMLNode){
		for(var i:Number=0;i<test.childNodes.length;i++){
			if(test.childNodes[i].nodeValue == Operators.OR){
				var result:Boolean = (Predicate.isTrue(test.childNodes[i-1]) || Predicate.isTrue(test.childNodes[i+1]))? true : false;
					test.childNodes.splice(i-1,3,result);
					i=i-2;
			}
		}
	}
	
	static function solveRelationalExpressions(test:Object ,contextNode:XMLNode ){
		for(var i:Number=0;i<test.childNodes.length;i++){
			switch(test.childNodes[i].nodeValue){
				case Operators.GREATER_THAN:
					test.childNodes.splice(i-1,3,Predicate.isGreaterThan(test.childNodes[i-1],test.childNodes[i+1]));
					i=i-2;
					break;
				case Operators.LESS_THAN:
					test.childNodes.splice(i-1,3,Predicate.isLessThan(test.childNodes[i-1],test.childNodes[i+1]));
					i=i-2;
					break;
				case Operators.GREATER_THAN_OR_EQUAL_TO:
					test.childNodes.splice(i-1,3,Predicate.isGreaterThanOrEqualTo(test.childNodes[i-1],test.childNodes[i+1]));
					i=i-2;
					break;
				case Operators.LESS_THAN_OR_EQUAL_TO:
					test.childNodes.splice(i-1,3,Predicate.isLessThanOrEqualTo(test.childNodes[i-1],test.childNodes[i+1]));
					i=i-2;
					break;
			}
		}
	}
	
	public static function solvePaths(test:Object, contextNode:XMLNode){
		for(var j:Number=0;j<test.childNodes.length;j++){
			if(test.childNodes[j]instanceof Path){
				test.childNodes[j] = test.childNodes[j].execute([contextNode]);
			}
		}
	}
	
	public static function solveUnions(test:Object, contextNode:XMLNode ){
		for(var j:Number=0;j<test.childNodes.length;j++){
			if(test.childNodes[j]instanceof Operator){
				if(test.childNodes[j].nodeValue == Operators.UNION){
					test.childNodes[j-1] = test.childNodes[j-1].concat(test.childNodes[j+1]);
					//sort by document order
					test.childNodes[j-1].sort(Predicate.sortByIndexFunction);
					test.childNodes.splice(j-1,3,test.childNodes[j-1]);
					j=j-2;
				}
			}
		}
	}
	
	public static function solveGroups(test:Object, contextNode:XMLNode){
		for(var j:Number=0;j<test.childNodes.length;j++){
			if(test.childNodes[j]instanceof Group){
				var gVal:Object = test.childNodes[j].execute([contextNode]);
				test.childNodes.splice(j,1,gVal);
			}
		}
	}
	
	public static function solveFunctions(test:Object, contextNode:XMLNode,axis:Object){
		for(var j:Number=0;j<test.childNodes.length;j++){
			if(test.childNodes[j]instanceof Func){
				var gVal:Object = test.childNodes[j].execute([contextNode],axis);
				test.childNodes.splice(j,1,gVal);
			}
		}
	}
	
	public static function sortByIndexFunction(a:Object, b:Object):Number {
		var ai:Array = Predicate.getDocumentOrder(a);
		var bi:Array = Predicate.getDocumentOrder(b);
		for(var i:Number=0;i<ai.length;i++){
			if(bi[i] == null){
				return 1;
			}
			if(ai[i] > bi[i]){
				return 1;
			}else if(ai[i] < bi[i]){
				return -1;
			}
		}
		if(bi.length > ai.length){
			return -1;
		}
		return 0;
	}


	
	/**
		Equality Expressions
	**/
	static function isEqualTo(val1:Object, val2:Object):Boolean{
		var values:Object = Predicate.convertForComparison(val1, val2);
		return (values.val1 == values.val2);
	}
	
	static function isNotEqualTo(val1:Object, val2:Object):Boolean{
		var values:Object = Predicate.convertForComparison(val1, val2);
		return (values.val1 != values.val2);
	}
	
	/**
		Relational Expressions
	**/
	static function isGreaterThan(val1:Object, val2:Object):Boolean{
		var values:Object = Predicate.convertForComparison(val1, val2);
		return (values.val1 > values.val2);
	}
	
	static function isLessThan(val1:Object, val2:Object):Boolean{
		var values:Object = Predicate.convertForComparison(val1, val2);
		return (values.val1 < values.val2);
	}
	
	static function isGreaterThanOrEqualTo(val1:Object, val2:Object):Boolean{
		var values:Object = Predicate.convertForComparison(val1, val2);
		return (values.val1 >= values.val2);
	}
	static function isLessThanOrEqualTo(val1:Object, val2:Object):Boolean{
		var values:Object = Predicate.convertForComparison(val1, val2);
		return (values.val1 <= values.val2);
	}

	
	static function getChildIndex(kid:XMLNode):Number{
		var bros:Array = kid.parentNode.childNodes;
		var sibCount:Number = 0;
		
		for(var i:Number=0;i<bros.length;i++){
			if(bros[i].nodeName == kid.nodeName){
				sibCount++;
			}
			if(bros[i] === kid){
				return sibCount;
			}
		}
		return 0;
	}
	
	static function getDocumentOrder(kid:Object):Array{
		var docOrder:Array = [];
		while(kid.parentNode != null){
			docOrder.push(Predicate.getIndex(kid));
			kid = kid.parentNode;
		}
		docOrder.reverse();
		return docOrder;
	}
	
	static function getIndex(kid:Object):Number{
		var bros:Array = kid.parentNode.childNodes;
		var sibCount:Number = 0;
		for(var i:Number=0;i<bros.length;i++){
			sibCount++;
			if(bros[i] === kid){
				return sibCount;
			}
		}
		return 0;
	}
	
	static function getIndexOfType(kid:XMLNode):Number{
		var bros:Array = kid.parentNode.childNodes;
		var sibCount:Number = 0;
		for(var i:Number=0;i<bros.length;i++){
			if(bros[i].nodeName == kid.nodeName){
			sibCount++;
				if(bros[i] === kid){
					return sibCount;
				}
			}
		}
		return 0;
	}
	
	static function convertForComparison(val1:Object, val2:Object):Object{
		var tv1:String,tv2:String;
		tv1 = typeof(val1)
		tv2 = typeof(val2)

		if(tv1 == "boolean" || tv2 == "boolean"){
			val1 = XPathFunctions.toBoolean(val1);
			val2 = XPathFunctions.toBoolean(val2);
			return {val1:val1,val2:val2};
		}
		
		if(tv1 == "number" || tv2 == "number"){
			val1 = XPathFunctions.toNumber(val1);
			val2 = XPathFunctions.toNumber(val2);
			return {val1:val1,val2:val2};
		}
		
		if( tv1 == "string"|| tv2 == "string"){
			val1 = XPathFunctions.toString(val1);
			val2 = XPathFunctions.toString(val2);
			return {val1:val1,val2:val2};
		}
		return {val1:val1,val2:val2};
	}
	
	static function isTrue(test:Object):Boolean{
		return XPathFunctions.toBoolean(test);
		
	}
	
}
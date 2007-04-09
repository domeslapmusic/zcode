/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
*/

class tv.zarate.Utils.Delegate{
	
	// from Till Schneidereit
	// http://lists.motion-twin.com/pipermail/mtasc/2005-April/001602.html
	
	public static function create(scope:Object,method:Function):Function{
		
		var params:Array = arguments.splice(2,arguments.length-2);
		
		var proxyFunc:Function = function():Void{
			method.apply(scope,arguments.concat(params));
		}
		
		return proxyFunc;
		
	}
	
	public static function createR(scope:Object,method:Function):Function{
		
		var params:Array = arguments.splice(2,arguments.length-2);
		
		var proxyFunc:Function = function():Void{
			method.apply(scope,params.concat(arguments));
		}
		
		return proxyFunc;
		
	}
	
}
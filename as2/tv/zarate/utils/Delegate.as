/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
* 
*/

class tv.zarate.utils.Delegate{
	
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
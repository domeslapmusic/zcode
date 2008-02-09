/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
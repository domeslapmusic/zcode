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

class tv.zarate.Utils.ClassUtils{
	
	public static function getInstanceFromClasspath(classPath:String):Object{
		
		var constructor:Function;
		var classpathBits:Array = classPath.split(".");
		
		constructor = _global[classpathBits[0]];

		for(var x:Number=1;x<classpathBits.length;x++){ constructor = constructor[classpathBits[x]]; }

		return new constructor();
		
	}

}
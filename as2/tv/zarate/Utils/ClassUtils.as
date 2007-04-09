/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
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
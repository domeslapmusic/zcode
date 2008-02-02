/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
*/

class tv.zarate.Utils.ArrayUtils{
	
	public static function randomizeArray(a:Array):Void{
		
		// Thanks to mr Steel for the quick googled solution:
		// http://mrsteel.wordpress.com/2007/06/15/randomize-array-shuffle-an-array-in-flash/
		
		var _length:Number = a.length, rn:Number, it:Number, el:Object;
		
		for (it=0;it<_length;it++){
			
			el = a[it];
			a[it] = a[rn = random(_length)];
			a[rn] = el;
			
		}
		
	}

}
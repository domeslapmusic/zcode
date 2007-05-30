/*
*
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
*
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*
*/

class tv.zarate.Utils.Trace{

	public static function trc(s:Object,type:String,reset:Boolean):Void{

		var sending_lc:LocalConnection = new LocalConnection();
		sending_lc.send("_ZLog","log",s,type,reset);
		sending_lc.close();

	}

}
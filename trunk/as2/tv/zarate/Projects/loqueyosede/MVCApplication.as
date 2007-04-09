/*
* 
* Zarate - http://www.zarate.tv
* cuentame@zarate.tv
* 
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
*/

import tv.zarate.Utils.Trace;

import tv.zarate.Projects.loqueyosede.Model;

class tv.zarate.Projects.loqueyosede.MVCApplication{
	
	public static function main(m:MovieClip):Void{
		
		Trace.trc("MVCApplication");

		var model:Model = new Model();
		model.config(m);
		model.start();

	}
	
}
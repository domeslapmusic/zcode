class tv.zarate.Utils.FlashVars{

	private var timeLine_mc:MovieClip;

	public function FlashVars(m:MovieClip){
		timeLine_mc = m;
	}

	public function getVar(varName:String):String{
		return timeLine_mc[varName];
	}

	public function initString(varName:String,currentVal:String):String{

		var fv:String = getVar(varName);
		return (fv != null)? fv:currentVal;

	}

	public function initNumber(varName:String,currentVal:Number):Number{

		var fv:String = getVar(varName);
		return (fv != null)? Number(fv):currentVal;

	}

	public function initBoolean(varName:String,currentVal:Boolean):Boolean{

		var fv:String = getVar(varName);
		return (fv != null)? ((fv == "true")? true:false):currentVal;

	}

}
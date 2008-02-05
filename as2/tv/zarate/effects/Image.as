import tv.zarate.Utils.Delegate;

class tv.zarate.effects.Image{

	public static function ChangeProperty(mc:MovieClip,property:String,to:Number,callback:Function,speed:Number):Void{
		
		if(speed == null){ speed = 3; }
		
		if(mc.smart_mc != null){
			
			delete mc.smart_mc.onEnterFrame;
			mc.smart_mc.removeMovieClip();
			
		}
		
		var d:Number = mc.getNextHighestDepth();
		var smart_mc:MovieClip;
		
		smart_mc = mc.createEmptyMovieClip("smart_"+d,d);
		mc.smart_mc = smart_mc;
		
		smart_mc.onEnterFrame = function():Void{
			
			mc[property] += (to - mc[property])/speed;
			
			var diff:Number = Math.abs(Math.abs(to) - Math.abs(mc[property]));
			
			if(diff <= 1){
				
				mc.smart_mc = null;
				delete this.onEnterFrame;
				this.removeMovieClip();
				if(callback != null){ callback(); }
				
			}
			
		}
		
	}
	
	public static function Fade(mc:MovieClip,to:Number,callback:Function,speed:Number):Void{
		ChangeProperty(mc,"_alpha",to,callback,speed);
	}
	
}
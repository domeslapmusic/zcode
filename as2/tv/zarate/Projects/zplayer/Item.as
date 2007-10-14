import tv.zarate.Projects.zplayer.Thumbnail;

class tv.zarate.Projects.zplayer.Item{

	public var thumbnail:Thumbnail;
	
	public var url:String = "";
	public var info:String = "";
	public var title:String = "";
	public var type:String = "";
	public var thumb:String = "";
	public var order:Number = -1;
	public var clip:MovieClip;

	public function Item(){}

	public function setXML(x:XMLNode):Void{}
	
	public function toString():String{ return ""; }

	public function enable():Void{
		thumbnail.enable();
	}
	
	public function disable():Void{
		thumbnail.disable();
	}
	
	// **************** PRIVATE METHODS ****************
	
	private function setThumb(path:String):Void{
		
		var ext:String = path.substr(path.lastIndexOf("."));
		thumb = path.substr(0,path.lastIndexOf(".")) + "_t" + ext;
		
	}
	
}
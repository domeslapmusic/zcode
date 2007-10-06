import tv.zarate.Projects.zplayer.Thumbnail;

class tv.zarate.Projects.zplayer.Item{

	public var url:String = "";
	public var info:String = "";
	public var title:String = "";
	public var type:String = "";
	public var thumb:String = "";
	public var order:Number = -1;
	public var clip:MovieClip;
	public var thumbnail:Thumbnail;

	public function Item(){}

	public function setXML(x:XMLNode):Void{}
	public function toString():String{ return ""; }

	public function enable():Void{
		thumbnail.enable();
	}
	
	public function disable():Void{
		thumbnail.disable();
	}
	
}
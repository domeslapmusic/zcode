class tv.zarate.Projects.zkino.Frame{
	
	public var path:String = "";
	public var delay:Number; // miliseconds
	
	public function Frame(_path:String,_delay:Number){
		
		path = _path;
		delay = _delay;
		
	}
	
	public function toString():String{
		
		return "[Frame path=" + path + ", delay=" + delay + "]";
		
	}
	
}
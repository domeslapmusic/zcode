import tv.zarate.Utils.Delegate;

class tv.zarate.Application.Config{

	private static var _instance:Config;

	public var dataXML:XML;

	public function loadXML(xmlPath:String,callback:Function):Void{
		
		if(xmlPath != ""){
			
			dataXML = new XML();
			dataXML.ignoreWhite = true;
			dataXML.onLoad = Delegate.create(this,xmlLoaded,callback);
			dataXML.load(xmlPath);
			
		} else {
			
			callback(true);
			
		}
		
	}

	public static function getInstance():Config{
		
		if(_instance == null){ _instance = new Config(); }
		return _instance;
		
	}

	// ******************** PRIVATE METHODS ********************

	private function Config(){}

	private function xmlLoaded(success:Boolean,callback:Function):Void{
		
		if(success){
			
			// do here whatever you might need before calling the callback
			// typically you would be parsing the xml file for data
			
			callback(true);
			
		} else {
			
			callback(false);
			
		}
		
	}
	
}
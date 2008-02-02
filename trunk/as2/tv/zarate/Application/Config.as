import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.FlashVars;

class tv.zarate.Application.Config{

	public var flashvars:FlashVars;
	public var dataXML:XML;
	
	public function Config(){}
	
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

	// ******************** PRIVATE METHODS ********************

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
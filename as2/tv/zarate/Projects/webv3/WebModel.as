import flash.external.ExternalInterface;

import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.Application.Model;

import tv.zarate.Projects.webv3.WebView;
import tv.zarate.Projects.webv3.WebConfig;
import tv.zarate.Projects.webv3.Section;

class tv.zarate.Projects.webv3.WebModel extends Model{
	
	public var currentSection:Section;
	
	private var view:WebView;
	private var conf:WebConfig;
	
	
	private var currentSection_id:String = "";
	
	private var FLASH_GATEWAY:String = "flashgateway";
	
	public function WebModel(){
		
		conf = new WebConfig();
		view = new WebView();
		
		super();
		
	}
	
	public function sendMail(txt:String,callback:Function):Void{
		
		var lv:LoadVars = new LoadVars();
		lv.action = "mail";
		lv.text = txt;
		lv.onLoad = Delegate.create(this,emailCallback,callback,lv);
		
		lv.sendAndLoad(FLASH_GATEWAY,lv,"POST");
		
	}
	
	public function changeLanguage(language_id:String):Void{
		
		var lv:LoadVars = new LoadVars();
		lv.action = "changelanguage";
		lv.language_id = language_id;
		lv.section_id = currentSection.section_id;
		lv.onLoad = Delegate.create(this,updateLanguageCallback,lv);
		
		lv.sendAndLoad(FLASH_GATEWAY,lv,"POST");
		
	}
	
	public function updateTitle(newtitle:String):Void{
		ExternalInterface.call("updatePageTitle",newtitle);
	}
	
	public static function main(m:MovieClip):Void{
		
		var instance:WebModel = new WebModel();
		instance.config(m);
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function frameworkReady():Void{
		
		currentSection = conf.initialSection;
		
	}
	
	private function emailCallback(success:Boolean,callback:Function,lv:LoadVars):Void{
		
		var actualSuccess:Boolean = (success && lv.success == "true")? true:false;
		callback(actualSuccess);
		
	}
	
	private function updateLanguageCallback(success:Boolean,lv:LoadVars):Void{
		
		var actualSuccess:Boolean = (success && lv.success == "true")? true:false;
		if(actualSuccess){ reload(); }
		
	}
	
	private function reload():Void{
		
		delete conf;
		conf = new WebConfig();
		
		initialize();
		
	}
	
}
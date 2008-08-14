/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
* 
*/

import flash.external.ExternalInterface;

import tv.zarate.utils.Delegate;
import tv.zarate.utils.MovieclipUtils;

import tv.zarate.application.Model;

import tv.zarate.projects.webv3.WebView;
import tv.zarate.projects.webv3.WebConfig;
import tv.zarate.projects.webv3.Section;
import tv.zarate.projects.webv3.Preload;

class tv.zarate.projects.webv3.WebModel extends Model{
	
	public var currentSection:Section;
	
	private var view:WebView;
	private var conf:WebConfig;
	private var xmlPreload:Preload;
	
	private var currentSection_id:String = "";
	
	private var FLASH_GATEWAY:String = "flashgateway";
	private var ZCODE_URL:String = "http://zarate.tv/proyectos/zcode/";
	private var HMTL_URL:String = "html/";
	
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
	
	public function forceHTMLVersion():Void{
		getURL(HMTL_URL);
	}
	
	public static function main(m:MovieClip):Void{
		
		var instance:WebModel = new WebModel();
		instance.config(m);
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function initialize():Void{
		
		super.initialize();
		createXMLPreload();
		
	}
	
	private function configReady(success:Boolean):Void{
		
		currentSection = conf.initialSection;
		super.configReady(success);
		
	}
	
	private function frameworkReady():Void{
		
		if(xmlPreload != null){
			
			xmlPreload.remove();
			xmlPreload = null;
			
		}
		
		var viewCode:ContextMenuItem = new ContextMenuItem("View source :)",Delegate.create(this,showSourceCode));
		rightClickMenu.addItem(viewCode);
		
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
	
	private function showSourceCode():Void{
		getURL(ZCODE_URL);
	}
	
	private function createXMLPreload():Void{
		
		if(xmlPreload == null){
			
			xmlPreload = new Preload(timeLine_mc.createEmptyMovieClip("preload_mc",1000),view.width,view.height,"data.",conf.dataXML);
			
		}
		
	}
	
}
/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
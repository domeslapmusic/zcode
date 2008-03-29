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

import tv.zarate.utils.Delegate;

class tv.zarate.projects.webv3.Preload{
	
	private var preloadField:TextField;
	private var preload_mc:MovieClip;
	private var base_mc:MovieClip;
	private var txt:String;
	
	public function Preload(_base_mc:MovieClip,w:Number,h:Number,_txt:String,xml:XML){
		
		base_mc = _base_mc;
		txt = _txt;
		
		if(xml != null){
			
			base_mc.onEnterFrame = Delegate.create(this,checkXML,xml);
			
		}
		
		initialLayout(w,h);
		layout(w,h);
		
	}
	
	public function remove():Void{
		
		delete base_mc.onEnterFrame;
		base_mc.removeMovieClip();
		
	}
	
	public function update(percent:Number):Void{
		updateField(percent);
	}
	
	public function setSize(w:Number,h:Number):Void{
		layout(w,h);
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function initialLayout(w:Number,h:Number):Void{
		
		preload_mc = base_mc.createEmptyMovieClip("preload_mc",200);
		
		preloadField = preload_mc.createTextField("field",100,0,0,0,0);
		preloadField.autoSize = "left";
		preloadField.setNewTextFormat(new TextFormat("Verdana",50,0xffffff));
		
		updateField(0);
		
	}
	
	private function updateField(percent:Number):Void{
		
		var p:Number = (isNaN(percent))? 0:percent;
		preloadField.text = txt + Math.round(p*100) + "%";
		
	}
	
	private function layout(w:Number,h:Number):Void{
		
		preload_mc._x = Math.round((w-preload_mc._width)/2);
		preload_mc._y = Math.round((h-preload_mc._height)/2);
		
	}
	
	private function checkXML(xml:XML):Void{
		update(xml.getBytesLoaded()/xml.getBytesTotal());
	}
	
}
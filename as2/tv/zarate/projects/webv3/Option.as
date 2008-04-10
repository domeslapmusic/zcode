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

import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.Delegate;

import tv.zarate.projects.webv3.WebConstants;

class tv.zarate.projects.webv3.Option{
	
	public var title:String = "";
	public var text:String = "";
	public var link:String = "";
	public var section_id:String = "";
	public var clip_mc:MovieClip;
	
	private var selectCallback:Function;
	private var selected:Boolean = false;
	
	public function Option(){}
	
	public function setXML(optionXML:XMLNode):Void{
		
		title = optionXML.childNodes[0].firstChild.nodeValue;
		text = optionXML.childNodes[1].firstChild.nodeValue;
		link = optionXML.childNodes[2].firstChild.nodeValue;
		
	}
	
	public function config(_clip_mc:MovieClip,_selectCallback:Function):Void{
		
		clip_mc = _clip_mc;
		selectCallback = _selectCallback;
		
		clip_mc.onPress = Delegate.create(this,manageOption,WebConstants.PRESS);
		clip_mc.onRollOver = Delegate.create(this,manageOption,WebConstants.OVER);
		clip_mc.onRollOut = Delegate.create(this,manageOption,WebConstants.OUT);
		
	}
	
	public function set enabled(val:Boolean):Void{
		clip_mc.enabled = val;
	}
	
	public function get enabled():Boolean{
		return clip_mc.enabled;
	}
	
	public function select(action:Boolean):Void{
		
		selected = action;
		
		if(!selected){
			
			manageOption(WebConstants.OUT,true);
			
		}
		
	}
	
	public function toString():String{
		return "Option [title=" +title + "]";
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function manageOption(action:String,force:Boolean):Void{
		
		switch(action){
			
			case WebConstants.PRESS:
				
				selected = true;
				selectCallback(this);
				
				break;
				
			case WebConstants.OVER:
				
				MovieclipUtils.changeColour(clip_mc,WebConstants.NICE_COLOR);
				break;
				
			case WebConstants.OUT:
				
				if(!selected || force){ MovieclipUtils.resetColour(clip_mc); }
				break;
			
		}
		
	}

	
}
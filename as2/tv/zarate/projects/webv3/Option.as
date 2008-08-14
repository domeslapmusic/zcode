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
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

import tv.zarate.utils.Delegate;
import tv.zarate.utils.MovieclipUtils;

class tv.zarate.projects.ZBooks.zbCheck{
	
	private var _selected:Boolean = false;
	private var base_mc:MovieClip;
	private var check_mc:MovieClip;
	private var selectedIcon:String = "check_selected";
	private var regularIcon:String = "check";
	private var mcTabIndex:Number;
	private var hadFocus:Boolean;
	
	public function zbCheck(mc:MovieClip){
		
		base_mc = mc;
		
		checkIcon();
		base_mc.onPress = Delegate.create(this,changeSelect);
		
		Key.addListener(this);
		
	}
	
	public function set tabIndex(val:Number):Void{
		
		mcTabIndex = val;
		check_mc.tabIndex = val
		
	}
	
	public function set selected(val:Boolean):Void{
		
		_selected = val;
		checkIcon();
		
	}
	
	public function get selected():Boolean{
		return _selected;
	}
	
	// private methods
	private function checkIcon():Void{
		
		check_mc = base_mc.attachMovie((_selected)? selectedIcon:regularIcon,"check_mc",100);
		check_mc.focusEnabled = true;
		
		tabIndex = mcTabIndex;
		if(hadFocus) Selection.setFocus(check_mc);
		
	}
	
	private function changeSelect():Void{
		
		_selected = !_selected;
		checkIcon();
		
	}
	
	private function onKeyUp():Void{
		
		hadFocus = MovieclipUtils.hasFocus(check_mc);
		
		if(Key.getCode() == Key.SPACE && hadFocus){
			
			changeSelect();
			
		}
		
	}
	
}
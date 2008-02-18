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
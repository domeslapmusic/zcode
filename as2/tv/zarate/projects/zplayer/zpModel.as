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
import tv.zarate.utils.Trace;

import tv.zarate.application.Model;

import tv.zarate.projects.zplayer.zpConfig;
import tv.zarate.projects.zplayer.zpView;
import tv.zarate.projects.zplayer.Item;

class tv.zarate.projects.zplayer.zpModel extends Model{

	public var items:/*Item*/Array;
	
	private var view:zpView;
	private var conf:zpConfig;
	private var currentItem:Item;

	private var timeLine_mc:MovieClip;
	private var view_mc:MovieClip;
	private var nextItemCallback:Function;
	private var totalItems:Number = 0;

	public function zpModel(){
		
		conf = new zpConfig();
		view = new zpView();
		
		super();
		
	}

	// **************** PRIVATE METHODS ****************

	private function frameworkReady():Void{
		
		nextItemCallback = Delegate.create(this,nextItem);
		
		items = conf.getItems();
		totalItems = items.length;
		
		var selectItemCallback:Function = Delegate.create(this,selectItem);
		
		view.zpConf(selectItemCallback);
		
		showItem(items[0]);
		
	}

	private function selectItem(item:Item):Void{
		
		showItem(item);
		
	}

	private function showItem(item:Item):Void{
		
		currentItem = item;
		view.showItem(item,nextItemCallback);
		
	}

	private function nextItem():Void{
		
		if(totalItems > 1){
			
			var i:Item = ((currentItem.order + 1) >= totalItems)? items[0]:items[currentItem.order+1];
			showItem(i);
			
		}
		
	}

}
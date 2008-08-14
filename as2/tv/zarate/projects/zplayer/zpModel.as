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
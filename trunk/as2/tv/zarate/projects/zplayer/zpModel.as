import tv.zarate.utils.Delegate;
import tv.zarate.utils.Trace;

import tv.zarate.application.Model;

import tv.zarate.projects.zplayer.zpConfig;
import tv.zarate.projects.zplayer.zpView;
import tv.zarate.projects.zplayer.Item;

class tv.zarate.projects.zplayer.zpModel extends Model{

	private var view:zpView;
	private var conf:zpConfig;
	private var currentItem:Item;

	private var items:/*Item*/Array;
	private var timeLine_mc:MovieClip;
	private var view_mc:MovieClip;
	private var nextItemCallback:Function;
	private var totalItems:Number = 0;

	public function zpModel(){
		
		conf = zpConfig.getInstance();
		
		super();
		
	}

	// **************** PRIVATE METHODS ****************

	private function frameworkReady():Void{
		
		nextItemCallback = Delegate.create(this,nextItem);
		
		items = conf.getItems();
		totalItems = items.length;
		
		var selectItemCallback:Function = Delegate.create(this,selectItem);
		
		view.conf(this,items,selectItemCallback);
		
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
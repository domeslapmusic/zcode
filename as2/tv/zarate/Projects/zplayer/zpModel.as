import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.Trace;

import tv.zarate.Projects.zplayer.zpConfig;
import tv.zarate.Projects.zplayer.zpView;
import tv.zarate.Projects.zplayer.Item;

class tv.zarate.Projects.zplayer.zpModel{

	private var view:zpView;
	private var config:zpConfig;
	private var currentItem:Item;

	private var items:/*Item*/Array;
	private var timeLine_mc:MovieClip;
	private var view_mc:MovieClip;
	private var nextItemCallback:Function;
	private var totalItems:Number = 0;

	public function zpModel(m:MovieClip){

		Trace.trc("ZPlayer up and running");

		Stage.scaleMode = "noScale";
		Stage.align = "TL";

		nextItemCallback = Delegate.create(this,nextItem);

		timeLine_mc = m;
		timeLine_mc.onEnterFrame = Delegate.create(this,waitForStage);

	}

	// **************** PRIVATE METHODS ****************

	private function waitForStage():Void{

		if(Stage.width != null && Stage.height != null){

			config = zpConfig.getInstance();
			config.config(timeLine_mc,Delegate.create(this,configReady));

			delete timeLine_mc.onEnterFrame;

		}

	}

	private function configReady(success:Boolean,_items:/*Item*/Array):Void{

		if(success){

			items = _items;
			totalItems = items.length;

			var selectItemCallback:Function = Delegate.create(this,selectItem);

			view_mc = timeLine_mc.createEmptyMovieClip("view_mc",100);
			view.conf(this,config,view_mc,items,selectItemCallback);
			view.start();

			showItem(items[0]);

		} else {

			trace("Couldn't initialize conf object :(");

		}

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
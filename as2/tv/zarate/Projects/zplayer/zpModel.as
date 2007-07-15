import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.Trace;

import tv.zarate.Projects.zplayer.zpConfig;
import tv.zarate.Projects.zplayer.zpView;
import tv.zarate.Projects.zplayer.Item;

class tv.zarate.Projects.zplayer.zpModel{

	private var view:zpView;
	private var config:zpConfig;

	private var items:/*Item*/Array;
	private var timeLine_mc:MovieClip;
	private var view_mc:MovieClip;

	public function zpModel(m:MovieClip){

		Trace.trc("ZPlayer up and running");

		Stage.scaleMode = "noScale";
		Stage.align = "TL";

		timeLine_mc = m;
		timeLine_mc.onEnterFrame = Delegate.create(this,waitForStage);

	}

	// **************** PRIVATE METHODS ****************

	private function waitForStage():Void{

		if(Stage.width != null && Stage.height != null){

			config = new zpConfig(timeLine_mc,Delegate.create(this,configReady));
			delete timeLine_mc.onEnterFrame;

		}

	}

	private function configReady(success:Boolean,_items:/*Item*/Array):Void{

		items = _items;

		if(success){

			var selectItemCallback:Function = Delegate.create(this,selectItem);

			view_mc = timeLine_mc.createEmptyMovieClip("view_mc",100);
			view.conf(this,config,view_mc,items,selectItemCallback);
			view.start();

			view.showItem(items[0]);

		} else {

			trace("Couldn't initialize conf object :(");

		}

	}

	private function selectItem(item:Item):Void{

		view.showItem(item);

	}

}
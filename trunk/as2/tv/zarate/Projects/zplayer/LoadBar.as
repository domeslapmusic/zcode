import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;

class tv.zarate.Projects.zplayer.LoadBar{

	public var onDrag:Function;

	private var bar_mc:MovieClip;
	private var base_mc:MovieClip;
	private var tracker_mc:MovieClip;

	private var height:Number = 10;
	private var border:Number = 1;
	private var maxWidth:Number = 0;
	private var maxTrackerPosition:Number = 0;
	private var updateTracker:Boolean = true;

	public function LoadBar(_base_mc:MovieClip,width:Number){

		base_mc = _base_mc;

		maxWidth = width - border * 2;

		var background_mc:MovieClip = base_mc.createEmptyMovieClip("background_mc",100);
		MovieclipUtils.DrawSquare(background_mc,0xffff00,100,width,height,border,0x000000,100);

		bar_mc = base_mc.createEmptyMovieClip("bar_mc",200);
		bar_mc._x = bar_mc._y = border;

		bar_mc.onPress = Delegate.create(this,barPressed);

		tracker_mc = base_mc.createEmptyMovieClip("tracker_mc",300);
		MovieclipUtils.DrawSquare(tracker_mc,0x00ff00,100,5,height);

		tracker_mc.onPress = Delegate.create(this,startDrag);
		tracker_mc.onRelease = tracker_mc.onReleaseOutside = Delegate.create(this,stopDrag);

		maxTrackerPosition = width - tracker_mc._width;

	}

	public function update(percent:Number):Void{

		// percent is a value between 0 and 1

		var w:Number = Math.round(maxWidth * percent);
		MovieclipUtils.DrawSquare(bar_mc,0xff0000,100,w,height-border*2);

	}

	public function updatePosition(percent:Number):Void{

		if(updateTracker){

			var pos:Number = Math.round(maxTrackerPosition * percent);
			tracker_mc._x = pos;

		}

	}

	public function remove():Void{
		base_mc.removeMovieClip();
	}

	// **************** PRIVATE METHODS ****************

	private function startDrag():Void{

		updateTracker = false;
		tracker_mc.startDrag(false,0,tracker_mc._y,bar_mc._width-tracker_mc._width,tracker_mc._y);

	}

	private function stopDrag():Void{

		tracker_mc.stopDrag();

		calculateOnDrag();

		updateTracker = true;

	}

	private function barPressed():Void{

		var localX:Number = MovieclipUtils.RootToLocal(bar_mc).x;

		tracker_mc._x = localX;

		calculateOnDrag();

	}

	private function calculateOnDrag():Void{

		var trackerPercentPosition:Number = tracker_mc._x/maxTrackerPosition;
		onDrag(trackerPercentPosition);

	}

}
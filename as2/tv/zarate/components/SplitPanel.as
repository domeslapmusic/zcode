import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.Delegate;

import tv.zarate.components.Common;

class tv.zarate.components.SplitPanel extends Common{

	private var content_mc:MovieClip;
	private var mask_mc:MovieClip;
	private var smart_mc:MovieClip;
	private var upArrow_mc:MovieClip;
	private var downArrow_mc:MovieClip;
	private var tracker_mc:MovieClip;

	private var panelHeight:Number = 0;
	private var maxSpeed:Number = 3;
	private var initSpeed:Number = 30;
	private var currentSpeed:Number = 0;
	private var destY:Number = 0;
	private var diff:Number = 0;
	private var trackerDiff:Number = 0;

	public function SplitPanel(m:MovieClip,speed:Number){

		super(m);

		if(speed != null){ initSpeed = speed; }
		currentSpeed = initSpeed;

	}

	public function setSize(w:Number,h:Number):Void{

		panelHeight = Math.round((h/2)*0.5);

		super.setSize(w,h);

	}

	public function remove():Void{

		super.remove();
		Mouse.removeListener(this);

	}

	public function getContentMC():MovieClip{

		return content_mc;

	}

	public function moveToClip(clip_mc:MovieClip):Void{

		currentSpeed = maxSpeed;

		var clipPos:Number = clip_mc._y + clip_mc._height + content_mc._y;

		if(clipPos > height || clipPos <= 0){

			if(clipPos > height){

				destY = - (clip_mc._y + clip_mc._height - height);

			} else {

				destY = - (clip_mc._y);

			}

			if(base_mc.onEnterFrame == null){ base_mc.onEnterFrame = Delegate.create(this,setContentPosition); }

		}

	}

	public function enable():Void{

		super.enable();
		upArrow_mc.enabled = downArrow_mc.enabled = true;

	}

	public function disable():Void{

		super.disable();
		upArrow_mc.enabled = downArrow_mc.enabled = false;

	}

	public function refreshScroll():Void{
		checkArrows();
	}

	// ************************ PRIVATE FUNCTIONS ************************

	private function doInitialLayout():Void{

		super.doInitialLayout();

		content_mc = base_mc.createEmptyMovieClip("content_mc",300);
		mask_mc = base_mc.createEmptyMovieClip("mask_mc",400);
		smart_mc = base_mc.createEmptyMovieClip("smart_mc",500);
		tracker_mc = base_mc.attachMovie("tracker","tracker_mc",900);

		upArrow_mc = base_mc.attachMovie("panelArrow","upArrow_mc",700);
		upArrow_mc._rotation = 180;

		downArrow_mc = base_mc.attachMovie("panelArrow","downArrow_mc",800);

		upArrow_mc.onRollOver = Delegate.create(this,activate,true,true);
		downArrow_mc.onRollOver = Delegate.create(this,activate,true,false);

		upArrow_mc.onRollOut = Delegate.create(this,activate,false,true);
		downArrow_mc.onRollOut = Delegate.create(this,activate,false,false);

	}

	private function layout():Void{

		super.layout();

		mask_mc.clear();

		MovieclipUtils.DrawSquare(mask_mc,0x000000,100,width,height);

		content_mc.setMask(mask_mc);

		upArrow_mc._x = width;
		upArrow_mc._y = upArrow_mc._height;

		downArrow_mc._x = width - upArrow_mc._width;

		downArrow_mc._y = height - downArrow_mc._height;

		trackerDiff = height - tracker_mc._height;

		tracker_mc._x = downArrow_mc._x + ((downArrow_mc._width-tracker_mc._width)/2);

		checkArrows();

	}

	private function activate(action:Boolean,top:Boolean):Void{

		diff = height - content_mc._height;

		if(action){

			destY = (top)? 0 : diff;

			currentSpeed = initSpeed;
			base_mc.onEnterFrame = Delegate.create(this,setContentPosition);

		} else {

			var mod:Number = 50;
			currentSpeed = maxSpeed;

			if(top == true){

				destY = (content_mc._y + mod < 0)? content_mc._y + mod : 0;

			} else {

				mod *= -1;
				destY = (content_mc._y + mod > diff)? content_mc._y + mod : diff;

			}

		}

	}

	private function setContentPosition():Void{

		content_mc._y += (destY - content_mc._y)/currentSpeed;
		tracker_mc._y += (getTrackerPosition() - tracker_mc._y)/currentSpeed;

		var absDist:Number = Math.abs(Math.abs(content_mc._y) - Math.abs(destY));

		if(currentSpeed > maxSpeed){ currentSpeed -= 2; }

		if(absDist <= 2){

			content_mc._y = Math.round(destY);
			tracker_mc._y = Math.round(getTrackerPosition());

			currentSpeed = initSpeed;

			delete base_mc.onEnterFrame;

		}

	}

	private function getTrackerPosition():Number{
		return Math.abs(trackerDiff * Math.abs(content_mc._y/diff));
	}

	private function needsScroll():Boolean{
		return (content_mc._height > height);
	}

	private function checkArrows():Void{
		upArrow_mc.enabled = downArrow_mc.enabled = needsScroll();
	}

}
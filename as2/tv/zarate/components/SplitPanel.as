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

import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.Delegate;

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
	private var buttonSize:Number = 50;

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

		tracker_mc = base_mc.createEmptyMovieClip("tracker_mc",900);
		MovieclipUtils.DrawSquare(tracker_mc,0xcecece,100,buttonSize/2,buttonSize/2);

		upArrow_mc = base_mc.createEmptyMovieClip("upArrow_mc",700);
		MovieclipUtils.DrawSquare(upArrow_mc,0x000000,100,buttonSize,buttonSize);

		downArrow_mc = base_mc.createEmptyMovieClip("downArrow_mc",800);
		MovieclipUtils.DrawSquare(downArrow_mc,0x000000,100,buttonSize,buttonSize);

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

		upArrow_mc._x = width - upArrow_mc._width;

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
		upArrow_mc._visible = downArrow_mc._visible = tracker_mc._visible = needsScroll();
	}

}
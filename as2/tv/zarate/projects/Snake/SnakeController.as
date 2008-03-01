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

import tv.zarate.Projects.Snake.SnakeModel;
import tv.zarate.Projects.Snake.SnakeView;
import tv.zarate.Projects.Snake.SnakeKeys;

class tv.zarate.Projects.Snake.SnakeController{

	private var view:SnakeView;
	private var model:SnakeModel;
	private var leftCursor:Number = 0;
	private var rightCursor:Number = 0;
	private var upCursor:Number = 0;
	private var downCursor:Number = 0;
	
	public function SnakeController(){
		
		Key.addListener(this);
		Stage.addListener(this);
		
		leftCursor = Key.LEFT;
		rightCursor = Key.RIGHT;
		upCursor = Key.UP;
		downCursor = Key.DOWN;
		
	}

	public function config(_model:SnakeModel,_view:SnakeView):Void{
		
		model = _model;
		view = _view;
		
		onResize();
		
	}

	public function modeSelected(type:String,showInstructions:Boolean,selectCallback:Function):Void{
		selectCallback(type,showInstructions);
	}
	
	/* ************************* PRIVATE METHODS ************************* */
	
	private function onKeyDown():Void{
		
		if(!view.playing){
			
			model.nextScreen();
			return;
			
		}
		
		switch(Key.getCode()){
			
			case(leftCursor):
				model.changeDir(-1,0);
				break;
			case(rightCursor):
				model.changeDir(1,0);
				break;
			case(upCursor):
				model.changeDir(0,-1);
				break;
			case(downCursor):
				model.changeDir(0,1);
				break;
			case(SnakeKeys.PAUSE):
			case(SnakeKeys.PAUSE2):
				model.pause();
				break;
			
		}
		
	}

	private function onResize():Void{
		view.setSize(Stage.width,Stage.height);
	}
	
}
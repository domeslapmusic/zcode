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
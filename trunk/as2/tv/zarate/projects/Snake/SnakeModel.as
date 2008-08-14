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

import tv.zarate.Projects.Snake.SnakeView;
import tv.zarate.Projects.Snake.SnakeData;
import tv.zarate.Projects.Snake.Worlds.*;
import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.Engine;

class tv.zarate.Projects.Snake.SnakeModel{

	private var view:SnakeView;
	private var world:SnakeWorld;
	private var beatInterval:Number = 0;
	private var beatTime:Number = 200;
	private var xDir:Number = 1;
	private var yDir:Number = 0;
	private var engine:Engine;
	private var divide:Number = 1;
	private var counter:Number = 0;
	private var toEngine:Function;
	private var nextCallback:Function;
	private var data:SnakeData;
	private var maxScore:Number = 0;
	private var paused:Boolean = true;
	
	public function SnakeModel(){
		
		engine = Engine.getInstance();
		toEngine = Delegate.create(this,updateWorld);
		data = new SnakeData();
		
	}

	public function config(_view:SnakeView,m:MovieClip):Void{
		
		view = _view;
		engine.config(m,500);
		
	}
	
	public function start():Void{
		data.getMaxScore(Delegate.create(this,scoreLoaded));
	}
	
	public function changeDir(_xDir:Number,_yDir:Number):Void{
		
		if(!paused){
			
			xDir = _xDir;
			yDir = _yDir;
			
		}
		
	}
	
	public function nextScreen():Void{
		
		nextCallback();
		
	}
	
	public function pause():Void{
		
		// you are not going to stop it after maxScore, coward!
		if(world.score < maxScore) manageEngine(paused);
		
	}
	
	/* ************************* PRIVATE METHODS ************************* */
	
	private function scoreLoaded(success:Boolean,score:Number):Void{
		
		if(success){
			
			// when thousands of developers make more and more engines
			// we could get this from xml, db or whatever
			
			var modes:Array = new Array();
			modes.push(
					{title:"Classic Mode",
					description:"This is a good one to start with... by the way.... po-po-po!",
					value:"classic"},
					{title:"Panic Mode",
					description:"Yeah! :D",
					value:"panic"}
					);
			
			if(score != undefined){
				
				maxScore = score;
				view.maxScore = score;
				
			}
			
			view.drawInitialScreen(modes,Delegate.create(this,setEngine),Delegate.create(this,changeKeys));
			
		} else {
			
			trace("Impossible to load previous score");
			// TODO, display properly in the view
			
		}
		
	}
	
	private function setEngine(engineType:String,showInstructions:Boolean):Void{
		
		// yes, probably one nice design pattern would do a better job here,
		// but we will wait to those thousands of developers
		
		switch(engineType){
			
			case("classic"):
				world = Classic.getInstance();
				break;
			case("panic"):
				world = Panic.getInstance();
				break;
			
		}
		
		if(showInstructions){
			
			view.showInstructionsScreen(world.instructions,Delegate.create(this,configWorld),Delegate.create(this,scoreLoaded,true));
			
		} else{
			
			configWorld();
			
		}
		
		
	}
	
	private function changeKeys():Void{
		
		view.drawChangeKeysScreen();
		
	}
	
	private function configWorld():Void{
		
		xDir = 1;
		yDir = 0;
		
		world.config(Delegate.create(this,gameOver));
		world.initWorld();
		
		view.gameOver = false;
		view.drawPlayingScreen(world.width,world.height);
		view.drawWorld(world);
		
		manageEngine(true);
		
	}
	
	private function manageEngine(action:Boolean):Void{
		
		if(action){
			engine.addListener(toEngine);
		} else {
			engine.removeListener(toEngine);
		}
		
		paused = !action;
		
	}
	
	private function updateWorld():Void{
		
		counter++;
		
		if((counter % divide) == 0){
			
			counter = 0;
			world.update(xDir,yDir);
			view.drawWorld(world);
			
		}
		
	}
	
	private function gameOver(userScore:Number):Void{
		
		manageEngine(false);
		view.gameOver = true;
		
		if(userScore > maxScore){
			
			maxScore = userScore;
			view.maxScore = userScore;
			data.setMaxScore(userScore,Delegate.create(this,updateMaxScore));
			
		} else {
			
			updateMaxScore();
			
		}
		
	}
	
	private function updateMaxScore(success:Boolean,newMaxScore:Number,maxScoreDate:Date):Void{
		
		view.drawGameOverScreen(world.score,newMaxScore,maxScoreDate,Delegate.create(this,configWorld));
		nextCallback = Delegate.create(this,configWorld);
		
	}
	
}
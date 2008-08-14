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

import tv.zarate.Projects.Snake.Worlds.SnakeFloor;

class tv.zarate.Projects.Snake.Worlds.SnakeWorld{
	
	public var width:Number = 10;
	public var height:Number = 10;
	public var score:Number = 0;
	public var instructions:String = "Play!";

	private static var _instance:SnakeWorld = null;
	private var world:Array;	
	private var snake:Array;
	private var currentX:Number = 0;
	private var currentY:Number = 0;
	private var snakeInitLength:Number = 3;
	private var gameOverCallback:Function;
	private var scoreDelta:Number = 5;
	private var randomLeft:Number = 0;
	private var floorVoid:Number = 0;
	
	
	private function SnakeWorld(){}

	public static function getInstance():SnakeWorld{
		
		if(_instance == null) _instance = new SnakeWorld();
		return _instance;
		
	}
	
	public function config(_gameOverCallback:Function):Void{
		
		gameOverCallback = _gameOverCallback;
		score = 0;
		
		world = new Array();
		snake = new Array();
		
	}
	
	public function getSquare(x:Number,y:Number):SnakeFloor{
		return world[x][y];
	}
	
	public function getFloorColour(type:Number):Number{ return 0x000000; }
	public function initWorld():Void{}
	public function update(xDir:Number,yDir:Number):Void{}
	
	/* ************************* PRIVATE METHODS ************************* */
	
	private function updateScore(action:Boolean,delta:Number):Void{
		
		var mod:Number = (action == null || action == true)? 1:-1;
		var step:Number = (delta != null)? delta:scoreDelta;
		
		//trace("delta > " + step + " --- " + delta);
		
		score += step*mod;
		
	}
	
	private function setSquare(x:Number,y:Number,type:Number):Void{
		
		var square:SnakeFloor = new SnakeFloor(x,y);
		square.type = type;
		
		world[x][y] = square;
		
	}
	
	private function setRandomType(type:Number,totalRandom:Number,_randomFloor:Array):Array{
		
		var randX:Number = random(width);
		var randY:Number = random(height);
		var randomFloor:Array = (_randomFloor != null)? _randomFloor:new Array();
		
		if(totalRandom != null) randomLeft = totalRandom;
		
		if(getSquare(randX,randY).type == floorVoid){
			
			var currentFloor:SnakeFloor = getSquare(randX,randY);
			
			currentFloor.type = type;
			randomFloor.push(currentFloor);
			randomLeft--;
			if(randomLeft > 0) setRandomType(type,null,randomFloor);
			
		} else {
			
			setRandomType(type,null,randomFloor);
			
		}
		
		return randomFloor;
		
	}
	
	private function doGameOver():Void{
		gameOverCallback(score);
	}
	
}
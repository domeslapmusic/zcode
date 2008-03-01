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
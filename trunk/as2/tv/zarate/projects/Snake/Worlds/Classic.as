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
import tv.zarate.Projects.Snake.Worlds.SnakeWorld;
import tv.zarate.Projects.Snake.Worlds.iWorld;

class tv.zarate.Projects.Snake.Worlds.Classic extends SnakeWorld implements iWorld{
	
	private static var _instance:Classic = null;
	private var floorFood:Number = 1;
	private var floorSnake:Number = 2;
	private var voidColor:Number = 0xdedede;
	private var foodColor:Number = 0xff00ff;
	private var snakeColor:Number = 0x000000;
	private var colours:Array;
	
	private function Classic(){
		
		super();
		
		colours = new Array();
		colours[0] = voidColor;
		colours[1] = foodColor;
		colours[2] = snakeColor;
		
		instructions = "Welcome to the classic mode!\n\nThis is the most simple Snake mode, and it´s how I learnt to play in my Nokia 3210.\n\nThe rules are quite basic, just try to catch as much food as you can.\n\nEnjoy!";
		
	}
	
	public static function getInstance():Classic{
		
		if(_instance == null) _instance = new Classic();
		return _instance;
		
	}
	
	public function initWorld():Void{
		
		for(var x:Number=0;x<width;x++){
			
			world[x] = new Array();
			
			for(var y:Number=0;y<height;y++) setSquare(x,y,floorVoid);
			
		}
		
		var initSnakeX:Number = 5;
		var initSnakeY:Number = 0;
		
		for(var x:Number=0;x<snakeInitLength;x++){
			
			var square:SnakeFloor = getSquare(initSnakeX,initSnakeY)
			
			square.type = floorSnake;
			snake.push(square);
			
			initSnakeX--;
			
		}
		
		currentX = initSnakeX+snakeInitLength;
		currentY = initSnakeY;
		
		setRandomType(floorFood,1);
		
	}
	
	public function update(xDir:Number,yDir:Number):Void{
		
		currentX += xDir;
		currentY += yDir;
		
		if(currentX >= width || currentX < 0 || currentY >= height || currentY < 0 ){
			
			gameOverCallback();
			
		} else {
			
			var square:SnakeFloor = world[currentX][currentY];
			
			switch(square.type){
				
				case(floorFood):
					
					var nextMove:SnakeFloor = getSquare(currentX,currentY);
					nextMove.type = floorSnake;
					
					snake.splice(0,0,nextMove);
					
					setRandomType(floorFood,1);
					updateScore(true);
					
					break;
					
				case(floorSnake):
					
					gameOverCallback();
					break;
					
				default:
					
					var nextMove:SnakeFloor = getSquare(currentX,currentY);
					nextMove.type = floorSnake;
					
					var last:SnakeFloor = snake[snake.length-1];
					last.type = floorVoid;
					
					snake.pop();
					snake.splice(0,0,nextMove);
					
					break;
				
			}
			
		}
		
	}
	
	public function getFloorColour(type:Number):Number{
		return colours[type];
	}
	
	/* ************************* PRIVATE METHODS ************************* */
	
}
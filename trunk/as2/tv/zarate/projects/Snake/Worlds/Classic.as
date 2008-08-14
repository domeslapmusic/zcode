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
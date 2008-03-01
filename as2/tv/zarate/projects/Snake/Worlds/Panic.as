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
import tv.zarate.Projects.Snake.SnakeKeys;
import tv.zarate.Utils.Delegate;

class tv.zarate.Projects.Snake.Worlds.Panic extends SnakeWorld implements iWorld{
	
	private static var _instance:Panic = null;
	private var floorFood:Number = 1;
	private var floorSnake:Number = 2;
	private var floorNoFloor:Number = 3;
	private var floorSuperFood:Number = 4;
	private var floorStillFood:Number = 5;
	
	private var voidColor:Number = 0xdedede;
	private var foodColor:Number = 0xff00ff;
	private var snakeColor:Number = 0x000000;
	private var noFloorColor:Number = 0xffffff;
	private var superFoodColor:Number = 0xffff00;
	private var stillFoodColor:Number = 0xff0000;
	
	private var colours:Array;
	private var firstMove:Boolean = true;
	private var maxLine:Number = 0;
	private var randomFunctions:Array;
	private var noFloor:Boolean = false;
	private var noFloorSquares:Array;
	private var currentFood:Array;
	private var initFoodNumber:Number = 4;
	private var randomFactor:Number = 0.1;
	
	private function Panic(){
		
		super();
		
		colours = new Array();
		colours[floorSnake] = snakeColor;
		colours[floorNoFloor] = noFloorColor;
		colours[floorSuperFood] = superFoodColor;
		colours[floorStillFood] = stillFoodColor;
		
		changeColours(true);
		
		snakeInitLength = 5;
		maxLine = Math.max(width,height);
		
		randomFunctions = new Array();
		
		randomFunctions.push(
			Delegate.create(this,setNoFloor),
			Delegate.create(this,changeFoodNumber),
			Delegate.create(this,changeColours),
			Delegate.create(this,superFood),
			Delegate.create(this,cutSnake),
			Delegate.create(this,setStillFood)
			);
		
		Key.addListener(this);
		
	}
	
	public static function getInstance():Panic{
		
		if(_instance == null) _instance = new Panic();
		return _instance;
		
	}
	
	public function initWorld():Void{
		
		firstMove = true;
		noFloor = false;
		width = 11;
		height = 11;
		changeColours(true);
		
		manageKeyListener(true);
		
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
		
		setSquare(0,0,floorNoFloor);
		setSquare(0,height-1,floorNoFloor);
		setSquare(width-1,height-1,floorNoFloor);
		setSquare(width-1,0,floorNoFloor);
		
		currentX = initSnakeX+snakeInitLength;
		currentY = initSnakeY;
		
		currentFood = setRandomType(floorFood,initFoodNumber);
		
	}
	
	public function update(xDir:Number,yDir:Number):Void{
		
		currentX += xDir;
		currentY += yDir;
		
		if(currentX >= width || currentX < 0 || currentY >= height || currentY < 0 ){
			
			doGameOver();
			
		} else {
			
			var square:SnakeFloor = world[currentX][currentY];
			
			switch(square.type){
				
				case(floorSuperFood):
				case(floorFood):
					
					var scoreDelta:Number = (square.type == floorSuperFood)? 50:null;
					
					var nextMove:SnakeFloor = getSquare(currentX,currentY);
					nextMove.type = floorSnake;
					
					snake.splice(0,0,nextMove);
					
					var newFood:SnakeFloor = setRandomType(floorFood,1)[0];
					
					replaceFood(nextMove,newFood);
					
					updateScore(true,scoreDelta);
					
					if(randomThing()) doRandom();
					
					break;
					
				case(floorNoFloor):
				case(floorSnake):
					
					doGameOver();
					break;
					
				case(floorStillFood):
					
					updateScore(true);
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
		
		if(!firstMove){ // trying to win a little bit of performance!
			
			if(snake.length <= maxLine){
				
				if(inLine()) doGameOver();
				
			}
			
		}
		
	}
	
	public function getFloorColour(type:Number):Number{
		return colours[type];
	}
	
	/* ************************* PRIVATE METHODS ************************* */
	
	private function randomThing():Boolean{
		return (Math.random() < randomFactor);
	}
	
	private function doRandom():Void{
		
		var randomFunction:Function = randomFunctions[random(randomFunctions.length)];
		randomFunction();
		
	}
	
	private function inLine():Boolean{
		
		var lineHorizontal:Boolean = true;
		var lineVertical:Boolean = true;
		var curX:Number = snake[0].x;
		var curY:Number = snake[0].y;
		
		for(var i:String in snake){
			
			if(lineVertical){
				
				lineVertical = (curX == snake[i].x);
				curX = snake[i].x;
				
			}
			
			if(lineHorizontal){
				
				lineHorizontal = (curY == snake[i].y);
				curY = snake[i].y;
				
			}
			
		}
		
		return (lineHorizontal || lineVertical);
		
	}
	
	private function manageKeyListener(action:Boolean):Void{
		
		if(action){
			Key.addListener(this);
		} else {
			Key.removeListener(this);
		}
		
	}
	
	private function onKeyDown():Void{
		
		if(firstMove && Key.getCode() != SnakeKeys.PAUSE && Key.getCode() != SnakeKeys.PAUSE2){
			
			firstMove = false;
			manageKeyListener(false);
			
		}
		
	}
	
	private function replaceFood(prev:SnakeFloor,current:SnakeFloor):Void{
		
		var lng:Number = currentFood.length;
		for(var x:Number=0;x<lng;x++){
			if(currentFood[x].x == prev.x && currentFood[x].y == prev.y) currentFood.splice(x,1,current);
		}
		
	}
	
	/* random tricks */
	
	private function setNoFloor():Void{
		
		if(!noFloor){
			noFloorSquares = setRandomType(floorNoFloor,2);
		} else {
			for(var x:String in noFloorSquares) noFloorSquares[x].type = floorVoid;
		}
		
		noFloor = !noFloor;
		
	}
	
	private function changeFoodNumber():Void{
		
		if(currentFood.length == initFoodNumber){
			
			var lng:Number = currentFood.length;
			for(var x:Number=1;x<lng;x++) currentFood[x].type = floorVoid;
			currentFood.splice(1);
			
		} else {
			
			currentFood[0].type = floorVoid;
			currentFood = setRandomType(floorFood,initFoodNumber);
			
		}
		
	}
	
	private function changeColours(action:Boolean):Void{
		
		if(colours[0] == foodColor || action == true){
			
			colours[0] = voidColor;
			colours[1] = foodColor;
			
		} else {
			
			colours[0] = foodColor;
			colours[1] = voidColor;
			
		}
		
	}
	
	private function superFood():Void{
		
		if(Math.random() < 0.5){
			
			var superFoodSquare:SnakeFloor = currentFood[random(currentFood.length)];
			superFoodSquare.type = floorSuperFood;
			
		}
		
	}
	
	private function cutSnake():Void{
		
		firstMove = true;
		for(var x:Number=1;x<snake.length;x++) snake[x].type = floorVoid;
		snake.splice(1);
		
	}

	private function setStillFood():Void{
		if(Math.random() < 0.5) setRandomType(floorStillFood,1);
	}
	
}
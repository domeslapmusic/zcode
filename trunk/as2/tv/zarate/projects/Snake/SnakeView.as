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

import tv.zarate.Projects.Snake.SnakeController;
import tv.zarate.Projects.Snake.Worlds.*;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.TextfieldUtils;

class tv.zarate.Projects.Snake.SnakeView{

	public var gameOver:Boolean = false;
	public var playing:Boolean = false;
	public var maxScore:Number = 0;
	
	private var controller:SnakeController;
	private var timeLine_mc:MovieClip;
	private var screen_mc:MovieClip;
	
	private var appWidth:Number = 300;
	private var appHeight:Number = 300;
	private var cellWidth:Number = 20;
	private var cellHeight:Number = 20;
	private var mainMargin:Number = 10;
	private var scoreField:TextField;
	
	// depths
	private var SCREENDEPTH:Number = 100;
	
	public function SnakeView(){}

	public function config(_controller:SnakeController,mc:MovieClip):Void{
		
		controller = _controller;
		timeLine_mc = mc;
		
	}
	
	public function drawInitialScreen(modes:Array,selectCallback:Function,changeKeysCallback:Function):Void{
		
		resetScreen();
		
		var margin:Number = 5;
		var fieldWidth:Number = appWidth-(mainMargin*2);
		var nextY:Number = 0;
		
		var title_mc:MovieClip = screen_mc.createEmptyMovieClip("title_mc",100);
		title_mc._x = title_mc._y = mainMargin;
		
		title_mc.createTextField("field",100,0,0,0,0);
		var field:TextField = title_mc.field;
		field.autoSize = true;
		field.text = "Welcome to Zárate Snake!";
		field.setTextFormat(getFormat("title"));
		
		var intro_mc:MovieClip = screen_mc.createEmptyMovieClip("intro_mc",200);
		intro_mc._x = title_mc._x;
		intro_mc._y = title_mc._y + title_mc._height + margin;
		
		intro_mc.createTextField("field",100,0,0,fieldWidth,10);
		field = intro_mc.field;
		field.autoSize = true;
		field.wordWrap = true;
		field.multiline = true;
		field.text = "Use arrow keys to control Snake, P or SPACE to pause game.\n\nPlease, select your favourite game mode:";
		field.setTextFormat(getFormat(""));
		
		// modes
		var modes_mc:MovieClip = screen_mc.createEmptyMovieClip("modes_mc",300);
		modes_mc._x = title_mc._x;
		modes_mc._y = intro_mc._y + intro_mc._height + (margin*2);
		
		var lng:Number = modes.length;
		for(var x:Number=0;x<lng;x++){
			
			var title:String = modes[x].title;
			var description:String = modes[x].description;
			var type:String = modes[x].value;
			
			var mode_mc:MovieClip = modes_mc.createEmptyMovieClip("mode_"+x,100+x);
			
			var modeIntro_mc:MovieClip = mode_mc.createEmptyMovieClip("modeIntro_mc",100);
			modeIntro_mc.createTextField("field",100,0,0,fieldWidth,10);
			field = modeIntro_mc.field;
			
			field.autoSize = true;
			field.wordWrap = true;
			field.multiline = true;
			field.text = title + ": " + description;
			field.setTextFormat(getFormat(""));
			field.setTextFormat(0,title.length,getFormat("title"));
			
			modeIntro_mc.onPress = Delegate.create(controller,controller.modeSelected,type,false,selectCallback);
			
			var instructions_mc:MovieClip = mode_mc.createEmptyMovieClip("instructions_mc",200);
			
			instructions_mc.createTextField("field",100,0,0,0,0);
			field = instructions_mc.field;
			
			field.autoSize = "right";
			field.text = "Instructions";
			field.setTextFormat(getFormat("title"));
			
			instructions_mc._x = fieldWidth;
			instructions_mc._y = modeIntro_mc._y + modeIntro_mc._height + margin;
			
			instructions_mc.onPress = Delegate.create(controller,controller.modeSelected,type,true,selectCallback);
			
			mode_mc._y = nextY;
			nextY += mode_mc._height + margin;
			
		}
		
		var changekeys_mc:MovieClip = screen_mc.createEmptyMovieClip("changekeys_mc",400);
		changekeys_mc._x = title_mc._x;
		changekeys_mc._y = modes_mc._y + modes_mc._height + mainMargin;
		
		changekeys_mc.createTextField("field",100,0,0,0,0);
		field = changekeys_mc.field;
		field.autoSize = true;
		field.text = "Change keys";
		field.setTextFormat(getFormat(""));
		
		changekeys_mc.onPress = changeKeysCallback;
		
	}
	
	public function showInstructionsScreen(instructions:String,playCallback:Function,anotherCallback:Function):Void{
		
		resetScreen();
		
		var fieldWidth:Number = appWidth-(mainMargin*2);
		
		var instructions_mc:MovieClip = screen_mc.createEmptyMovieClip("instructions_mc",100);
		instructions_mc._x = instructions_mc._y = mainMargin;
		
		instructions_mc.createTextField("field",100,0,0,fieldWidth,10);
		var field:TextField = instructions_mc.field;
		field.autoSize = true;
		field.wordWrap = true;
		field.multiline = true;
		field.text = instructions;
		field.setTextFormat(getFormat(""));
		
		var buttons_mc:MovieClip = screen_mc.createEmptyMovieClip("buttons_mc",200);
		
		var play_mc:MovieClip = buttons_mc.createEmptyMovieClip("play_mc",100);
		
		play_mc.createTextField("field",100,0,0,0,0);
		field = play_mc.field;
		field.autoSize = true;
		field.text = "Play";
		field.setTextFormat(getFormat("title"));
		
		play_mc.onPress = playCallback;
		
		var another_mc:MovieClip = buttons_mc.createEmptyMovieClip("another_mc",200);
		another_mc._x = play_mc._x + play_mc._width + mainMargin;
		
		another_mc.createTextField("field",100,0,0,0,0);
		field = another_mc.field;
		field.autoSize = true;
		field.text = "Choose another mode";
		field.setTextFormat(getFormat("title"));
		
		another_mc.onPress = anotherCallback;
		
		buttons_mc._x = Math.round((appWidth-buttons_mc._width)/2);
		buttons_mc._y = instructions_mc._y + instructions_mc._height + mainMargin;
		
	}
	
	public function drawChangeKeysScreen():Void{
		
		resetScreen();
		
		var fieldWidth:Number = appWidth-(mainMargin*2);
		
		var instructions_mc:MovieClip = screen_mc.createEmptyMovieClip("instructions_mc",100);
		instructions_mc._x = instructions_mc._y = mainMargin;
		
		var field:TextField = TextfieldUtils.createField(instructions_mc,fieldWidth,10);
		field.text = "Select the keys you want and click save. Cancel to go back.";
		field.setTextFormat(getFormat(""));
		
		var left_mc:MovieClip = screen_mc.createEmptyMovieClip("left_mc",200);
		left_mc._x = mainMargin;
		left_mc._y = instructions_mc._y + instructions_mc._height + mainMargin;
		
		createKeyFields(left_mc,"Left:");
		
		
		/*
		var left_mc:MovieClip = screen_mc.createEmptyMovieClip("left_mc",200);
		left_mc._x = mainMargin;
		left_mc._y = instructions_mc._y + instructions_mc._height + mainMargin;
		
		field = TextfieldUtils.createField(left_mc);
		field.text = "Left:";
		field.setTextFormat(getFormat("title"));
		
		var leftInput_mc:MovieClip = screen_mc.createEmptyMovieClip("leftInput_mc",300);
		leftInput_mc._x = left_mc._x + left_mc._width + mainMargin;
		leftInput_mc._y = left_mc._y;
		
		field = TextfieldUtils.createInputField(leftInput_mc,30,left_mc._height);
		field.border = true;
		field.maxChars = 1;
		field.setNewTextFormat(getFormat(""));
		*/
		
	}
	
	public function drawPlayingScreen(worldWidth:Number,worldHeight:Number):Void{
		
		resetScreen();
		
		playing = true;
		
		var score_mc:MovieClip = screen_mc.createEmptyMovieClip("score_mc",200);
		score_mc._x = appWidth - 5;
		score_mc._y = 2;
		
		score_mc.createTextField("field",100,0,0,0,0);
		
		scoreField = score_mc.field;
		scoreField.autoSize = "right"
		scoreField.text = "";
		scoreField.setNewTextFormat(getFormat(""));
		
		calculateSquareDimensions(worldWidth,worldHeight);
		
	}
	
	public function drawWorld(world:SnakeWorld):Void{
		
		if(gameOver) return;
		
		var cells_mc:MovieClip = screen_mc.createEmptyMovieClip("cells_mc",1000);
		
		var counter:Number = 0;
		var width:Number = world.width;
		var height:Number = world.height;
		var iniX:Number = 0;
		var iniY:Number = 0;
		var nextX:Number = iniX;
		var nextY:Number = iniY;
		var cell_mc:MovieClip;
		var margin:Number = 1;
		
		for(var x:Number=0;x<width;x++){
			
			for(var y:Number=0;y<height;y++){
				
				var square:SnakeFloor = world.getSquare(x,y);
				cell_mc = cells_mc.createEmptyMovieClip("cell_"+x+"_"+y,100+counter);
				
				drawCell(cell_mc,world.getFloorColour(square.type));
				
				cell_mc._x = nextX;
				cell_mc._y = nextY;
				
				nextY += cell_mc._height + margin;
				
				counter++;
				
			}
			
			nextY = iniY;
			nextX += cell_mc._width + margin;
			
		}
		
		cells_mc._x = Math.round((appWidth-cells_mc._width)/2);
		cells_mc._y = Math.round((appHeight-cells_mc._height)/2);
		
		updateScore(world.score);
		
	}
	
	public function drawGameOverScreen(score:Number,maxScore:Number,maxScoreDate:Date,startAgainCallback:Function):Void{
		
		resetScreen();
		
		playing = false;
		
		var score_mc:MovieClip = screen_mc.createEmptyMovieClip("score_mc",200);
		
		score_mc.createTextField("field",100,0,0,0,0);
		var field:TextField = score_mc.field;
		field.autoSize = "center"
		field.text = "" + score;
		field.setTextFormat(getFormat("scoreGameOver"));
		
		score_mc._x = Math.round((appWidth-score_mc._width)/2);
		score_mc._y = 100;
		
		//back_mc.onPress = startAgainCallback;
		
	}
	
	public function setSize(w:Number,h:Number):Void{
		
		appWidth = w;
		appHeight = h;
		
	}
	
	/* ************************* PRIVATE METHODS ************************* */
	
	private function updateScore(score:Number):Void{
		
		scoreField.text = "Score: " + (score - maxScore);
		if(score >= maxScore) scoreField.setNewTextFormat(getFormat("maxScore"));
		
	}
	
	private function resetScreen():Void{
		
		if(screen_mc != undefined) screen_mc.removeMovieClip();
		screen_mc = timeLine_mc.createEmptyMovieClip("screen_mc",SCREENDEPTH);
		
		var back_mc:MovieClip = screen_mc.createEmptyMovieClip("back_mc",50);
		MovieclipUtils.DrawSquare(back_mc,0xffffff,100,appWidth,appHeight);
		
	}
	
	private function drawCell(mc:MovieClip,colour:Number):Void{
		
		var background_mc:MovieClip = mc.createEmptyMovieClip("background_mc",100);
		
		background_mc.beginFill(colour,100);
		background_mc.lineTo(0,cellHeight);
		background_mc.lineTo(cellWidth,cellHeight);
		background_mc.lineTo(cellWidth,0);
		background_mc.lineTo(0,0);
		background_mc.endFill();
		
	}
	
	private function calculateSquareDimensions(worldWidth:Number,worldHeight:Number):Void{
		
		cellWidth = Math.round((appWidth-(mainMargin*2))/worldWidth);
		cellHeight = Math.round((appHeight-(mainMargin*2)-(scoreField._y + scoreField._height))/worldHeight);
		
		esto no rula
		
		trace("Pa mi que no llo sabe > " + scoreField + " ---  " + scoreField._y + " -- " + scoreField._height);
		
	}
	
	private function createKeyFields(mc:MovieClip,title:String):Void{
		
		var title_mc:MovieClip = mc.createEmptyMovieClip("title_mc",100);
		
		var field:TextField = TextfieldUtils.createField(title_mc);
		field.text = title;
		field.setTextFormat(getFormat("title"));
		
		var input_mc:MovieClip = screen_mc.createEmptyMovieClip("input_mc",200);
		input_mc._x = title_mc._x + title_mc._width + mainMargin;
		input_mc._y = title_mc._y;
		
		field = TextfieldUtils.createInputField(input_mc,30,title_mc._height);
		field.border = true;
		field.maxChars = 1;
		field.setNewTextFormat(getFormat(""));
		
	}
	
	private function getFormat(type:String):TextFormat{
		
		var format:TextFormat = new TextFormat();
		
		switch(type){
			
			case("maxScore"):
				format.font = "Verdana"; format.size = 10; format.bold = true; format.color = 0xff0000; break;
			case("scoreGameOver"):
				format.font = "Verdana"; format.size = 18; format.bold = true; break;
			case("title"):
				format.font = "Verdana"; format.size = 10; format.bold = true; break;
			default:
				format.font = "Verdana"; format.size = 10; break;
			
		}
		
		return format;
		
	}
	
}
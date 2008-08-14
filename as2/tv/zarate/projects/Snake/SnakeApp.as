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

import tv.zarate.Utils.Trace;
import tv.zarate.Projects.Snake.SnakeModel;
import tv.zarate.Projects.Snake.SnakeView;
import tv.zarate.Projects.Snake.SnakeController;

class tv.zarate.Projects.Snake.SnakeApp{
	
	public static function main(m:MovieClip):Void{
		
		Trace.trc("SnakeApp","",true);
		
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		
		var model:SnakeModel = new SnakeModel();
		var view:SnakeView = new SnakeView();
		var controller:SnakeController = new SnakeController();
		
		model.config(view,m);
		view.config(controller,m.createEmptyMovieClip("view_mc",100));
		controller.config(model,view);
		
		model.start();
		
	}

}
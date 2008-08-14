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

import tv.zarate.utils.Trace;
import tv.zarate.projects.ZBooks.zbModel;
import tv.zarate.projects.ZBooks.zbView;
import tv.zarate.projects.ZBooks.zbController;

class tv.zarate.projects.ZBooks.zbApp{
	
	public static function main(m:MovieClip):Void{
		
		Trace.trc("ZBooks App")
		
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var model:zbModel = new zbModel();
		var view:zbView = new zbView();
		var controller:zbController = new zbController();
		
		model.config(view,m);
		view.config(model,controller,m);
		controller.config(model,view);
		
		model.start();
		
	}

	public static function trc(s:String,type:String,reset:Boolean):Void{
		Trace.trc(s,type,reset);
	}

}
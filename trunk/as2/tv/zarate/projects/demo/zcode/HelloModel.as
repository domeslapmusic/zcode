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

import tv.zarate.application.Model;

import tv.zarate.projects.demo.zcode.HelloView;
import tv.zarate.projects.demo.zcode.HelloConfig;

class tv.zarate.projects.demo.zcode.HelloModel extends Model{

	private var view:HelloView;
	private var conf:HelloConfig;

	public function HelloModel(){
		
		// You have to create the instances of
		// your view and configuration object.
		
		// Remember that defining you own configuration
		// object is optional, although recommended
		
		view = new HelloView();
		conf = new HelloConfig();
		
		super();
		
	}
	
	public static function main(m:MovieClip):Void{
		
		// This is application's entry point
		// Just create an instance of the model and
		// call the config method passing the MovieClip
		// that this application is going to use
		
		// After that, just wait until "frameworkReady" is called
		// From that point onwards, you have the control
		
		var instance:HelloModel = new HelloModel();
		instance.config(m);
		
	}

	// ******************** PRIVATE METHODS ********************

	private function frameworkReady():Void{
		
		// At this point the framework has finished its job
		// Do whatever you like from now onward
		
		// Maybe you want to call something on the server
		// Here we just call a method on the view
		
		view.drawImages();
		
	}

}
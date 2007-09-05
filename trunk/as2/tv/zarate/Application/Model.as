import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.FlashVars;
import tv.zarate.Utils.RightClick;
import tv.zarate.Utils.Trace;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.Application.Config;
import tv.zarate.Application.View;

class tv.zarate.Application.Model{

	private var conf:Config;
	private var flashvars:FlashVars;
	private var view:View;

	private var timeLine_mc:MovieClip;

	public function Model(){
		
		Trace.trc("zFramework up and running");
		
	}

	public function config(m:MovieClip):Void{
		
		timeLine_mc = m;
		timeLine_mc.onEnterFrame = Delegate.create(this,waitForStage);
		
	}

	public function setSize(w:Number,h:Number):Void{
		view.setSize(w,h);
	}
	
	public function remove():Void{
		
		timeLine_mc.removeMovieClip();
		
	}

	// ******************** PRIVATE METHODS ********************

	private function waitForStage():Void{
		
		// IE takes at least 1 frame to get actual dimensions
		
		if(Stage.width > 0 && Stage.height > 0){
			
			delete timeLine_mc.onEnterFrame;
			initialize();
			
		}
		
	}

	private function initialize():Void{
		
		flashvars = new FlashVars(timeLine_mc);
		
		var xmlPath:String = flashvars.initString("fv_xmlPath","");
		
		if(conf == null){ conf = Config.getInstance(); }
		conf.loadXML(xmlPath,Delegate.create(this,configReady));
		
	}

	private function configReady(success:Boolean):Void{
		
		if(success){
			
			timeLine_mc.menu = new RightClick();
			
			if(view == null){ view = new View(); }
			view.setSize(Stage.width,Stage.height,false);
			view.config(timeLine_mc.createEmptyMovieClip("view_mc",100),MovieclipUtils.isRoot(timeLine_mc));
			
			frameworkReady();
			
		} else {
			
			trace("Impossible to create config object :(");
			
		}
		
	}

	// Model childs override this method.
	// From this point onwards the common part is done
	private function frameworkReady():Void{}

}
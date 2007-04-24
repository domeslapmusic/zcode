import tv.zarate.Utils.Trace;
import tv.zarate.Projects.ZBooks.zbModel;
import tv.zarate.Projects.ZBooks.zbView;
import tv.zarate.Projects.ZBooks.zbController;

class tv.zarate.Projects.ZBooks.zbApp{
	
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
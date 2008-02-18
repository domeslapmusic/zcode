import tv.zarate.projects.zplayer.zpModel;

import com.supernovapop.player.snView;

class com.supernovapop.player.snModel extends zpModel{
	
	private var view:snView;
	
	public function snModel(){
		
		view = new snView();
		
		super();
		
	}

	public static function main(m:MovieClip):Void{
		
		var instance:snModel = new snModel();
		instance.config(m);
		
	}
	
}
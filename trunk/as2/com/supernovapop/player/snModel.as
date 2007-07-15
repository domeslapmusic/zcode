import tv.zarate.Projects.zplayer.zpModel;

import com.supernovapop.player.snView;

class com.supernovapop.player.snModel extends zpModel{
	
	private var view:snView;
	
	public function snModel(m:MovieClip){
		
		view = new snView();
		
		super(m);
		
	}

	public static function main(m:MovieClip):Void{
		
		var instance:snModel = new snModel(m);
		
	}
	
}
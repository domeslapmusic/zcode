import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.MovieclipUtils;

class tv.zarate.Projects.ZBooks.zbCheck{
	
	private var _selected:Boolean = false;
	private var base_mc:MovieClip;
	private var check_mc:MovieClip;
	private var selectedIcon:String = "check_selected";
	private var regularIcon:String = "check";
	private var mcTabIndex:Number;
	private var hadFocus:Boolean;
	
	public function zbCheck(mc:MovieClip){
		
		base_mc = mc;
		
		checkIcon();
		base_mc.onPress = Delegate.create(this,changeSelect);
		
		Key.addListener(this);
		
	}
	
	public function set tabIndex(val:Number):Void{
		
		mcTabIndex = val;
		check_mc.tabIndex = val
		
	}
	
	public function set selected(val:Boolean):Void{
		
		_selected = val;
		checkIcon();
		
	}
	
	public function get selected():Boolean{
		return _selected;
	}
	
	// private methods
	private function checkIcon():Void{
		
		check_mc = base_mc.attachMovie((_selected)? selectedIcon:regularIcon,"check_mc",100);
		check_mc.focusEnabled = true;
		
		tabIndex = mcTabIndex;
		if(hadFocus) Selection.setFocus(check_mc);
		
	}
	
	private function changeSelect():Void{
		
		_selected = !_selected;
		checkIcon();
		
	}
	
	private function onKeyUp():Void{
		
		hadFocus = MovieclipUtils.hasFocus(check_mc);
		
		if(Key.getCode() == Key.SPACE && hadFocus){
			
			changeSelect();
			
		}
		
	}
	
}
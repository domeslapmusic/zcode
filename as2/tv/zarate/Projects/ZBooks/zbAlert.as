import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.TextfieldUtils;
import tv.zarate.Projects.ZBooks.zbView;

class tv.zarate.Projects.ZBooks.zbAlert{

	public var accept_mc:MovieClip;
	
	private var base_mc:MovieClip;
	private var view:zbView;
	private var formWidth:Number = 350;

	public function zbAlert(_view:zbView,m:MovieClip,acceptCallback:Function,cancel:Boolean,cancelCallback:Function){
		
		view = _view;
		base_mc = m;
		base_mc._y = 20;
		
		draw(acceptCallback,cancel,cancelCallback);
		
	}

	public function remove():Void{
		base_mc.removeMovieClip();
	}
	
	public function submit():Void{
		base_mc.accept_mc.onPress();
	}
	
	public function setHeight(h:Number):Void{
		
		// background
		var background_mc:MovieClip = base_mc.createEmptyMovieClip("background_mc",100);
		MovieclipUtils.DrawSquare(background_mc,0xffccff,100,formWidth,h);
		
		base_mc._x = Math.round((view.appWidth - base_mc._width)/2);
		
	}
	
	// PRIVATE METHODS
	
	private function draw(acceptCallback:Function,cancel:Boolean,cancelCallback:Function):Void{
		
		var formHeight:Number = 200;
		var field:TextField;
		var cancel_mc:MovieClip;
		var margin:Number = 5;
		
		if(cancel){
			
			// cancel
			cancel_mc = base_mc.createEmptyMovieClip("cancel_mc",200);
			
			field = TextfieldUtils.createField(cancel_mc);
			field.text = "Cancel";
			field.setTextFormat(view.getFormat(""));
			
			cancel_mc._x = formWidth - cancel_mc._width - margin;
			cancel_mc._y = formHeight - cancel_mc._height - margin;
			
			cancel_mc.onPress = cancelCallback;
			
		}
		
		// accept
		accept_mc = base_mc.createEmptyMovieClip("accept_mc",300);
		
		field = TextfieldUtils.createField(accept_mc);
		field.text = "Accept";
		field.setTextFormat(view.getFormat(""));
		
		accept_mc._x = cancel_mc._x - accept_mc._width - margin;
		accept_mc._y = formHeight - accept_mc._height - margin;
		
		accept_mc.onPress = acceptCallback;
		
		accept_mc.tabIndex = view.getTabIndex("modal");
		if(cancel){ cancel_mc.tabIndex = view.getTabIndex("modal"); }
		
		setHeight(formHeight);
		
	}
	
	/*
	tanto aceptar como cancelar deberian hacer autodestroy antes de 
	ejecutar los callbaks
	*/
}
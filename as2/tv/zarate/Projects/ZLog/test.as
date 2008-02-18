import tv.zarate.utils.Trace;
import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.TextfieldUtils;
import tv.zarate.utils.Delegate;

class tv.zarate.projects.ZLog.test{

	private var base_mc:MovieClip;

	public function test(m:MovieClip){

		Trace.trc("Test app up and running");

		Stage.scaleMode = "noScale";
		Stage.align = "TL";

		base_mc = m;

		doLayout();

	}

	public static function main(m:MovieClip):Void{

		var instance:test = new test(m);

	}

	// private methods

	private function doLayout():Void{

		var margin:Number = 5;

		var sendTrace_mc:MovieClip = makeButton("Send trace");

		sendTrace_mc.onPress = Delegate.create(this,doTrace,1);

		var sendFatal_mc:MovieClip = makeButton("Send fatal");
		sendFatal_mc._x = sendTrace_mc._x + sendTrace_mc._width + margin;

		sendFatal_mc.onPress = Delegate.create(this,doTrace,2);


		var sendXML_mc:MovieClip = makeButton("Send xml");
		sendXML_mc._x = sendFatal_mc._x + sendFatal_mc._width + margin;

		sendXML_mc.onPress = Delegate.create(this,doTrace,3);

	}

	private function doTrace(type:Number):Void{

		switch(type){

			case(1):

				trace("Hello world > " + random(100));
				break;

			case(2):

				trace("Hello fatal world > " + random(100),"fatal");
				break;

			case(3):

				var xmlString:String = '<data><oneNode reallyImportantAttribute="null">This is node value!</oneNode><otherNode><withChild></withChild></otherNode></data>';

				var xml:XML = new XML(xmlString);

				trace(xml);
				break;


		}

	}

	private function makeButton(txt:String):MovieClip{

		var depth:Number = base_mc.getNextHighestDepth();

		var mc:MovieClip = base_mc.createEmptyMovieClip("button_"+depth,depth);

		var back_mc:MovieClip = mc.createEmptyMovieClip("back_mc",100);
		MovieclipUtils.DrawSquare(back_mc,0x000000,100,100,30);

		var title_mc:MovieClip = mc.createEmptyMovieClip("title_mc",200);
		title_mc._x = 10;

		var field:TextField = TextfieldUtils.createField(title_mc);
		field.text = txt;
		field.setTextFormat(new TextFormat(null,18,0xffffff));

		return mc;

	}

}
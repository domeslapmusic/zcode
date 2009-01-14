/*****************************************************************************************************
* Written by: Cay Garrido
* email: ventdaval@gmail.com
* website: http://www.cay.cl/
* 
* By using the this code, you agree to keep the above contact information in the source code.
* 
* This code (c) 2007-2008 Cay Garrido and is released under the MIT License:
* http://www.opensource.org/licenses/mit-license.php 
*****************************************************************************************************/


package cl.cay.utils{
	import flash.display.*;
	import flash.text.*;
	import flash.utils.getTimer;
	import flash.geom.*;
	import flash.system.*

	public class FPSCounter extends Sprite {
		private var bmp:BitmapData;
		static var cols:Array=new Array(65280,1638144,3342080,5046016,6815488,8388352,10092288,11861760,13565696,15269632,16776448,16769792,16763136,16756480,16750080,16743936,16737280,16730880,16724224,16717568);

		//frametimes maximo y minimo (este ultimo se saca del stage.frameTime)
		public var maxt:Number;
		public var mint:Number;
		
		private var W:Number;
		private var H:Number;
		private var tf:TextField;

		private var time1:uint;
		private var time2:uint;
		private var frames:uint=0;
		private var fps:String="...";
		private var mem:String="...";

		public function FPSCounter(W:uint=300,H:uint=20) {
			this.W=W;
			this.H=H;
			bmp=new BitmapData(W,H,false,0);
			addChild(new Bitmap(bmp));

			tf=new TextField();
			tf.selectable=false;
			tf.width=width;
			tf.height=height;
			tf.textColor=0xFFFFFF;
			tf.defaultTextFormat=new TextFormat("_sans",9,0xFFFFFF);
			addChild(tf);
			addEventListener("addedToStage",init);
		}
		public function init(e) {
			maxt=200;
			mint=1000 / stage.frameRate;
			time1=time2=getTimer();
			addEventListener("enterFrame",loop);
		}
		var a=0;
		private function loop(e) {
			var time:uint=getTimer();
			var ftime:uint=time - time1;
			time1=time;

			if (time-time2 >= 1000) {
				fps=frames.toString();
				frames=0;
				time2=time;
				
			} else {
				frames++;
			}
			var totmem=System.totalMemory / 1048576;
			mem = (totmem).toFixed(2);
			tf.text=fps + "fps | " + ftime + "ms | "+mem+"ram";
			
			if(ftime<mint) ftime=mint;
			if(ftime>maxt) ftime=maxt;

			var y:Number=(ftime - mint) / (maxt - mint);
			var col:uint=cols[Math.round(y * 20)];
			if (! col) col=cols[cols.length - 1];
			
			bmp.scroll(-1,0);
			bmp.fillRect(new Rectangle(W - 2,H-(y*H),1,H),col);
			
			if(totmem<20) totmem=20;
			y=Math.sqrt(Math.sqrt((totmem-20)*1200))-H/3;
			bmp.setPixel(W-2,H-y,0x00FFFF);
		}
	}
}
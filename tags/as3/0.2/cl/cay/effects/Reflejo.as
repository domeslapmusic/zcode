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

package cl.cay.effects {
	
	import flash.display.*;
	import flash.geom.*;
	import flash.events.Event;
	import cl.cay.utils.Draw;
	
	public class Reflejo extends Sprite{
		
		private var c:DisplayObject;
		private var r:Rectangle;
		private var bmp:BitmapData;
		
		public function Reflejo(C:DisplayObject, R:Rectangle) {
			
			c=C;
			r=R;
			bmp=new BitmapData(r.width,r.height,false,0);
			var bit:Bitmap = new Bitmap(bmp,"never");
			addChild(bit);
			var grad:Shape = new Shape();
			Draw.GradientBox(grad.graphics,bmp.rect,[0,0],[1,0],Math.PI/2);
			addChild(grad);
			grad.width=r.width+2;
			grad.x=-1;
			grad.height=r.height+1;
			blendMode="layer";
			grad.blendMode="alpha";
			addEventListener("enterFrame",update);
			update(new Event("lala"));
			
		}
		
		public function update(e:Event):void{
			x=c.x+r.x;
			y=c.y+c.height + 1;
			var matrix:Matrix=new Matrix();
			matrix.scale(1,-1);
			matrix.translate(r.x,c.height);
			bmp.fillRect(bmp.rect,0);
			bmp.draw(c,matrix);
		}
		
	}
}
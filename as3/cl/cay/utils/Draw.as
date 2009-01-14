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

package cl.cay.utils {
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.display.Graphics;
	
	public class Draw {
		
		
		/*************** USAGE *********************
		import cl.cay.utils.Draw;
		Draw.GradientBox(this.graphics,new Rectangle(0,0,50,50),[0,0xFFFFFF]);
		Draw.GradientBox(misprite.graphics,new Rectangle(100,0,50,50),[0xFF0000,0x00FF00,0x0000FF],[1,0,1]);
		Draw.GradientBox(mishape.graphics,new Rectangle(200,0,50,50),[0xFF0000,0x00FF00,0x0000FF],null,Math.PI/2);
		********************************************/
		
		public static function GradientBox(c:Graphics, r:Rectangle, colors:Array, alphas:Array=null, ang:Number=0):void{
			
			if (alphas===null) {
				
				alphas = new Array();
				
				/*
				for (var j:Number in colors) {
					alphas.push(1);
				}
				*/
				
				for each (var color:Number in colors){
					alphas.push(color);
				}
				
			}
			
			var fillType:String = "linear";
			var ratios:Array = new Array();
			var l:Number = colors.length;
			
			for (var i:int = 0; i<l; i++) {
				ratios.push(0xFF*i/(l-1));
			}
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(r.width,r.height,ang,r.x,r.y);
			
			with (c) {
				beginGradientFill(fillType,colors,alphas,ratios,matrix);
				moveTo(r.x,r.y);
				lineTo(r.x+r.width,r.y);
				lineTo(r.x+r.width,r.y+r.height);
				lineTo(r.x,r.y+r.height);
				lineTo(r.x,r.y);
				endFill();
			}
		}
	}
}
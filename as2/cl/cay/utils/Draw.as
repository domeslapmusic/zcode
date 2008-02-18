/*
* 
* Copyright (c) 2008, Cay Garrido
* 
* Visit http://www.ventdaval.com/ and http://www.cay.cl/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.
* 
* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

import flash.geom.Rectangle;
import flash.geom.Matrix;

class cl.cay.utils.Draw {
	
	
	/*************** USAGE *********************
	import flash.geom.Rectangle;
	import cl.cay.utils.Draw;
	Draw.GradientBox(this,new Rectangle(0,0,50,50),[0,0xFFFFFF]);
	Draw.GradientBox(mimc,new Rectangle(100,0,50,50),[0xFF0000,0x00FF00,0x0000FF],[100,0,100]);
	Draw.GradientBox(mc.c,new Rectangle(200,0,50,50),[0xFF0000,0x00FF00,0x0000FF],null,Math.PI/2);
	********************************************/
	
	public static function GradientBox(c:MovieClip, r:Rectangle, colors:Array, alphas:Array, ang:Number) {
		if (!alphas) {
			alphas = new Array();
			for (var j:String in colors) {
				alphas.push(100);
			}
		}
		if(!ang) ang=0;
		var fillType:String = "linear";
		var ratios:Array = new Array();
		var l:Number = colors.length;
		for (var i:Number = 0; i<l; i++) {
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
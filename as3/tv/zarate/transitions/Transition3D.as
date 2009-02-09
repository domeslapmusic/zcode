/*
*
* MIT License
* 
* Copyright (c) 2009, Juan Delgado - Zarate
* 
* http://zarate.tv/projects/zcode/
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
* 
*/

package tv.zarate.transitions{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.events.Event;
	
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.materials.BitmapMaterial;
	
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweenTimeline;
	import gs.easing.*;
	
	import tv.zarate.utils.ArrayUtils;
	
	import tv.zarate.transitions.Transition3DScene;
	
	public class Transition3D{
		
		private static var basicView:BasicView;
		
		public static function Wadus(object:DisplayObject,rows:uint,cols:uint,random:Boolean=true):void{
			
			var transition3dscene:Transition3DScene = Create(object,rows,cols);
			
			var pieces:Array = transition3dscene.pieces;
			
			if(random){ ArrayUtils.Randomize(pieces); }
			
			var timeLine:GTweenTimeline = new GTweenTimeline();
			
			var pos:Number = .1;
			
			for each(var piece:Plane in pieces){
				
				var t:GTween = new GTween(piece,2,{y:piece.y-100,z:300,rotationX:360,rotationY:360},{autoRotation:false});
				t.ease = Elastic.easeOut;
				
				timeLine.addTween(pos,t);
				
				pos += .1;
				
			}
			
		}
		
		private static function Create(object:DisplayObject,rows:uint,cols:uint):Transition3DScene{
			
			var parent:DisplayObjectContainer = object.parent;
			parent.removeChild(object);
			
			basicView = new BasicView(0,0,true);
			parent.addChild(basicView);
			
			var pieceWidth:Number = object.width / cols;
			var pieceHeight:Number = object.height / rows;
			
			var diffX:Number = object.x -basicView.viewport.viewportWidth / 2 + pieceWidth / 2;
			var diffY:Number = -object.y + basicView.viewport.viewportHeight / 2 - pieceHeight / 2;
			
			var pieces:/*Plane*/Array = new Array();
			
			var rect:Rectangle = new Rectangle(0,0,pieceWidth,pieceHeight);
			
			for(var i:int=0;i<rows;i++){
				
				for(var j:int=0;j<cols;j++){
					
					var currentX:Number = i * pieceWidth;
					var currentY:Number = j * pieceHeight;
					
					var bmp:BitmapData = new BitmapData(pieceWidth,pieceHeight,true);
					bmp.draw(object,new Matrix(1,0,0,1,-currentX,-currentY),null,null,rect);
					
					var material:BitmapMaterial = new BitmapMaterial(bmp);
					//material.oneSide = false;
					//material.smooth = true;
					
					var piece:Plane = new Plane(material,pieceWidth,pieceHeight);
					basicView.scene.addChild(piece);
					
					pieces.push(piece);
					
					piece.x = currentX + diffX;
					piece.y = -currentY + diffY;
					piece.z = (basicView.camera.zoom * basicView.camera.focus) - Math.abs(basicView.camera.z);
					
				}
				
			}
			
			parent.addEventListener(Event.ENTER_FRAME,tick);
			
			return new Transition3DScene(basicView,pieces);
			
		}
		
		private static function tick(e:Event):void{
			
			basicView.renderer.renderScene(basicView.scene,basicView.cameraAsCamera3D,basicView.viewport);
			
		}
		
	}
	
}
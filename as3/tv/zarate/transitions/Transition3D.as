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
		private static var transition3dscene:Transition3DScene;
		
		public static function Wadus(object:DisplayObject,rows:uint,cols:uint,random:Boolean=true):void{
			
			// We create the stuff we need, see below for details
			
			transition3dscene = Create(object,rows,cols);
			
			// Once we have the 3D scene in place, it's just a matter of
			// animating each plane or piece. I'm using GTween and Penner's equations here 
			// but you can do it the way you want. Also note that the transition3dscene object
			// has a reference to BasicView object too, so you could animate the camera or the scene as well, up to you.
			
			var pieces:Array = transition3dscene.pieces;
			
			if(random){ ArrayUtils.Randomize(pieces); }
			
			var timeLine:GTweenTimeline = new GTweenTimeline();
			
			var tweenDelta:Number = .005;
			var tweenPosition:Number = tweenDelta;
			
			var counter:int = 0;
			var total:int = pieces.length;
			
			for each(var piece:Plane in pieces){
				
				var t:GTween = new GTween(piece,1,{z:300,rotationX:360,rotationY:360},{autoRotation:false});
				t.ease = Elastic.easeOut;
				
				counter++;
				
				if(counter >= total){
					
					// adding a listener to the last tween
					t.addEventListener(Event.COMPLETE,lastPlaneComplete);
					
				}
				
				timeLine.addTween(tweenPosition,t);
				
				tweenPosition += tweenDelta;
				
			}
			
		}
		
		private static function lastPlaneComplete(e:Event):void{
			
			// This animation back is just for demo purposes, not really needed.
			
			var pieces:Array = transition3dscene.pieces;
			
			for each(var piece:Plane in pieces){
				
				var zOriginalPosition:int = -653; // yeah, i'm cheating here, should figure this out reversing the original formula. stay tunned.
				
				var t:GTween = new GTween(piece,1,{z:-653,rotationX:0,rotationY:0},{autoRotation:false});
				t.ease = Elastic.easeOut;
				
			}
			
		}
		
		private static function Create(object:DisplayObject,rows:uint,cols:uint):Transition3DScene{
			
			var parent:DisplayObjectContainer = object.parent;
			
			// Remove original object from parent's DisplaList
			parent.removeChild(object);
			
			// BasicView has all the ingredients we need for a 3D scene, enough for now
			basicView = new BasicView(0,0,true);
			parent.addChild(basicView);
			
			
			// Lets find out how big the planes are going to be
			var pieceWidth:Number = object.width / cols;
			var pieceHeight:Number = object.height / rows;
			
			
			// Tricky stuff ahead.
			// Passing from the 2D object to the 3D scene MUST be seamless for the user so
			// we need to calculate some stuff based on original object's position and camera zoom (see later)
			// Got it from here:
			// http://www.everydayflash.com/blog/index.php/2008/07/07/pixel-precision-in-papervision3d/
			// http://archive.pv3d.org/?p=51
			// Thanks to XLeon for the pointers!
			
			var diffX:Number = object.x -basicView.viewport.viewportWidth / 2 + pieceWidth / 2;
			var diffY:Number = -object.y + basicView.viewport.viewportHeight / 2 - pieceHeight / 2;
			
			var pieces:/*Plane*/Array = new Array();
			
			var rect:Rectangle = new Rectangle(0,0,pieceWidth,pieceHeight);
			
			// The loop below slices up the object and creates a plane with each piece.
			// Thanks to Cay for the Matrix tip : )
			
			for(var i:int=0;i<rows;i++){
				
				for(var j:int=0;j<cols;j++){
					
					var currentX:Number = i * pieceWidth;
					var currentY:Number = j * pieceHeight;
					
					var bmp:BitmapData = new BitmapData(pieceWidth,pieceHeight,true);
					bmp.draw(object,new Matrix(1,0,0,1,-currentX,-currentY),null,null,rect);
					
					var material:BitmapMaterial = new BitmapMaterial(bmp);
					
					var piece:Plane = new Plane(material,pieceWidth,pieceHeight);
					basicView.scene.addChild(piece);
					
					pieces.push(piece);
					
					// See here how we calculate x,y,z
					// based on the original object and camera zoom
					piece.x = currentX + diffX;
					piece.y = -currentY + diffY;
					piece.z = (basicView.camera.zoom * basicView.camera.focus) - Math.abs(basicView.camera.z);
					
				}
				
			}
			
			// We need to render the scene
			parent.addEventListener(Event.ENTER_FRAME,tick);
			
			return new Transition3DScene(basicView,pieces);
			
		}
		
		private static function tick(e:Event):void{
			
			basicView.renderer.renderScene(basicView.scene,basicView.cameraAsCamera3D,basicView.viewport);
			
		}
		
	}
	
}
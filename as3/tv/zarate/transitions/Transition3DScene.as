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
	
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.cameras.*;
	import org.papervision3d.scenes.*;
	import org.papervision3d.render.*;
	import org.papervision3d.view.*;
	import org.papervision3d.materials.*;
	
	public class Transition3DScene{
		
		public var viewport:Viewport3D;
		public var renderer:BasicRenderEngine;
		public var scene:Scene3D;
		public var camera:Camera3D;
		public var pieces:Array;
		public var basicView:BasicView;
		
		public function Transition3DScene(basicView:BasicView,pieces:Array){
			
			this.basicView = basicView;
			this.pieces = pieces;
			
			viewport = basicView.viewport;
			renderer = basicView.renderer;
			scene = basicView.scene;
			camera = basicView.cameraAsCamera3D;
			
		}
		
	}
	
}
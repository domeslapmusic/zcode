/*
*
* MIT License
* 
* Copyright (c) 2008, Juan Delgado - Zarate
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

package tv.zarate.player.events{
	
	import flash.events.Event;
	import tv.zarate.player.iPlayer;
	
	public class evLoadProgress extends Event{
		
		public static const LOAD_PROGRESS:String ="load_progress";
		
		public var player:iPlayer;
		public var bytesLoaded:Number;
		public var bytesTotal:Number;
		public var percentage:Number;
		
		public function evLoadProgress(player:iPlayer,bytesLoaded:Number,bytesTotal:Number,percentage:Number){
			
			super(LOAD_PROGRESS);
			
			this.player = player;
			this.bytesLoaded = bytesLoaded;
			this.bytesTotal = bytesTotal;
			this.percentage = percentage;
			
		}
		
	}
	
}
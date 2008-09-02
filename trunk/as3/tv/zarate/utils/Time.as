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

package tv.zarate.utils{
	
	public class Time{
		
		public var days:Number = 0;
		public var hours:Number = 0;
		public var minutes:Number = 0;
		public var seconds:Number = 0;

		public function Time(days:Number,hours:Number,minutes:Number,seconds:Number){
		
			this.days = days;
			this.hours = hours;
			this.minutes = minutes;
			this.seconds = seconds;
		
		}

		public static function getTimeFromSeconds(seconds:Number):Time{
		
			var rest:Number = seconds;
			var daySeconds:Number = 24*60*60;
			var hourSeconds:Number = 60*60;
			var minuteSeconds:Number = 60;
			var secondMiliseconds:Number = 1000;
			
			var days:Number = Math.floor(rest/daySeconds);
			rest -= days*daySeconds;
			
			var hours:Number = Math.floor(rest/hourSeconds);
			rest -= hours*hourSeconds;
			
			var mins:Number = Math.floor(rest/minuteSeconds);
			rest -= mins*minuteSeconds;
			
			var seconds:Number = rest;
			
			return new Time(days,hours,mins,seconds);
			
		}
		
		public static function getFriendlyStringFromTime(time:Time,days:Boolean=false,hours:Boolean=false,minutes:Boolean=true,seconds:Boolean=true):String{
			
			var t:String = "";
			
			if(days){ t += getZeroLead(time.days); }
			if(hours){ if(days){ t+= ":"; } t+= getZeroLead(time.hours); }
			if(minutes){ if(hours){ t+= ":"; } t+= getZeroLead(time.minutes); }
			if(seconds){ if(minutes){ t+= ":"; } t+= getZeroLead(time.seconds); }
			
			return t;
			
		}
		
		private static function getZeroLead(n:Number):String{
			return (n < 10)? "0"+n:""+n;
		}
		
	}
	
}
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
	
	import tv.zarate.utils.MathUtils;
	
	public class DateUtils{
		
		// Returns a random date between 2 given. If no given between 1970 and today
		public static function getRandomDate(minDate:Date=null,maxDate:Date=null):Date{
			
			if(minDate == null){ minDate = new Date(1970,0,1); }
			if(maxDate == null){ maxDate = new Date(); }
			
			return new Date(MathUtils.getRandomBetween(getUTCFromDate(minDate),getUTCFromDate(maxDate)));
			
		}
		
		// Returns UTC miliseconds from a date. How come this is not in the official Date class???
		public static function getUTCFromDate(date:Date):Number{
			return Date.UTC(date.fullYear,date.month,date.date,date.hours,date.minutes,date.seconds,date.milliseconds);
		}
		
		// Returns dd/mm/yyyy format from given date
		public static function getSlashSeparatedStringFromDate(date:Date):String{
			
			var t:String;
			
			t += (date.date < 9)? "0" + date.date : date.date;
			t += "/" + ((date.month + 1 < 9)? "0" + (date.month + 1) : date.month + 1);
			t += "/" + date.fullYear;
			
			return t;
			
		}
		
	}
	
}
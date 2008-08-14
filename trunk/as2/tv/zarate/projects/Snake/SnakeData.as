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

class tv.zarate.Projects.Snake.SnakeData{
	
	private var so:SharedObject;
	private var soName:String = "Zarate_Snake_os";
	
	public function SnakeData(){
		
		so = SharedObject.getLocal(soName);
		
		if(so.data.maxScore == undefined){
			
			so.data.maxScore = 0;
			so.data.date = new Date();
			so.flush();
			
		}
		
	}

	public function getMaxScore(callback:Function):Void{
		callback(true,Number(so.data.maxScore));
	}
	
	public function setMaxScore(val:Number,callback:Function):Void{
		
		so.data.maxScore = val;
		so.data.date = new Date();
		so.flush();
		
		callback(true,so.data.maxScore,so.data.date);
		
	}
	
	/* ************************* PRIVATE METHODS ************************* */
	
}
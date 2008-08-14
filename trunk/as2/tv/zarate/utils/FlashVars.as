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

class tv.zarate.utils.FlashVars{

	private var timeLine_mc:MovieClip;

	public function FlashVars(m:MovieClip){
		timeLine_mc = m;
	}

	public function getVar(varName:String):String{
		return timeLine_mc[varName];
	}

	public function initString(varName:String,currentVal:String):String{
		
		var fv:String = getVar(varName);
		return (fv != null)? fv:currentVal;
		
	}

	public function initNumber(varName:String,currentVal:Number):Number{
		
		var fv:String = getVar(varName);
		return (fv != null)? Number(fv):currentVal;
		
	}

	public function initBoolean(varName:String,currentVal:Boolean):Boolean{
		
		var fv:String = getVar(varName);
		return (fv != null)? ((fv == "true")? true:false):currentVal;
		
	}

}
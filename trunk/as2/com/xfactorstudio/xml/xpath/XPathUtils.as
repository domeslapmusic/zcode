﻿/**
	Copyright (c) 2002 Neeld Tanksley.  All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	1. Redistributions of source code must retain the above copyright notice,
	this list of conditions and the following disclaimer.
	
	2. Redistributions in binary form must reproduce the above copyright notice,
	this list of conditions and the following disclaimer in the documentation
	and/or other materials provided with the distribution.
	
	3. The end-user documentation included with the redistribution, if any, must
	include the following acknowledgment:
	
	"This product includes software developed by Neeld Tanksley
	(http://xfactorstudio.com)."
	
	Alternately, this acknowledgment may appear in the software itself, if and
	wherever such third-party acknowledgments normally appear.
	
	4. The name Neeld Tanksley must not be used to endorse or promote products 
	derived from this software without prior written permission. For written 
	permission, please contact neeld@xfactorstudio.com.
	
	THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES,
	INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
	FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL NEELD TANKSLEY
	BE LIABLE FOR ANY DIRECT, INDIRECT,	INCIDENTAL, SPECIAL, EXEMPLARY, OR 
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
	HOWEVER CAUSED AND ON ANY THEORY OF	LIABILITY, WHETHER IN CONTRACT, STRICT 
	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 
	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

class com.xfactorstudio.xml.xpath.XPathUtils{

	private function XPathUtils(){
	
	}
	
	static function cloneArray(obj:Array):Array{
		var retArr:Array = new Array();
		for(var i:Number=0;i<obj.length;i++){
			retArr.push(obj[i]);
		}
		return retArr;
	}
	

	/**
		checkEmpty
	
		This method was adapted from
		//--------------------------------------------------
		// XMLnitro v 2.1
		//--------------------------------------------------
		// Branden J. Hall
		// Fig Leaf Software
		// October 1, 2001
		MODIFIED BY:Eric Priou viaDev@v-i-a.net  
	**/
	static function checkEmpty(contextNode:XMLNode):Boolean{
		var text:String = contextNode.nodeValue;
		var max:Number = text.length;
		var empty:Boolean = true;

		for (var i:Number=1 ; i<max ; i+=2){
			if ((text.substr(i-1, 1)).charCodeAt() > 32){
				empty = false;
				break;
			}
		}
		return empty;
	}
}

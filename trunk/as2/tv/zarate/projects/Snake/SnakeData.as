/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
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

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
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

class tv.zarate.Projects.Snake.Worlds.SnakeFloor{
	
	public var x:Number = 0;
	public var y:Number = 0;
	public var type:Number = 0;
	
	public function SnakeFloor(_x:Number,_y:Number){
		
		x = _x;
		y = _y;
		
	}
	
	public function toString():String{
		return "[SnakeSnakeFloor: x=" +  x + ", y=" + y + ", type=" + type + "]";
	}
	
	/* ************************* PRIVATE METHODS ************************* */
	
}
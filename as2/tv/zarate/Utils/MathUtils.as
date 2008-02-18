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

class tv.zarate.utils.MathUtils{
	
	// Returns random between min and max, including both

	public static function getRandomBetween(min:Number,max:Number):Number{
		return min + Math.floor(Math.random()*(max+1-min));
	}
	
	// Returns random between 0 and max, including both
	
	public static function getRandom(max:Number):Number{
		return getRandomBetween(0,max);
	}
	
}
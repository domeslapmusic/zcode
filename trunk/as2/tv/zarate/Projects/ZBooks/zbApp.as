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

import tv.zarate.Utils.Trace;
import tv.zarate.Projects.ZBooks.zbModel;
import tv.zarate.Projects.ZBooks.zbView;
import tv.zarate.Projects.ZBooks.zbController;

class tv.zarate.Projects.ZBooks.zbApp{
	
	public static function main(m:MovieClip):Void{
		
		Trace.trc("ZBooks App")
		
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var model:zbModel = new zbModel();
		var view:zbView = new zbView();
		var controller:zbController = new zbController();
		
		model.config(view,m);
		view.config(model,controller,m);
		controller.config(model,view);
		
		model.start();
		
	}

	public static function trc(s:String,type:String,reset:Boolean):Void{
		Trace.trc(s,type,reset);
	}

}
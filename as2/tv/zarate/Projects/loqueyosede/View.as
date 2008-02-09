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

import tv.zarate.Utils.TextfieldUtils;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.Delegate;

import tv.zarate.Projects.loqueyosede.Model;

class tv.zarate.Projects.loqueyosede.View{
	
	private var model:Model;

	private var base_mc:MovieClip;
	private var background_mc:MovieClip;
	private var title_mc:MovieClip;
	private var titleField:TextField;
	
	private var width:Number = 0;
	private var height:Number = 0;
	
	private var OVER:String = "over";
	private var OUT:String = "out";
	private var PRESS:String = "press";
	
	public function View(){
		
		// hacemos que la vista sea listener de Stage
		// para poder reaccionar a cambios de dimensiones de 
		// la pelicula
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		Stage.addListener(this);
		
	}
	
	public function config(_model:Model,_base_mc:MovieClip):Void{
		
		// nos llega por composicion una instancia del modelo
		// eso nos permitira acceder a sus metodos y propiedades publicas
		model = _model;
		
		// guardamos una referencia al clip con el que trabajara la vista
		base_mc = _base_mc;
		
		// creamos los elementos basicos
		doInitialLayout();
		onResize();
		
	}

	public function displayValue(value:Number):Void{
		
		titleField.text = "Clicks > " + value;
		
	}
	
	// ************************* PRIVATE METHODS *************************

	private function doInitialLayout():Void{
		
		// este metodo solo es llamado una vez
		// y es el encargado de crear los elementos necesarios
		// ya sea por codigo y haciendo attach de elementos de la
		// biblioteca
		
		// aqui no deberia haber nada relacionado con el posicionamiento
		// de eso se encarga el metodo layout
		
		// color de fondo
		background_mc = base_mc.createEmptyMovieClip("background_mc",100);
		
		// creamos el campo de texto con el titulo
		title_mc = base_mc.createEmptyMovieClip("title_mc",200);
		titleField = TextfieldUtils.createField(title_mc);
		titleField.border = true;
		titleField.text = " ";
		
		// creamos el boton
		var button_mc:MovieClip = base_mc.createEmptyMovieClip("button_mc",300);

		var buttonBackground_mc:MovieClip = button_mc.createEmptyMovieClip("buttonBackground_mc",100);
		MovieclipUtils.DrawSquare(buttonBackground_mc,0x0000ff,100,200,50);

		var buttonTitle_mc:MovieClip = button_mc.createEmptyMovieClip("buttonTitle_mc",200);
		var field:TextField = TextfieldUtils.createField(buttonTitle_mc);
		field.text = "Haz click, majete!";
		
		button_mc._y = title_mc._y + title_mc._height + 10;

		// definimos los eventos y los delegamos al metodo manageButton
		button_mc.onPress = Delegate.create(this,manageButton,button_mc,PRESS);
		button_mc.onRollOver = Delegate.create(this,manageButton,button_mc,OVER);
		button_mc.onRollOut = Delegate.create(this,manageButton,button_mc,OUT);
		
	}

	private function layout():Void{
		
		// este metodo es llamado siempre que la pelicula
		// cambia de dimensiones
		
		MovieclipUtils.DrawSquare(background_mc,0xff00ff,100,width,height);
		
			
	}

	private function onResize():Void{
		
		// actualizamos las dimensiones de la pelicula
		width = Stage.width;
		height = Stage.height;
		
		
		// llamamos al metodo de posicionamiento
		layout();
		
	}
	
	private function manageButton(mc:MovieClip,action:String):Void{
		
		// por vagancia no hago nada en el OVER y el OUT
		// pero para eso llega una referencia al button en el parametro
		// mc, para poder, por ejemplo, cambiarle el color
		
		switch(action){
			
			case(OVER):
				break;
			case(OUT):
				break;
			case(PRESS):
				
				// llamamos a un metodo publico del modelo
				// que actualiza el contador de clicks
				model.updateClick();
			
		}
		
	}
	
}
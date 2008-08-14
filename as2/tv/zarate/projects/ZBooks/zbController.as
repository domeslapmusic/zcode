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

import tv.zarate.utils.MovieclipUtils;

import tv.zarate.projects.ZBooks.zbModel;
import tv.zarate.projects.ZBooks.zbView;
import tv.zarate.projects.ZBooks.Bookmark;
import tv.zarate.projects.ZBooks.Label;
import tv.zarate.projects.ZBooks.Constants;

class tv.zarate.projects.ZBooks.zbController{

	private var model:zbModel;
	private var view:zbView;

	function zbController(){

		Stage.addListener(this);
		Key.addListener(this);
		Mouse.addListener(this);

	}

	function config(_model:zbModel,_view:zbView):Void{

		model = _model;
		view = _view;

		onResize();

	}

	public function goToOwnPage():Void{
		model.goToOwnPage();
	}

	public function login(name:String,pass:String,cookie:Boolean):Void{
		model.login(name,pass,cookie);
	}

	public function logout():Void{

		view.disableApp();
		model.logout();

	}

	public function bookmarkPressed(book:Bookmark,target:String):Void{

		var t:String = (target)? target:model.getUserConfig().defaultTarget;
		getURL(book.url,t);

	}

	public function goHome():Void{

		var label:Label = new Label();
		label.id = "0";

		model.setNewLabel(label.id);

	}

	public function labelPressed(label:Label):Void{

		if(view.bookmarkForm){

			view.checkLabelInBookmark(label.title);

		} else {

			model.setNewLabel(label.id);

		}

	}

	public function pagePressed(pageNumber:Number):Void{
		model.setNewPage(pageNumber);
	}

	public function manageBookmark(action:String,book:Bookmark):Void{

		if(action != Constants.EMAIL){

			if(view.enabled){ view.disableApp(); }
			model.manageBookmark(action,book);

		} else {

			var subject:String = escape("Hi mate, check this link out");
			getURL("mailto:?Subject=" + subject + "&body=" + book.url );

		}

	}

	public function search(q:String):Void{
		model.search(q,true);
	}

	public function reloadCurrentLabel():Void{
		model.reloadCurrentLabel();
	}

	public function downloadSourceCode():Void{
		getURL("javascript:alert('Not yet! But soon :D');");
	}

	public function updateTitle(s:String):Void{
		getURL("javascript:updateTitle('" + escape(s) + "');");
	}

	public function setPageStatus(s:String):Void{
		getURL("javascript:changeStatus('" + escape(s) + "');");
	}

	// PRIVATE METHODS

	private function onResize():Void{
		view.updateSizeProperties(Stage.width,Stage.height);
	}

	private function onKeyDown():Void{

		if(Key.isDown(Key.CONTROL) && Key.isDown(76)){ // CTRL + L, login

			if(!model.isLoggedIn()){

				view.showLoginForm();
				return null;

			} else {

				model.logout();
				return null;

			}

		}

		if(Key.isDown(Key.CONTROL) && Key.isDown(75)){ // CTRL + K, login

			if(view.enabled && !focusOnTextField()){ view.focusSearchField(); }

		}

		switch(Key.getCode()){

			case(Key.ESCAPE):

				if(!view.enabled){

					view.removeAlert();

				} else if(view.focusIsOnSearch()){

					Selection.setFocus(null);

				} else if(view.bookmarkForm || view.loginForm){

					view.drawBookmarks();

				}

				break;

			case(Key.ENTER): // Enter

				if(view.enabled){

					if(view.focusIsOnSearch()){

						view.submitSearch();

					} else if(view.bookmarkForm){

						if(!view.focusIsOnLabels()){ view.submitBookForm(); }

					} else if(view.loginForm){

						trace("sending form");

						view.submitLoginForm();

					}

				} else {

					view.removeAlert();

				}

				break;

			case(116): // F5 reloadPage

				getURL("javascript:reloadPage();");
				break;

			case(65): // a addBookmark

				if(view.enabled && !focusOnTextField() && model.getUserConfig().edit){

					view.showBookmarkForm();

				}

				break;

			case(77): // m show loging form

				if(view.enabled && !focusOnTextField()){

					if(!model.isLoggedIn()){

						view.showLoginForm();

					} else {

						model.logout();

					}

				}

				break;

			case(72): // h home

				if(view.enabled && !focusOnTextField()){ goHome(); }
				break;

			case(76): // l focus next label

				if(view.enabled && !focusOnTextField()){ view.focusNextLabel(); }
				break;

			case(66): // b focus next bookmark

				if(view.enabled && !focusOnTextField()){ view.focusNextBookmark(); }
				break;

			case(189): // - previous page

				if(view.enabled && !focusOnTextField()){ model.previousPage(); }
				break;

			case(187): // + next page

				if(view.enabled && !focusOnTextField()){ model.nextPage(); }
				break;

		}

	}

	private function focusOnTextField():Boolean{
		return (MovieclipUtils.getFocusObject() instanceof TextField);
	}

	private function onMouseWheel():Void{

		//TODO move relevant scroll here

	}

}
import tv.zarate.projects.ZBooks.zbData;
import tv.zarate.projects.ZBooks.zbView;
import tv.zarate.utils.Delegate;
import tv.zarate.utils.FlashVars;

import tv.zarate.projects.ZBooks.Label;
import tv.zarate.projects.ZBooks.Bookmark;
import tv.zarate.projects.ZBooks.Config;

class tv.zarate.projects.ZBooks.zbModel{

	private var currentLabel:Label;
	private var view:zbView;
	private var data:zbData;
	private var userConfig:Config;
	private var flashVars:FlashVars;

	private var currentLabelID:String = "0";
	private var totalBookmarks:Number = 0;
	private var pages:Number = 1;
	private var currentPage:Number = 1;
	private var labels:Array;
	private var loggedIn:Boolean = false;
	private var currentUser:String = "1";
	private var timeLine_mc:MovieClip;
	private var externalAdded:Boolean = false;
	private var searching:Boolean = false;
	private var searchQuery:String = "";
	private var externalURL:String = "";

	public function zbModel(){}

	public function config(_view:zbView,m:MovieClip):Void{

		view = _view;
		timeLine_mc = m;

		flashVars = new FlashVars(timeLine_mc);

		currentUser = flashVars.initString("fv_user_id",currentUser);
		currentLabelID = flashVars.initString("fv_label_id",currentLabelID);

		var WSPath:String = flashVars.initString("fv_WSPath","");

		data = new zbData(currentUser,WSPath);

	}

	public function start():Void{
		data.getConfig(Delegate.create(this,configLoaded));
	}

	public function goToOwnPage():Void{

		/* we could do it with out reloading the whole page
		* but dont want to leave the old user_id in browser's address bar */

		getURL("?user_id=" + getUserConfig().user_id);

	}

	public function logout():Void{
		data.changeLogin("logout",Delegate.create(this,afterLoginProcess));
	}

	public function login(name:String,pass:String,cookie:Boolean):Void{
		data.changeLogin("login",Delegate.create(this,afterLoginProcess),name,pass,cookie);
	}

	public function nextPage():Void{
		if(currentPage < pages && pages > 1){ setNewPage(currentPage+1); }
	}

	public function previousPage():Void{
		if(currentPage > 1){ setNewPage(currentPage-1); }
	}

	public function setNewPage(page:Number):Void{

		view.disableApp();
		currentPage = page;

		if(searching){

			search(searchQuery,false);

		} else {

			var callback:Function = Delegate.create(this,dataXMLLoaded);
			data.getLabelData(currentLabelID,page,callback);

		}

	}

	public function setNewLabel(label_id:String,keepPage:Boolean):Void{

		searching = false;

		view.disableApp();
		currentLabelID = label_id;
		if(keepPage == undefined || keepPage == null){ currentPage = 1; }

		var callback:Function = Delegate.create(this,dataXMLLoaded);
		data.getLabelData(currentLabelID,currentPage,callback);

	}

	public function manageBookmark(action:String,book:Bookmark):Void{

		var callback:Function = Delegate.create(this,dataAdded);
		data.manageBookmark(action,book,callback);

	}

	public function search(q:String,begin:Boolean):Void{

		if(begin || begin == null){ currentPage = 1; }
		searching = true;
		searchQuery = q;

		var callback:Function = Delegate.create(this,dataXMLLoaded);
		data.search(q,currentLabelID,currentPage,callback);

	}

	public function reloadCurrentLabel():Void{

		var callback:Function = Delegate.create(this,dataXMLLoaded);
		data.getLabelData(currentLabelID,currentPage,callback);

	}

	public function getLabels():Array{
		return labels;
	}

	public function getCurrentLabel():Label{
		return currentLabel;
	}

	public function getUserConfig():Config{
		return userConfig;
	}

	public function lookingAtOwnBookmarks():Boolean{
		return (userConfig.user_id == currentUser);
	}

	public function isLoggedIn():Boolean{
		return loggedIn;
	}

	// PRIVATE METHODS

	private function configLoaded(confObj:Config,keepPage:Boolean):Void{

		userConfig = confObj;

		loggedIn = userConfig.edit;

		setNewLabel(currentLabelID,keepPage);

	}

	private function dataXMLLoaded(_currentLabel:Label,_labels:Array):Void{

		currentLabel = _currentLabel;
		labels = _labels;

		userConfig.owner = currentLabel.owner;
		pages = currentLabel.pages;

		if(searching){

			currentLabel.currentPage = currentPage;

		}

		view.startDraw();

		view.focusSearchField(searchQuery,(pages <= 1 && searchQuery != ""));

		externalURL = unescape(flashVars.initString("fv_url",""));

		if(externalURL != "" && !externalAdded){

			if(userConfig.edit == true){

				var externalTitle:String = unescape(flashVars.initString("fv_title",""));

				var b:Bookmark = new Bookmark();
				b.url = externalURL;
				b.title = externalTitle;

				view.showBookmarkForm(b,true);

			} else {

				view.showError("You must be logged in to add new links.");

			}

			externalAdded = true;

		}

	}

	private function afterLoginProcess(validLogin:Boolean,errorText:String):Void{

		loggedIn = validLogin;

		if(validLogin){

			data.getConfig(Delegate.create(this,configLoaded,true));

		} else {

			view.showError(errorText,Delegate.create(view,view.showLoginForm));

		}

	}

	private function dataAdded(success:Boolean,errorText:String):Void{

		if(success){

			if(externalAdded){

				getURL(unescape(externalURL));

			} else {

				var callback:Function = Delegate.create(this,dataXMLLoaded);
				data.getLabelData(currentLabelID,currentPage,callback);

			}

		} else {

			view.showError(errorText);

		}

	}

}
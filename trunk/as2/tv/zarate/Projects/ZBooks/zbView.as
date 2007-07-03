import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.TextfieldUtils;
import tv.zarate.Utils.MovieclipUtils;

import tv.zarate.components.SplitPanel;

import tv.zarate.Projects.ZBooks.zbModel;
import tv.zarate.Projects.ZBooks.zbController;
import tv.zarate.Projects.ZBooks.zbCheck;
import tv.zarate.Projects.ZBooks.zbAlert;
import tv.zarate.Projects.ZBooks.Label;
import tv.zarate.Projects.ZBooks.Bookmark;
import tv.zarate.Projects.ZBooks.Constants;

class tv.zarate.Projects.ZBooks.zbView{

	public var enabled:Boolean = true;
	public var appWidth:Number = 200;
	public var appHeight:Number = 200;
	public var bookmarkForm:Boolean = false;
	public var loginForm:Boolean = false;

	private var model:zbModel;
	private var controller:zbController;
	private var alert:zbAlert;
	private var formBook:Bookmark;
	private var bookmarksPanel:SplitPanel;
	private var labelsPanel:SplitPanel;

	private var bookFormAction:String = "";
	private var currentBookmarks:Array;
	private var currentBookmark:Number = 0;
	private var currentLabels:Array;
	private var currentLabel:Number = 0;
	private var searchField:TextField;
	private var headerNextX:Number = 0;
	private var bookmarksY:Number = 0;
	private var booksScrollWidth:Number = 0;
	private var labelsScrollWidth:Number = 0;

	// clips
	private var timeLine_mc:MovieClip;
	private var background_mc:MovieClip;
	private var block_mc:MovieClip;
	private var title_mc:MovieClip;
	private var bookmarks_mc:MovieClip;
	private var pages_mc:MovieClip;
	private var buttons_mc:MovieClip;
	private var addForm_mc:MovieClip;
	private var search_mc:MovieClip;
	private var login_mc:MovieClip
	private var alert_mc:MovieClip;
	private var labels_mc:MovieClip;

	// constants
	private var BLOCK_DEPTH:Number = 3000;
	private var ADDFORM_DEPTH:Number = 2000;
	private var ALERT_DEPTH:Number = 4000;

	private var TOPMARGIN:Number = 10;
	private var LEFTMARGIN:Number = 10;
	private var BOTTOMMARGIN:Number = 10;
	private var RIGHTMARGIN:Number = 10;
	private var MAINELEMENTSMARGIN:Number = 10;
	private var LABELSEPARATOR:String = ",";
	private var currentItem:String = "";

	private var OVER:String = "over";
	private var OUT:String = "out";
	private var TITLE_OVER:Number = 0xdedede;
	private var TITLE_OUT:Number = 0xffffff;

	// tab orders
	private var bookmarksTab:Number = 1000;
	private var formTab:Number = 4000;
	private var labelsTab:Number = 5000;
	private var menuTab:Number = 8000;
	private var modalWindowTab:Number = 10000;

	public function zbView(){}

	public function config(_model:zbModel,_controller:zbController,_timeLine_mc:MovieClip):Void{

		model = _model;
		controller = _controller;
		timeLine_mc = _timeLine_mc;

	}

	public function startDraw():Void{

		if(alert_mc){ removeAlert(); }

		var label:Label = model.getCurrentLabel();

		drawBackGround();
		drawTitle(label.title,label.totalBookmarks);
		drawLogin();
		drawBookmarks();
		drawLabels();
		drawPages(label.pages,label.currentPage);
		drawButtons();
		drawSearch();

		enableApp();

	}

	public function disableApp():Void{

		enabled = false;
		manageMainClips(false);

		block_mc = timeLine_mc.createEmptyMovieClip("block_mc",BLOCK_DEPTH);
		MovieclipUtils.DrawSquare(block_mc,0x000000,10,appWidth,appHeight);

		block_mc.tabEnabled = block_mc.useHandCursor = false;
		block_mc.onPress = function():Void{}

	}

	public function enableApp():Void{

		manageMainClips(true);
		block_mc.removeMovieClip();
		enabled = true;

	}

	public function showBookmarkForm(book:Bookmark,externalLink:Boolean):Void{

		bookmarkForm = true;

		delete formBook;

		if(book == null){

			bookFormAction = Constants.ADD;
			book = new Bookmark();

		} else {

			bookFormAction = (externalLink != null && externalLink == true)? Constants.ADD:Constants.EDIT;

		}

		formBook = book;

		var margin:Number = 3;
		var elementMargin:Number = 15;
		var nextY:Number = elementMargin;

		bookmarks_mc.removeMovieClip();

		addForm_mc = timeLine_mc.createEmptyMovieClip("addForm_mc",ADDFORM_DEPTH);
		addForm_mc._x = LEFTMARGIN;
		addForm_mc._y = bookmarksY;

		addContextMenu(addForm_mc);

		var fieldWidth:Number = 300//addForm_mc._width - (elementMargin*2);
		var fieldHeight:Number = 18;

		// title
		var bookmarkInputTitle_mc:MovieClip = addForm_mc.createEmptyMovieClip("bookmarkInputTitle_mc",1000);
		bookmarkInputTitle_mc._x = elementMargin;

		var field:TextField = TextfieldUtils.createField(bookmarkInputTitle_mc,fieldWidth,fieldHeight);
		field.text = "Bookmark title";
		field.setTextFormat(getFormat(""));

		bookmarkInputTitle_mc._y = nextY;
		nextY += bookmarkInputTitle_mc._height + margin;

		var bookmarkInput_mc:MovieClip = addForm_mc.createEmptyMovieClip("bookmarkInput_mc",1100);
		bookmarkInput_mc._x = elementMargin;

		field = TextfieldUtils.createInputField(bookmarkInput_mc,fieldWidth,fieldHeight);

		field.tabIndex = getTabIndex("form");
		field.border = true;
		field.text = book.title;
		field.setTextFormat(getFormat(""));
		field.setNewTextFormat(getFormat(""));
		Selection.setFocus(bookmarkInput_mc.field);

		bookmarkInput_mc._y = nextY;
		nextY += bookmarkInput_mc._height + elementMargin;

		// url
		var bookmarkInputURLTitle_mc:MovieClip = addForm_mc.createEmptyMovieClip("bookmarkInputURLTitle_mc",1200);
		bookmarkInputURLTitle_mc._x = elementMargin;

		field = TextfieldUtils.createField(bookmarkInputURLTitle_mc,fieldWidth,fieldHeight);
		field.text = "Bookmark URL";
		field.setTextFormat(getFormat(""));

		bookmarkInputURLTitle_mc._y = nextY;
		nextY += bookmarkInputURLTitle_mc._height + margin;

		var bookmarkInputURL_mc:MovieClip = addForm_mc.createEmptyMovieClip("bookmarkInputURL_mc",1300);
		bookmarkInputURL_mc._x = elementMargin;

		field = TextfieldUtils.createInputField(bookmarkInputURL_mc,fieldWidth,fieldHeight);
		field.tabIndex = getTabIndex("form");
		field.border = true;
		field.text = book.url;
		field.setTextFormat(getFormat(""));
		field.setNewTextFormat(getFormat(""));

		bookmarkInputURL_mc._y = nextY;
		nextY += bookmarkInputURL_mc._height + elementMargin;

		// label
		var labelInputTitle_mc:MovieClip = addForm_mc.createEmptyMovieClip("labelInputTitle_mc",1400);
		labelInputTitle_mc._x = elementMargin;

		field = TextfieldUtils.createField(labelInputTitle_mc,fieldWidth,fieldHeight);
		field.text = "Labels (separate with commas)";
		field.setTextFormat(getFormat(""));

		labelInputTitle_mc._y = nextY;
		nextY += labelInputTitle_mc._height + margin;

		var labelInput_mc:MovieClip = addForm_mc.createEmptyMovieClip("labelInput_mc",1500);
		labelInput_mc._x = elementMargin;

		var bookmarkLabels:Array = book.labels.split(",");
		var tmpLabels:String = "";

		if(book.labels != ""){

			for(var x:String in bookmarkLabels){ tmpLabels += getLabelFromID(bookmarkLabels[x]) + ","; }
			tmpLabels = tmpLabels.substr(0,tmpLabels.length-1);

		}

		field = field = TextfieldUtils.createInputField(labelInput_mc,fieldWidth,fieldHeight);
		field.tabIndex = getTabIndex("form");
		field.border = true;
		field.text = tmpLabels;
		field.setTextFormat(getFormat(""));
		field.setNewTextFormat(getFormat(""));

		labelInput_mc._y = nextY;
		nextY += labelInput_mc._height + elementMargin;

		// check
		var checkTitle_mc:MovieClip = addForm_mc.createEmptyMovieClip("checkTitle_mc",1600);

		field = TextfieldUtils.createField(checkTitle_mc);
		field.text = "Private?";
		field.setTextFormat(getFormat(""));

		checkTitle_mc._x = elementMargin;
		checkTitle_mc._y = nextY;

		var check_mc:MovieClip = addForm_mc.createEmptyMovieClip("check_mc",1700);
		check_mc._x = checkTitle_mc._x + checkTitle_mc._width + margin;
		check_mc._y = checkTitle_mc._y;

		var check:zbCheck = new zbCheck(check_mc);
		check.selected = (book.isPrivate == "1")? true:false;
		check.tabIndex = getTabIndex("form");

		addForm_mc.check = check;

		nextY += check_mc._height + elementMargin;

		var accept_mc:MovieClip = addForm_mc.createEmptyMovieClip("accept_mc",1800);
		accept_mc._x = 90;
		accept_mc._y = nextY;

		createButton(accept_mc,"Accept",Delegate.create(this,getFormData),getTabIndex("form"));

		var cancel_mc:MovieClip = addForm_mc.createEmptyMovieClip("cancel_mc",1900);
		cancel_mc._x = accept_mc._x + accept_mc._width + elementMargin;
		cancel_mc._y = nextY;

		createButton(cancel_mc,"Cancel",Delegate.create(this,drawBookmarks),getTabIndex("form"));

		nextY += cancel_mc._height + elementMargin;

	}

	public function updateSizeProperties(w:Number,h:Number):Void{

		appWidth = w;
		appHeight = h;

		labels_mc._x = appWidth - labels_mc._width - RIGHTMARGIN;
		search_mc._x = appWidth - search_mc._width - RIGHTMARGIN;

		if(!enabled){ addForm_mc._x = Math.round((w/2) - (addForm_mc._width/2)); }

		booksScrollWidth = Math.round((appWidth*0.7) - LEFTMARGIN - RIGHTMARGIN);
		labelsScrollWidth = Math.round((appWidth*0.3) - LEFTMARGIN - RIGHTMARGIN);

		drawBackGround();

	}

	public function showError(errorText:String,callback:Function,updateCurrentItem:Boolean):Void{

		if(updateCurrentItem == null || updateCurrentItem){ currentItem = Selection.getFocus(); }

		Selection.setFocus(null);

		var margin:Number = 5;

		if(callback == undefined){ callback = Delegate.create(controller,controller.reloadCurrentLabel); }

		alert = createAlert(callback);

		var error_mc:MovieClip = alert_mc.createEmptyMovieClip("error_mc",1000);
		error_mc._x = margin;
		error_mc._y = margin;

		var field:TextField = TextfieldUtils.createMultilineField(error_mc,alert_mc._width-(margin*2));
		field.text = errorText;
		field.setTextFormat(getFormat(""));

	}

	public function removeAlert():Void{

		alert.remove();
		delete alert;

		if(currentItem != "" && currentItem != null){

			Selection.setFocus(currentItem);
			currentItem = "";

		}

		enableApp();

	}

	public function submitLoginForm():Void{
		gatherLoginData();
	}

	public function submitBookForm():Void{

		if(!MovieclipUtils.hasFocus(addForm_mc.accept_mc)){

			getFormData();

		}

	}

	public function submitSearch():Void{

		disableApp();
		getSearchFormData();

	}

	public function focusIsOnLabels():Boolean{

		var s:String = Selection.getFocus();
		return (s.indexOf("labels_mc") != -1);

	}

	public function focusIsOnSearch():Boolean{
		return (MovieclipUtils.getFocusObject() == searchField);
	}

	public function focusNextBookmark():Void{

		Selection.setFocus(currentBookmarks[currentBookmark]);
		currentBookmark++;
		if(currentBookmark >= currentBookmarks.length){ currentBookmark = 0; }

	}

	public function focusNextLabel():Void{

		Selection.setFocus(currentLabels[currentLabel]);
		currentLabel++;
		if(currentLabel >= currentLabels.length){ currentLabel = 0; }

	}

	public function focusSearchField(initValue:String,focus:Boolean):Void{

		if(initValue != null){ searchField.text = unescape(initValue); } else { searchField.text = ""; }
		if(focus || focus == null){ Selection.setFocus(searchField); }

	}

	public function showLoginForm():Void{

		removeAlert();

		loginForm = true;

		var elementMargin:Number = 15;
		var nextY:Number = elementMargin;
		var margin:Number = 5;

		var fieldWidth:Number = 300//addForm_mc._width - (elementMargin*2);
		var fieldHeight:Number = 18;

		bookmarks_mc.removeMovieClip();

		addForm_mc = timeLine_mc.createEmptyMovieClip("addForm_mc",ADDFORM_DEPTH);
		addForm_mc._x = LEFTMARGIN;
		addForm_mc._y = bookmarksY;

		addContextMenu(addForm_mc);

		// name
		var nameInputTitle_mc:MovieClip = addForm_mc.createEmptyMovieClip("nameInputTitle_mc",1000);
		nameInputTitle_mc._x = elementMargin;
		nameInputTitle_mc._y = elementMargin;

		var field:TextField = TextfieldUtils.createField(nameInputTitle_mc,fieldWidth,fieldHeight);
		field.tabIndex = getTabIndex("form");
		field.text = "Username";
		field.setTextFormat(getFormat(""));

		nextY += nameInputTitle_mc._height + margin;

		var nameInput_mc:MovieClip = addForm_mc.createEmptyMovieClip("nameInput_mc",1100);
		nameInput_mc._x = elementMargin;
		nameInput_mc._y = nextY;

		field = TextfieldUtils.createInputField(nameInput_mc,fieldWidth,fieldHeight);

		field.tabIndex = getTabIndex("form");
		field.border = true;
		field.text = "";
		field.setTextFormat(getFormat(""));
		field.setNewTextFormat(getFormat(""));
		Selection.setFocus(nameInput_mc.field);

		nextY += nameInput_mc._height + margin;

		// pass
		var passTitle_mc:MovieClip = addForm_mc.createEmptyMovieClip("passTitle_mc",1200);
		passTitle_mc._x = elementMargin;
		passTitle_mc._y = nextY;

		field = TextfieldUtils.createField(passTitle_mc,fieldWidth,fieldHeight);
		field.tabIndex = getTabIndex("form");
		field.text = "Password";
		field.setTextFormat(getFormat(""));

		nextY += passTitle_mc._height + margin;

		var passInput_mc:MovieClip = addForm_mc.createEmptyMovieClip("passInput_mc",1300);
		passInput_mc._x = elementMargin;
		passInput_mc._y = nextY;

		field = TextfieldUtils.createInputField(passInput_mc,fieldWidth,fieldHeight);

		field.tabIndex = getTabIndex("form");
		field.border = true;
		field.text = "";
		field.password = true;
		field.setTextFormat(getFormat(""));
		field.setNewTextFormat(getFormat(""));

		nextY += passInput_mc._height + margin;

		var cookie_mc:MovieClip = addForm_mc.createEmptyMovieClip("cookie_mc",1350);

		var check:zbCheck = new zbCheck(cookie_mc);
		check.selected = false;
		check.tabIndex = getTabIndex("form");

		cookie_mc._x = elementMargin;
		cookie_mc._y = nextY;
		nextY += cookie_mc._height + margin;

		addForm_mc	.check = check;

		var accept_mc:MovieClip = addForm_mc.createEmptyMovieClip("accept_mc",1400);

		createButton(accept_mc,"Accept",Delegate.create(this,gatherLoginData),getTabIndex("form"));

		accept_mc._x = elementMargin;
		accept_mc._y = nextY;

		var cancel_mc:MovieClip = addForm_mc.createEmptyMovieClip("cancel_mc",1500);

		createButton(cancel_mc,"Cancel",Delegate.create(this,drawBookmarks),getTabIndex("form"));

		cancel_mc._x = accept_mc._x + accept_mc._width + margin;
		cancel_mc._y = nextY;

		nextY += cancel_mc._height + margin;

	}

	public function checkLabelInBookmark(labelTitle:String):Void{

		var initString:String = addForm_mc.labelInput_mc.field.text;
		var finalString:String;
		var found:Boolean = false;
		var currentLabels:Array = initString.split(LABELSEPARATOR);

		for(var x:Number=0;x<currentLabels.length;x++){

			if(labelTitle == currentLabels[x]){

				currentLabels.splice(x,1);
				found = true;
				break;

			}

		}

		if(!found){

			currentLabels.push(labelTitle);

		}

		finalString = currentLabels.join(LABELSEPARATOR);
		if(initString == "") finalString = finalString.substring(1,finalString.length);

		addForm_mc.labelInput_mc.field.text = finalString;

	}

	public function getTabIndex(type:String):Number{

		var index:Number = -1;

		switch(type){

			case("bookmark"):
				index = bookmarksTab; bookmarksTab++; break;
			case("label"):
				index = labelsTab; labelsTab++; break;
			case("menu"):
				index = menuTab; menuTab++; break;
			case("form"):
				index = formTab; formTab++; break;
			case("modal"):
				index = modalWindowTab; modalWindowTab++; break;

		}

		return index;

	}

	public function getFormat(type:String):TextFormat{

		var format:TextFormat = new TextFormat();

		switch(type){
			case("mainTitle"):
				format.font = "optane"; format.size = 16; format.bold = true; break;
			case("title"):
				format.font = "optane"; format.size = 14; format.bold = true; break;
			case("privateBookmark"):
				format.font = "optane"; format.size = 14; format.bold = true; format.color = 0x918686; break;
			case("alert"):
				format.font = "optane"; format.size = 10; format.bold = true; format.color = 0xff0000; break;
			case("pages"):
				format.font = "optane"; format.size = 11; break;
			case("notCurrentPage"):
				format.font = "optane"; format.size = 11; format.bold = true; break;
			case("buttons"):
				format.font = "optane"; format.size = 11; format.bold = true; break;
			case("label"):
				format.font = "optane"; format.size = 12; break;
			default:
				format.font = "optane"; format.size = 10; break;
		}

		return format;

	}

	public function drawBookmarks():Void{

		bookmarkForm = loginForm = false;

		var nextY:Number = 0;
		var margin:Number = 15;

		var bookmarks:Array = model.getCurrentLabel().bookmarks;

		currentBookmarks = new Array();
		currentBookmark = 0;

		addForm_mc.removeMovieClip();

		bookmarks_mc = timeLine_mc.createEmptyMovieClip("bookmarks_mc",200);
		bookmarks_mc._x = LEFTMARGIN;
		bookmarks_mc._y = bookmarksY;

		bookmarksPanel = new SplitPanel(bookmarks_mc,10);
		bookmarksPanel.setSize(booksScrollWidth,appHeight - bookmarks_mc._y - BOTTOMMARGIN);

		var actualBookmarks_mc:MovieClip = bookmarksPanel.getContentMC();

		var lng:Number = bookmarks.length;

		for(var x:Number=0;x<lng;x++){

			var book:Bookmark = bookmarks[x];

			var book_mc:MovieClip = actualBookmarks_mc.createEmptyMovieClip("book_"+x,100+x);
			book_mc._y = nextY;

			// title
			var title_mc:MovieClip = book_mc.createEmptyMovieClip("title_mc",100);
			addContextMenu(title_mc,"bookmark",book);

			currentBookmarks.push(title_mc);

			var title:String = book.title;
			if(book.isPDF){ title += " [PDF]"; }

			var field:TextField = TextfieldUtils.createMultilineField(title_mc,600);
			field.text = title;
			field.setTextFormat(getFormat((book.isPrivate == "1")? "privateBookmark":"title"));

			var titlebc_mc:MovieClip = title_mc.createEmptyMovieClip("titlebc_mc",50);
			MovieclipUtils.DrawSquare(titlebc_mc,TITLE_OUT,100,title_mc._width,title_mc._height);

			title_mc.tabIndex = getTabIndex("bookmark");
			title_mc.onPress = Delegate.create(controller,controller.bookmarkPressed,book);

			title_mc.onRollOver = Delegate.create(this,manageBookmarkTitle,OVER,book,title_mc);
			title_mc.onRollOut = Delegate.create(this,manageBookmarkTitle,OUT,book,title_mc);
			title_mc.onSetFocus = Delegate.createR(this,itemFocus,book_mc,bookmarksPanel);

			nextY = title_mc._y + title_mc._height;

			if(model.getUserConfig().showURL){

				// url
				var url_mc:MovieClip = book_mc.createEmptyMovieClip("url_mc",150);
				url_mc._y = nextY;

				addContextMenu(url_mc,"bookmark",bookmarks[x]);

				field = TextfieldUtils.createMultilineField(url_mc,600);
				field.text = book.url;
				field.setTextFormat(getFormat(""));

				url_mc.tabIndex = getTabIndex("bookmark");
				url_mc.onPress = Delegate.create(controller,controller.bookmarkPressed,book);

				nextY += url_mc._height;

			}

			// bookmark labels
			var labels_mc:MovieClip = book_mc.createEmptyMovieClip("edit_mc",200);
			labels_mc._x = title_mc._x;
			labels_mc._y = nextY;
			labels_mc.onSetFocus = Delegate.createR(this,itemFocus,book_mc,bookmarksPanel);

			var nextLabelX:Number = 0;
			var arrLabels:Array = book.labels.split(",");

			for(var i:Number=0;i<arrLabels.length;i++){

				var label:Label = new Label();
				label.id = arrLabels[i];

				var label_mc:MovieClip = labels_mc.createEmptyMovieClip("label_"+i,100+i);
				var label_title:String = getLabelFromID(label.id);

				field = TextfieldUtils.createField(label_mc);
				field.text = ((i > 0)? "| ":"") + label_title;
				field.setTextFormat(getFormat(""));

				label_mc._x = nextLabelX;
				nextLabelX += label_mc._width;

				label_mc.tabIndex = getTabIndex("bookmark");
				label_mc.onPress = Delegate.create(controller,controller.labelPressed,label);

			}

			// date
			var date_mc:MovieClip = book_mc.createEmptyMovieClip("date_mc",300);
			date_mc._x = labels_mc._x + labels_mc._width + margin;
			date_mc._y = labels_mc._y;

			date_mc.createTextField("field",100,0,0,0,0);
			field = date_mc.field;
			field.autoSize = true;
			field.text = book.date;
			field.setTextFormat(getFormat(""));

			if(model.getUserConfig().edit){

				// edit
				var edit_mc:MovieClip = book_mc.createEmptyMovieClip("edit_mc",400);
				addContextMenu(edit_mc);
				edit_mc._x = date_mc._x + date_mc._width + 20;
				edit_mc._y = date_mc._y;

				field = TextfieldUtils.createField(edit_mc);
				field.text = "Edit";
				field.setTextFormat(getFormat(""));

				edit_mc.tabIndex = getTabIndex("bookmark");
				edit_mc.onPress = Delegate.create(this,showBookmarkForm,book);

				// delete
				var delete_mc:MovieClip = book_mc.createEmptyMovieClip("delete_mc",500);
				addContextMenu(delete_mc);
				delete_mc._x = edit_mc._x + edit_mc._width + 5;
				delete_mc._y = edit_mc._y;

				field = TextfieldUtils.createField(delete_mc);
				field.text = "Delete";
				field.setTextFormat(getFormat(""));

				delete_mc.tabIndex = getTabIndex("bookmark");
				delete_mc.onPress = Delegate.create(this,confirmDelete,book_mc,book);
				delete_mc.onSetFocus = Delegate.createR(this,itemFocus,book_mc,bookmarksPanel);

			}

			// nextY
			nextY = book_mc._y + book_mc._height + margin;

		}

		if(lng <= 0){

			var noBooks_mc:MovieClip = actualBookmarks_mc.createEmptyMovieClip("noBooks_mc",100);
			noBooks_mc._y = nextY;

			var field:TextField = TextfieldUtils.createField(noBooks_mc);
			field.text = "No records :(";
			field.setTextFormat(getFormat(""));

		}

		bookmarksPanel.refreshScroll();

	}

	// ************************ PRIVATE METHODS ************************

	private function manageBookmarkTitle(action:String,book:Bookmark,mc:MovieClip):Void{

		var col:Number = (action == OVER)? TITLE_OVER:TITLE_OUT;
		MovieclipUtils.changeColour(mc.titlebc_mc,col);

		var status:String = (action == OVER)? book.url:"";
		controller.setPageStatus(status);

	}

	private function gatherLoginData():Void{

		if(eval(Selection.getFocus()) == addForm_mc.cancel_mc){ return null; }

		var name:String = addForm_mc.nameInput_mc.field.text;
		var pass:String = addForm_mc.passInput_mc.field.text;
		var cookie:Boolean = (addForm_mc.check.selected)? true:false;

		if(name != "" && pass != ""){

			loginForm = false;
			controller.login(name,pass,cookie);

		} else {

			currentItem = (name == "")? addForm_mc.nameInput_mc.field:addForm_mc.passInput_mc.field;
			showError("Please enter both username and password",Delegate.create(this,removeAlert),false);

		}

	}

	private function drawBackGround():Void{

		background_mc = timeLine_mc.createEmptyMovieClip("background_mc",50);
		MovieclipUtils.DrawSquare(background_mc,0xffffff,100,appWidth,appHeight);

		addContextMenu(background_mc,"background",null);

	}

	private function drawTitle(labelTitle:String,totalBookmarks:Number):Void{

		title_mc = timeLine_mc.createEmptyMovieClip("title_mc",100);
		title_mc._x = LEFTMARGIN;
		title_mc._y = TOPMARGIN;

		// home btn
		var home_btn:MovieClip = title_mc.createEmptyMovieClip("home_btn",50);
		addContextMenu(home_btn);

		var field:TextField = TextfieldUtils.createField(home_btn);
		field.text = model.getUserConfig().owner;
		field.setTextFormat(getFormat("mainTitle"));

		home_btn.tabIndex = getTabIndex("menu");
		home_btn.onPress = Delegate.create(controller,controller.goHome);

		// label title
		field = TextfieldUtils.createField(title_mc);
		field._x = home_btn._width;
		field.text = labelTitle + "    " + totalBookmarks + " bookmark" + ((totalBookmarks == 1)? "":"s") + ".";
		field.setTextFormat(getFormat("mainTitle"));
		field.setTextFormat(labelTitle.length,field.text.length,getFormat(""));

		controller.updateTitle(model.getUserConfig().owner + " - " + labelTitle);

		headerNextX = title_mc._x + title_mc._width + MAINELEMENTSMARGIN;

	}

	private function drawSearch():Void{

		search_mc = timeLine_mc.createEmptyMovieClip("search_mc",150);

		// input
		searchField = TextfieldUtils.createInputField(search_mc,200,20);
		searchField.tabIndex = getTabIndex("menu");
		searchField.border = true;
		searchField.setTextFormat(getFormat(""));
		searchField.setNewTextFormat(getFormat(""));

		// button
		var search_btn:MovieClip = search_mc.createEmptyMovieClip("search_btn",200);
		addContextMenu(search_btn);
		search_btn._x = searchField._x + searchField._width + 10;

		var field:TextField = TextfieldUtils.createField(search_btn);
		field.text = "Search";
		field.setTextFormat(getFormat("title"));

		search_btn.tabIndex = getTabIndex("menu");
		search_btn.onPress = Delegate.create(this,getSearchFormData);

		search_mc._x = appWidth - search_mc._width - RIGHTMARGIN;
		search_mc._y = TOPMARGIN;

	}

	private function drawLabels():Void{

		var iniX:Number = 0;
		var nextX:Number = iniX;
		var nextY:Number = 0;
		var margin:Number = 0;
		var labelsWidth:Number = labelsScrollWidth;
		var counter:Number = 0;

		labels_mc = timeLine_mc.createEmptyMovieClip("labels_mc",300);

		labels_mc._x = appWidth - labelsWidth - RIGHTMARGIN;
		labels_mc._y = bookmarksY;

		labelsPanel = new SplitPanel(labels_mc,50);
		labelsPanel.setSize(labelsWidth,appHeight - labels_mc._y - BOTTOMMARGIN);

		//labelsWidth = labelsScrollWidth;

		var actualLabels_mc:MovieClip = labelsPanel.getContentMC();

		var labels:Array = model.getLabels();

		currentLabels = new Array();
		currentLabel = 0;

		for(var x:Number=0;x<labels.length;x++){

			var label:Label = labels[x];

			var label_mc:MovieClip = actualLabels_mc.createEmptyMovieClip("label_"+x,100+counter);
			counter++;

			currentLabels.push(label_mc);

			var field:TextField = TextfieldUtils.createField(label_mc);
			field.text = label.title;
			field.setTextFormat(getFormat("label"));

			label_mc.tabIndex = getTabIndex("label");
			label_mc.focusEnabled = true;
			label_mc.onPress = Delegate.create(controller,controller.labelPressed,label);
			label_mc.onSetFocus = Delegate.createR(this,itemFocus,label_mc,labelsPanel);

			label_mc._x = nextX;
			label_mc._y = nextY;

			nextY += label_mc._height + margin;

			addContextMenu(label_mc,"label",label);

		}

		labelsPanel.refreshScroll();

	}

	private function drawPages(pages:Number,currentPage:Number):Void{

		var nextX:Number = 0;
		var margin:Number = 0;

		pages_mc = timeLine_mc.createEmptyMovieClip("pages_mc",400);

		if(pages > 0){

			var pagesInfo_mc:MovieClip = pages_mc.createEmptyMovieClip("pagesInfo_mc",90);
			pagesInfo_mc.createTextField("field",100,0,0,0,0);

			var field:TextField = pagesInfo_mc.field;
			field.autoSize = true;
			field.text = "Page " + currentPage + " of " + pages;
			field.setTextFormat(getFormat(""));

			nextX = pagesInfo_mc._x + pagesInfo_mc._width + 5;

			for(var x:Number=0;x<2;x++){

				var page_mc:MovieClip = pages_mc.createEmptyMovieClip("page_"+x,100+x);

				field = TextfieldUtils.createField(page_mc);
				field.text = (x == 0)? "Previous /":"Next";
				field.setTextFormat(getFormat("pages"));

				if((x == 0 && currentPage > 1) || (x > 0 && currentPage < pages)){

					field.setTextFormat(getFormat("notCurrentPage"));
					var pageNumber:Number = (x == 0)? currentPage-1:currentPage+1;

					page_mc.tabIndex = getTabIndex("menu");
					page_mc.onPress = Delegate.create(controller,controller.pagePressed,pageNumber);

				}

				page_mc._x = nextX;
				nextX += page_mc._width + margin;

			}

		}

		pages_mc._x = headerNextX;
		pages_mc._y = title_mc._y + title_mc._height - pages_mc._height;

		headerNextX = pages_mc._x + pages_mc._width + MAINELEMENTSMARGIN;

	}

	private function drawButtons():Void{

		var margin:Number = 5;

		buttons_mc = timeLine_mc.createEmptyMovieClip("buttons_mc",500);

		if(model.getUserConfig().edit){

			// add bookmark
			var addBookmark_mc:MovieClip = buttons_mc.createEmptyMovieClip("addBookmark_mc",100);

			var field:TextField = TextfieldUtils.createField(addBookmark_mc);
			field.text = "Add Bookmark";
			field.setTextFormat(getFormat("buttons"));

			addBookmark_mc.tabIndex = getTabIndex("menu");
			addBookmark_mc.onPress = Delegate.create(this,showBookmarkForm);

			buttons_mc._x = headerNextX;
			buttons_mc._y = title_mc._y + title_mc._height - buttons_mc._height;

			headerNextX = buttons_mc._x + buttons_mc._width + MAINELEMENTSMARGIN;

		}

	}

	private function drawLogin():Void{

		var field:TextField;
		var buttonFunction:Function;

		login_mc = timeLine_mc.createEmptyMovieClip("login_mc",175);
		login_mc._x = LEFTMARGIN;
		login_mc._y = title_mc._y + title_mc._height + 3;

		var log_mc:MovieClip = login_mc.createEmptyMovieClip("log_mc",100);
		field = TextfieldUtils.createField(log_mc);
		field.setNewTextFormat(getFormat(""));

		log_mc.tabIndex = getTabIndex("menu");

		if(model.getUserConfig().user_id != 1){

			field.text = "You are logged in as " + model.getUserConfig().name + ", click here to logout.";
			buttonFunction = Delegate.create(controller,controller.logout);

			if(!model.lookingAtOwnBookmarks()){

				var ownBooks_mc:MovieClip = login_mc.createEmptyMovieClip("ownBooks_mc",200);
				ownBooks_mc._x = log_mc._x + log_mc._width + MAINELEMENTSMARGIN;

				field = TextfieldUtils.createField(ownBooks_mc);
				field.text = "Go to your own page.";
				field.background = true;
				field.backgroundColor = 0xccffcc;
				field.setTextFormat(getFormat(""));

				ownBooks_mc.tabIndex = getTabIndex("menu");
				ownBooks_mc.onPress = Delegate.create(controller,controller.goToOwnPage);

			}

		} else {

			field.text = "You are NOT logged in, click here to proceed";
			field.background = true;
			field.backgroundColor = 0xffcccc;
			buttonFunction = Delegate.create(this,showLoginForm);

		}

		log_mc.onPress = buttonFunction;

		bookmarksY = login_mc._y + login_mc._height + MAINELEMENTSMARGIN;

	}

	private function createAlert(acceptCallback:Function,cancel:Boolean):zbAlert{

		var cancelCallback:Function;

		disableApp();

		alert_mc = timeLine_mc.createEmptyMovieClip("alert_mc",ALERT_DEPTH);
		addContextMenu(alert_mc);

		if(cancel){ cancelCallback = Delegate.create(this,removeAlert); }

		var alert:zbAlert = new zbAlert(this,alert_mc,acceptCallback,cancel,cancelCallback);

		return alert;

	}

	private function confirmDelete(book_mc:MovieClip,book:Bookmark):Void{

		book_mc.delete_mc.field.text = "CONFIRM?";
		book_mc.delete_mc.field.setTextFormat(getFormat("alert"));

		Selection.setFocus(book_mc.delete_mc);

		book_mc.delete_mc.onPress = Delegate.create(controller,controller.manageBookmark,Constants.REMOVE,book);

	}

	private function getSearchFormData():Void{

		var query:String = escape(searchField.text);

		if(query != ""){

			controller.search(query);

		} else {

			showError("Empty search.");

		}

	}

	private function getFormData():Void{

		var book:Bookmark = formBook;

		var _title:String = addForm_mc.bookmarkInput_mc.field.text;
		var _url:String = addForm_mc.bookmarkInputURL_mc.field.text;
		var _label:String = addForm_mc.labelInput_mc.field.text;
		var _isPrivate:Boolean = (addForm_mc.check.selected)? true:false;

		if(_title != "" && _url != "" && _label != ""){

			book.title = _title;
			book.url = _url;
			book.labels = _label;
			book.isPrivate = _isPrivate;

			controller.manageBookmark(bookFormAction,book);

		} else {

			showError("All fields are mandatory",Delegate.create(this,showBookmarkForm,book),false);

		}

	}

	private function addContextMenu(mc:MovieClip,type:String,obj:Object):Void{

		var menu_cm:ContextMenu = new ContextMenu();
		menu_cm.hideBuiltInItems();

		switch(type){

			case("bookmark"):

				var book:Bookmark = Bookmark(obj);

				menu_cm.customItems.push(new ContextMenuItem("Open in this window",Delegate.createR(controller,controller.bookmarkPressed,book,"_self")));
				menu_cm.customItems.push(new ContextMenuItem("Open in other window",Delegate.createR(controller,controller.bookmarkPressed,book,"_blank")));
				menu_cm.customItems.push(new ContextMenuItem("EMail",Delegate.createR(controller,controller.manageBookmark,Constants.EMAIL,book)));

				if(model.getUserConfig().edit){

					menu_cm.customItems.push(new ContextMenuItem("Edit bookmark",Delegate.createR(this,showBookmarkForm,book)));
					menu_cm.customItems.push(new ContextMenuItem("Delete bookmark",Delegate.createR(controller,controller.manageBookmark,Constants.REMOVE,book)));

				}

				break;

			case("label"):

				var label:Label = Label(obj);

				menu_cm.customItems.push(new ContextMenuItem("Show label",Delegate.createR(controller,controller.labelPressed,label)));
				break;

		}

		menu_cm.customItems.push(new ContextMenuItem("Download Source Code",Delegate.createR(controller,controller.downloadSourceCode),true));

		mc.menu = menu_cm;

	}

	private function manageMainClips(action:Boolean):Void{

		bookmarks_mc.tabChildren = bookmarks_mc.tabEnabled = action;
		labels_mc.tabChildren = labels_mc.tabEnabled = action;
		search_mc.tabChildren = search_mc.tabEnabled = action;
		buttons_mc.tabChildren = buttons_mc.tabEnabled = action;
		title_mc.tabChildren = title_mc.tabEnabled = action;
		pages_mc.tabChildren = pages_mc.tabEnabled = action;
		login_mc.tabChildren = login_mc.tabEnabled = action;
		addForm_mc.tabChildren = addForm_mc.tabEnabled = action;

		if(action){ bookmarksPanel.enable(); } else { bookmarksPanel.disable(); }
		if(action){ labelsPanel.enable(); } else { labelsPanel.disable(); }

	}

	private function createButton(mc:MovieClip,txt:String,callback:Function,tabIndex:Number):Void{

		var field:TextField = TextfieldUtils.createField(mc);
		field.text = txt;
		field.setTextFormat(getFormat(""));

		mc.tabIndex = tabIndex;
		mc.onPress = callback;

	}

	private function getLabelFromID(label_id:String):String{

		var title:String = "";

		var labels:Array = model.getLabels();

		for(var x:String in labels){

			var l:Label = labels[x];

			if(label_id == l.id){

				title = l.title;
				break;

			}

		}
		return title;

	}

	private function itemFocus(mc:MovieClip,panel:SplitPanel):Void{
		panel.moveToClip(mc);
	}

}
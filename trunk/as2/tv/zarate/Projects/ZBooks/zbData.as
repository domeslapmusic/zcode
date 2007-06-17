import com.meychi.ascrypt.MD5;

import tv.zarate.Utils.Delegate;

import tv.zarate.Projects.ZBooks.Label;
import tv.zarate.Projects.ZBooks.Bookmark;
import tv.zarate.Projects.ZBooks.Config;

class tv.zarate.Projects.ZBooks.zbData{

	private var WSPath:String = "";
	private var dataXML:XML;
	private var currentUser:String = "1";
	private var serverKey:String = "";

	function zbData(_currentUser:String,timeLine_mc:MovieClip){

		WSPath = (timeLine_mc.fv_WSPath)? timeLine_mc.fv_WSPath:WSPath; // we can override this property via FlashVars
		currentUser = _currentUser;

	}

	public function changeLogin(action:String,callback:Function,username:String,password:String,cookie:Boolean):Void{

		var hashedPass:String = MD5.calculate(password);
		var combinedHashed:String = MD5.calculate(hashedPass + serverKey);

		var query:String = WSPath+"?action=" + action;
		if(action == "login"){ query += "&username=" + username + "&password=" + combinedHashed + "&useCookie=" + cookie; }

		dataXML = new XML();
		dataXML.ignoreWhite = true;
		dataXML.addRequestHeader("Connection","'close'");
		dataXML.onLoad = Delegate.create(this,loginFinish,callback);
		dataXML.sendAndLoad(query,dataXML);

	}

	public function search(q:String,label_id:String,currentPage:Number,scope:Object,callback:Function):Void{

		dataXML = new XML();
		dataXML.ignoreWhite = true;
		dataXML.onLoad = Delegate.create(this,xmlLoaded,scope,callback);
		dataXML.sendAndLoad(WSPath+"?action=search&query="+q+"&user_id="+currentUser+"&page="+currentPage,dataXML);

	}

	public function getLabelData(label_id:String,currentPage:Number,scope:Object,callback:Function):Void{

		dataXML = new XML();
		dataXML.ignoreWhite = true;
		dataXML.onLoad = Delegate.create(this,xmlLoaded,scope,callback);
		dataXML.sendAndLoad(WSPath+"?user_id="+currentUser+"&label_id="+label_id+"&currentPage="+currentPage,dataXML);

	}

	public function manageBookmark(action:String,book:Bookmark,scope:Object,callback:Function):Void{

		book.title = escape(book.title);
		book.url = escape(book.url);
		book.labels = escape(book.labels);

		var path:String = WSPath+"?action="+action+"&bookmark_id="+book.id+"&private="+((book.isPrivate)? "1":"0")+"&title="+book.title+"&url="+book.url+"&label="+book.labels;

		dataXML = new XML();
		dataXML.ignoreWhite = true;
		dataXML.addRequestHeader("Connection","'close'");
		dataXML.onLoad = Delegate.create(this,dataAdded,scope,callback);
		dataXML.sendAndLoad(path,dataXML);

	}

	public function getConfig(callback:Function):Void{

		var configXML:XML = new XML();
		configXML.ignoreWhite = true;
		configXML.onLoad = Delegate.create(this,configLoaded,configXML,callback);
		configXML.sendAndLoad(WSPath+"?user_id="+currentUser+"&action=getConfig",configXML);

	}

	// PRIVATE METHODS

	private function loginFinish(success:Boolean,callback:Function):Void{

		var error:Boolean = (dataXML.firstChild.attributes["error"] == "true")? true:false;
		var errorText:String = dataXML.firstChild.childNodes[0].childNodes[0].nodeValue;

		callback(error,errorText);

	}

	private function configLoaded(success:Boolean,configXML:XML,callback:Function):Void{

		if(success){

			var userConfig:Config = new Config();
			userConfig.setXML(configXML);

			serverKey = userConfig.key;

			callback(userConfig);

		}

	}

	private function xmlLoaded(success:Boolean,scope:Object,callback:Function):Void{

		if(success){

			// current label
			var currentLabel:Label = new Label();
			currentLabel.setXML(dataXML.firstChild.childNodes[0]);

			// labels

			var labels:Array = new Array();

			var lng:Number = dataXML.firstChild.childNodes[1].childNodes.length;

			for(var x:Number=0;x<lng;x++){

				var node:XMLNode = dataXML.firstChild.childNodes[1].childNodes[x];

				var l:Label = new Label();

				l.title = unescape(node.childNodes[0].nodeValue);
				l.id = node.attributes["id"];
				l.isPrivate = node.attributes["private"];

				labels.push(l);

			}

			delete dataXML;

			callback.apply(scope,[currentLabel,labels]);

		}

	}

	private function dataAdded(success:Boolean,scope:Object,callback:Function):Void{

		var result:Boolean = (dataXML.firstChild.attributes["error"] == "false")? true:false;
		var errorText:String = dataXML.firstChild.childNodes[0].childNodes[0].toString();
		callback.apply(scope,[result,errorText]);

	}

}
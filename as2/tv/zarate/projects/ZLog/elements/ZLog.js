ZLog = function(htmldiv){

	this.htmldiv = document.getElementById(htmldiv);
	this.running = true;
	this.clear();
	this.update("Setting up ZLog...","",false);

}

ZLog.prototype.update = function(s,type,reset){

	if(reset == true){ this.reset(); }

	if(this.running){

		this.htmldiv.innerHTML += "<br/>" + '<span class="' + type + '"><strong>' + this.getDate() + "</strong> - " + unescape(s) + '</span>';
		this.moveToBottom();

	}

}

ZLog.prototype.moveToBottom = function(){
    window.scrollTo(0,this.htmldiv.scrollHeight);
}

ZLog.prototype.addBlankLine = function(){

	this.htmldiv.innerHTML += "<br/>";
    this.moveToBottom();
    
}

ZLog.prototype.pause = function(){

	this.running = !this.running;
	document.getElementById("pauselink").innerHTML = (this.running)? "Pause":"Continue";

}

ZLog.prototype.clear = function(){
	this.htmldiv.innerHTML = "";
}

ZLog.prototype.reset = function(){

	this.clear();
	this.update("ZLog up and running...","",false);

}

ZLog.prototype.getDate = function(){

	var d = new Date();
	var hours = d.getHours();
	var minutes = d.getMinutes();
	var seconds = d.getSeconds();

	return ((hours < 10)? "0"+hours:hours) + ':' + ((minutes < 10)? "0"+minutes:minutes) + ':' + ((seconds < 10)? "0"+seconds:seconds);

}

function createLog(){

	document.zlog = new ZLog("zlog");
	document.onkeydown = checkKey;

}

function checkKey(e){

	// Thanks to Geekpedia
	// http://www.geekpedia.com/tutorial138_Get-key-press-event-using-JavaScript.html

	var KeyID = (window.event)? event.keyCode:e.keyCode;

	switch(KeyID){

		case(65): // a

			document.zlog.addBlankLine();
			break;

		case(116): // F5
		case(82): // r

			document.zlog.reset();
			break;

		case(80): // p

			document.zlog.pause();
			break;

	}

}

function updateZLog(s,type,reset){
	document.zlog.update(s,type,reset);
}
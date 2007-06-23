// ==============================================================
// FLACCESS v1.3 (c)2004 Sergi Meseguer (http://zigotica.com/)
// Released under Creative Commons ShareAlike license:
// http://creativecommons.org/licenses/by-sa/2.0/
// Check out http://meddle.dzygn.com/eng/tools/ or
// http://meddle.dzygn.com/esp/utilidades/ for further info
// ==============================================================

// Set this variable to 1 if you want to alert intermediate steps:
var flaccess_debug;


var flaccess_loaded;
function checkFlash(min){
	var version = 0;
	if(!min) min = 10;
	if (navigator.plugins)  {
		if(navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {
			var desc = navigator.plugins["Shockwave Flash"].description;
			version = parseInt(desc.substring(16));
		}
		else if(navigator.appVersion.indexOf("MSIE")>-1){
			// try/catch would be better but then breaks script in ns4:
			// loop by Geoff Stearns (geoff@deconcept.com, http://blog.deconcept.com/)
			result = false;
	   		for(var i = min; i >= 3 && result != true; i--){
	    			execScript('on error resume next: result = IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.'+i+'"))','VBScript');
				version = i;
			}
		}
	}
	return version;
}

function addFlash(postpone,minversion,path,width,height,node) {
	// defining arguments (from arguments array) in object and embed elements:
	var minargs = 6;
	var objpars = '<param name="movie" value="'+path+'">';
	var empars = ' src="'+path+'" ';
	var align = '';
	var flashid = '';
	var salign = '';
	var flvars = '';
	var allowedObjParams = ["menu","play","quality","scale","devicefont","bgcolor","loop","wmode","salign","base"];
	var allowedEmbParams = ["menu","play","quality","scale","devicefont","bgcolor","loop","wmode","base","swliveconnect"];
	for(var op=parseInt(arguments.length);op>minargs;op--) {
		var tmp = arguments[op-1].split(":"); var tmpname = tmp[0];var tmpvalue = tmp[1];
		if(allowedObjParams.indexOf(tmpname.toLowerCase()) >-1) {
			objpars += '<param name="'+tmpname+'" value="'+tmpvalue+'">';
		}
		if(allowedEmbParams.indexOf(tmpname.toLowerCase()) >-1) {
			empars += ' '+tmpname+'="'+tmpvalue+'" ';
		}
		if(tmpname.toLowerCase() == "align") {
			align = ' align="'+tmpvalue+'" ';
		}
		if(tmpname.toLowerCase() == "salign") {
			salign = ' salign="'+tmpvalue+'" ';
		}
		if(tmpname.toLowerCase() == "flashvars") {
			if(minversion>=6) flvars = tmpvalue;
			else alert("flashVars support was not available until flash version 6");
		}
	}


	// this will allow to call same arguments when postpone true
	var postvars = '';
	for(var p=parseInt(arguments.length);p>minargs;p--) {
		postvars += ',"'+arguments[p-1]+'"';
	}


	if(checkFlash(minversion) >= minversion){
		if(flaccess_debug==1) alert("minimum flash " + minversion + " is ok, we have version " + checkFlash())

		if(postpone==0) {
			// splits node id for normal browsers
			var col = node.split(",");
			var flid = col[0];
			var parentid = col[1];
			if(minversion>=6){
				if(flvars!='') flvars += '&';
				flvars += 'flid='+node;
				if(document.layers) flvars += '&ns4=1';
				objpars += '<param name="flashvars" value="'+flvars+'">';
			}



			// adds flash object before page loads, unless it's ns4 and page is loaded
			// flash object:
			var obj = '<object '+flashid+' id="'+flid+'" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="'+width+'" height="'+height+'" '+align+'>';
			obj += objpars;
			obj += '<embed src="'+path+'" name="'+flid+'" id="name'+flid+'" width="'+width+'" height="'+height+'"  '+empars+' type="application/x-shockwave-flash" '+align+' '+salign;
			if(minversion>=6) obj += ' flashvars="'+flvars+'" ';
			obj += ' pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>';
			obj += '</object>'

			//alert(obj)

			if(flaccess_debug==1) alert(" flid: " + flid + "\n\n" + obj);

			if(!document.layers && !document.all) {
				if(document.getElementById(parentid)) {
					document.getElementById(parentid).innerHTML = obj;
					document.getElementById(parentid).style.height = height+"px";
					document.getElementById(parentid).style.width = width+"px";
				}
				else eval('addFlash(1,minversion,path,width,height,node'+postvars+')');
			}
			else {
				// ns4/ie4
				if(flaccess_loaded==1){
					// page fully loaded

					if(document.layers){
						// generates node reference:
						var ns4path = "";
						for(var a=col.length;a>1;a--) {
							if(a!=col.length) ns4path += ".document['"+col[a-1]+"']";
							else ns4path += "document['"+col[a-1]+"']";
						}
						if(flaccess_debug==1) alert(ns4path);
						eval('o = ' + ns4path);

						// writes flash object to layer:
						o.document.open();
						o.document.write(obj);
						o.document.close();
						o.height = height;
						o.width = width;
					}
					else if(document.all) {
						document.all[parentid].innerHTML = obj;
						document.all[parentid].style.height = height+"px";
						document.all[parentid].style.width = width+"px";
					}


				}
				else {
					// force postpone
					if(postvars!="") eval('addFlash(1,minversion,path,width,height,node'+postvars+')');
					else addFlash(1,minversion,path,width,height,node);
				}
			}
		}

		else{
			// setTimeout makes sure window.flaccess_loaded==1 (needed for ns4 to document.write ok)
			addLoadEvent(function(){window.flaccess_loaded = 1;});
			if(postvars!="") addLoadEvent(function(){setTimeout("addFlash(0,"+minversion+",'"+path+"',"+width+","+height+",'"+node+"'"+postvars+")",300);});
			else addLoadEvent(function(){setTimeout("addFlash(0,"+minversion+",'"+path+"',"+width+","+height+",'"+node+"')",300);});
		}
	}
	else {
		if(flaccess_debug==1) alert("we have version " + checkFlash() + " and we needed flash " + minversion)
	}

}

// code by Simon Willison (http://simon.incutio.com)
function addLoadEvent (fn) {
	var old = window.onload;
	if (typeof window.onload != "function") {
		window.onload = fn;
	}
	else {
		window.onload = function() {
			old();
			fn();
		}
	}
}

// extending Array, by Aaron Boodman (youngpup.net):
Array.prototype.indexOf = function(foo) {
	for (var i = 0; i < this.length; i++)
	if (foo == this[i]) return i;
	return -1;
}

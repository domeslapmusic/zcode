// =================================================================
// FLACCESS v2.0 (c)2007 Sergi Meseguer (http://zigotica.com/)
// For DOM browsers only, using onDOMContentLoad or on call
// Released under Creative Commons ShareAlike license:
// http://creativecommons.org/licenses/by-sa/2.0/
// =================================================================

var flaccess = {

	debug : null, // :1 to alert intermediate steps

	check : function (min){

		// Simplified from Adobe Flash Player Version Detection - Rev 1.5
		if (navigator.plugins)  {

			if(navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {

				var d = navigator.plugins["Shockwave Flash"].description;
				var desc = d.split(" ");
				var tmpM = desc[2].split(".");
				var tmpm = (desc[3] != "") ? desc[3].split("r"):desc[4].split("r");
				var vM = tmpM[0]; var vm = tmpM[1]; var vR = tmpm[1] > 0 ? tmpm[1] : 0;
				var flashVer = vM + "." + vm + "." + vR;
				return flashVer;

			} else {

				if(!min) min = 20;

				for(var i = min; i >= 3; i--){

					try{

						var fo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash." + i);
						var vs = fo.GetVariable("$version");
						var desc = vs.split(" "); var tmpS = desc[1];
						var tmpA = tmpS.split(",");
						var vM = tmpA[0]; var vm = tmpA[1]; var vR = tmpA[2];
						var flashVer = vM + "." + vm + "." + vR;
						return flashVer;

					} catch(e){
					}

				}

			}

		}

		else return "0.0.0";

	},

	add : function (path,node,min,width,height) {

		if(!document.getElementById) return;

		if(typeof(min) == "string") { var tmp = min.split("."); var vMn = parseInt(tmp[0]); var vmn = parseInt(tmp[1])||0; var vRn = parseInt(tmp[2])||0;}
		else {var vMn = min; var vmn = 0; var vRn = 0;}
		// Major, minor, Revision
		var vn = vMn + "." + vmn + "." + vRn;


		// defining arguments (from arguments array):
		var args = arguments.callee.length;
		var opts = '';
		var opars = '<param name="movie" value="'+path+'">';
		var epars = '';
		var align = '';
		var salign = '';
		var flvars = '';
		var allowObjPars = ["menu","play","quality","scale","devicefont","bgcolor","loop","wmode","salign","base","allowscriptaccess","flashvars"];
		var allowEmbPars = ["menu","play","quality","scale","devicefont","bgcolor","loop","wmode","base","swliveconnect","allowscriptaccess","flashvars"];
		var al = parseInt(arguments.length);

		for(var op=al;op>args;op--){

			if(this.debug==1) alert("arg " + parseInt(op-1) + "> " + arguments[op-1]);
			var tmp = arguments[op-1].split(":"); var tmpname = tmp[0];var tmpvalue = tmp[1];
			if(tmpname.toLowerCase() == "later") { var later = 1;} // flash will be added when full content is loaded
			if(tmpname.toLowerCase() == "keepme") { var keepme = 1; } // flash will not replace html content
			if(tmpname == "id") { var id = tmpvalue; }

			if(allowObjPars.indexOf(tmpname.toLowerCase()) >-1) {
				opars += '<param name="'+tmpname+'" value="'+tmpvalue+'">';
			}

			if(allowEmbPars.indexOf(tmpname.toLowerCase()) >-1) {
				epars += ' '+tmpname+'="'+tmpvalue+'" ';
			}

			if(tmpname.toLowerCase() == "align") {
				align = ' align="'+tmpvalue+'" ';
			}

			if(tmpname.toLowerCase() == "salign") {
				salign = ' salign="'+tmpvalue+'" ';
			}

			if(tmpname.toLowerCase() == "flashvars") {

				if(vMn>=6){ flvars = tmpvalue; }
				else { alert("flashVars support was not available until flash version 6"); }

			}

		}

		var _CHK = this.check(vMn);
		var CHK = _CHK.split("."); var vMc = parseInt(CHK[0]); var vmc = parseInt(CHK[1]); var vRc = parseInt(CHK[2]);
		var vc = vMc + "." + vmc + "." + vRc;

		if(vMc > vMn || (vMc == vMn && vmc > vmn) || (vMc == vMn && vmc == vmn && vRc >= vRn)) {

			if(this.debug==1) alert("minimum flash " + vn + " check was ok, we have version " + vc);

			if(!later) {

				if(vMn>=6 && flvars != ''){

					opars += '<param name="flashvars" value="'+flvars+'">';

				}

				// builds flash object:
				width = (typeof width == "number")? width+"px" : width;
				height = (typeof height == "number")? height+"px" : height;
				if(this.debug==1) alert(" width: " + width + " height: " + height);

				id = (id)? id : "flobj_"+node;
				if(this.debug==1) alert("id: " + id);

				if(navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {

					var obj = '<embed src="'+path+'" id="'+id+'" width="'+width+'" height="'+height+'"  '+epars+' type="application/x-shockwave-flash" '+align+' '+salign;
					if(vMn>=6 && flvars) obj += ' flashvars="'+flvars+'" ';
					obj += ' pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>';

				} else {

					var obj = '<object id="'+id+'" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="'+width+'" height="'+height+'" '+align+'>';
					obj += opars;
					obj += '</object>';

				}

				if(this.debug==1) alert(obj);

				//paint 'n' shape:
				if(keepme) document.getElementById(node).innerHTML += obj;
				else document.getElementById(node).innerHTML = obj;
				document.getElementById(id).style.height = height;
				document.getElementById(id).style.width = width;
			}

			else{

				// mejor un loop y construir el onContent al vuelo, excluyendo el argument "later"
				for(var a = args; a < arguments.length; a++) if(arguments[a]!="later") opts += ',"'+arguments[a]+'"'; //OJO no lee arguments bien, todo los opts como 1 argumento.
				if(this.debug==1) alert(" opts: " + opts);
				onContent(function(){flaccess.add(path,node,min,width,height,opts)}); //doesnt matter ,,opts

			}

		}

		else {
			if(this.debug==1) alert("we have version " + vc + " and we needed flash " + vn);
		}

	}
}

// ************************************************************
// (C) Andrea Giammarchi webreflection.blogspot.com
function onContent(f){
var a=onContent,b=navigator.userAgent,d=document,w=window,c="onContent",e="addEventListener",o="opera",r="readyState",
s="<scr".concat("ipt defer src='//:' on",r,"change='if(this.",r,"==\"complete\"){this.parentNode.removeChild(this);",c,".",c,"()}'></scr","ipt>");
a[c]=(function(o){return function(){a[c]=function(){};for(a=arguments.callee;!a.done;a.done=1)f(o?o():o)}})(a[c]);
if(d[e])d[e]("DOMContentLoaded",a[c],false);
if(/WebKit|Khtml/i.test(b)||(w[o]&&parseInt(w[o].version())<9))(function(){/loaded|complete/.test(d[r])?a[c]():setTimeout(arguments.callee,1)})();
else if(/MSIE/i.test(b))d.write(s);
};
// ************************************************************


// extending Array, by Aaron Boodman (youngpup.net):
Array.prototype.indexOf = function(foo) {
	for (var i = 0; i < this.length; i++)
	if (foo == this[i]) return i;
	return -1;
}
// adds 1 or more elements to an array (IE only)
if(!Array.prototype.push)
{
	Array.prototype.push =  function()
	{
		var i;
		for(i=0; j=arguments[i]; i++) this[this.length] = j;
		return this.length;
	}
}
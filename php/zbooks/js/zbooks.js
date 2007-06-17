function sendLoginForm(formobj){

	var hashedPass = calcMD5c(formobj.newUserPassword.value);
	var combinedHashed = calcMD5c(hashedPass + formobj.serverkey.value);

	formobj.newUserPassword.value = combinedHashed;
	formobj.serverkey.value = "";
	formobj.loginbutton.value = "Wait please...";
	formobj.loginbutton.disabled = true;
	formobj.submit();

}

function updateTitle(s){
	document.title = s;
}

function reloadPage(){
	window.location.reload();
}

function changeStatus(s){
	window.status = s;
}
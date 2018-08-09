function sendAJAX(url)
{
	var xmlhttp;
	if (window.XMLHttpRequest) { 
	    // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else { 
	    // code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
}

function postAJAX(url, passData) {
    if (window.XMLHttpRequest) {
        AJAX = new XMLHttpRequest();
    } else {
        AJAX = new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (AJAX) {
        AJAX.open("POST", url, false);
        AJAX.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        AJAX.send(passData);
    }
}

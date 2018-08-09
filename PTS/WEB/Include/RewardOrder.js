/*
 Support functions for Cryptocurrency payment processing
 Dependencies: MessageRow, MessageBox, Payment2ID, CoinToken, IsDemo, QR_Address, ReplaceURL, QRCode, QRAmount, QR_Amount, ActionCode 6 
 */

var gTimerSeconds = 900;
var gTimerMessage = 'Awaiting Payment...';
var gPaymentType = 2;

// *****************************************
function SetPaymentType(typ) {
    gPaymentType = typ;
}
// *****************************************
function TestDependencies() {
    var obj;
    obj = document.getElementById('MessageRow');
    if (obj === null) { alert('Missing MessageRow'); }
    obj = document.getElementById('MessageBox');
    if (obj === null) { alert('Missing MessageBox'); }
    if (gPaymentType == 2) {
        obj = document.getElementById('Payment2ID');
        if (obj === null) { alert('Missing Payment2ID'); }
        obj = document.getElementById('IsDemo');
        if (obj === null) { alert('Missing IsDemo'); }
    }
    else {
        obj = document.getElementById('PaymentID');
        if (obj === null) { alert('Missing PaymentID'); }
    }
    obj = document.getElementById('CoinToken');
    if (obj === null) { alert('Missing CoinToken'); }
    obj = document.getElementById('QR_Address');
    if (obj === null) { alert('Missing QR_Address'); }
    obj = document.getElementById('ReplaceURL');
    if (obj === null) { alert('Missing ReplaceURL'); }
    obj = document.getElementById('QRCode');
    if (obj === null) { alert('Missing QRCode'); }
    obj = document.getElementById('QRAmount');
    if (obj === null) { alert('Missing QRAmount'); }
    obj = document.getElementById('QR_Amount');
    if (obj === null) { alert('Missing QR_Amount'); }
}

// *****************************************
function DisplayMessage(msg,clr) {
    if( clr.length > 0 ) {
        document.getElementById('MessageRow').style.background = clr;
    }
    document.getElementById('MessageBox').value = msg;
}

// *****************************************
function UpdateQR(amt) {
    var qrurl = document.getElementById('ReplaceURL').value; 
    qrurl = qrurl.replace("{amt}", amt);
    document.getElementById('QRCode').src = qrurl; 
    document.getElementById('QRAmount').value = 'Coins: ' + amt;
    document.getElementById('QR_Amount').value = amt;
}

// *****************************************
function ProcessCryptoPayment() {
    var paymentid, url;
    var cointoken = document.getElementById('CoinToken').value;
    if (gPaymentType == 2) {
        paymentid = document.getElementById('Payment2ID').value;
        url = "cp2.asp?p=" + paymentid + "&t=" + cointoken;
    }
    else {
        paymentid = document.getElementById('PaymentID').value;
        url = "cp.asp?p=" + paymentid + "&t=" + cointoken;
    }
    var xmlhttp;
    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var retcode = this.responseText;
            //check for numberic return value
            if( isNaN(retcode) ) { retcode = -99; }
            //Handle success
            if( retcode == 0 ) {
                DisplayMessage( "Payment Successful!", "green");
                doSubmit(6,"");
            }
            //Handle partial payment
            if( retcode > 0 ) {
                gTimerSeconds = 900;
                setTimeout("UpdateTimer()", 1000);
                var amt = retcode / 100000000;
                UpdateQR( amt );
                gTimerMessage = "Partial Payment!  Please submit the balance of " + amt + " coins.";
                DisplayMessage( gTimerMessage, "blue");
                alert(gTimerMessage);
            }
            //Handle system error
            if( retcode < 0) {
                if( retcode == -3) {
                    DisplayMessage( "Order Already Processed!", "");
                    alert("Order Already Processed!");
                }
                else if (retcode == -20) {
                    DisplayMessage("Payment Not Received Yet!", "");
                    alert("Payment Not Received Yet!");
                }
                else if (retcode == -99) {
                    DisplayMessage("System Error! " + retcode, "red");
                    alert("System Error! " + retcode + " CP.asp in Test Mode.");
                }
                else {
                    DisplayMessage( "System Error! " + retcode, "red");
                    alert("System Error! " + retcode + " Click the blue button above to manually confirm this payment on the blockchain.");
                }
            }
        }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}

// *****************************************
function GetCryptoPayment() {
    TestDependencies();
    var isdemo = 0;
    if(gPaymentType == 2){ isdemo = document.getElementById('IsDemo').value;}
    if( isdemo != 0 ) {
        DisplayMessage( "DEMO ONLY! DO NOT SEND PAYMENT...", "red");
    }
    else
    {
        var address = document.getElementById('QR_Address').value;
        var btcs = new WebSocket('wss://ws.blockchain.info/inv');
        btcs.onopen = function() {
            btcs.send( JSON.stringify( {"op":"addr_sub", "addr": address } ) );
        }
        btcs.onmessage = function(onmsg) {
            var response = JSON.parse(onmsg.data);
            var getOuts = response.x.out;
            var countOuts = getOuts.length;
            for(i = 0; i < countOuts; i++) {
                //check every output to see if it matches specified address
                var outAdd = response.x.out[i].addr;
                if (outAdd == address ) {
                    var amount = response.x.out[i].value;
                    gTimerSeconds = -1;
                    DisplayMessage( "Processing Payment...", "blue");
                    ProcessCryptoPayment();
                }
            }
        }
    }
}

// *****************************************
function UpdateTimer() {
    if( gTimerSeconds == 0) {
        DisplayMessage( "Order Expired!", "red");
    }
    if( gTimerSeconds > 0) {
        gTimerSeconds = gTimerSeconds - 1;
        setTimeout("UpdateTimer()", 1000);
        var seconds = gTimerSeconds % 60;
        var minutes = Math.floor((gTimerSeconds / 60) % 60 );
        var hours = Math.floor(gTimerSeconds / 3600);
        var fmt = "";
        if(hours > 0){ fmt = Math.floor(gTimerSeconds / 3600 ) + ":"}
        if(minutes < 10 ){ fmt = fmt + "0" }
        fmt = fmt + minutes + ":";
        if(seconds < 10 ){ fmt = fmt + "0" }
        fmt = fmt + seconds;
        if( gTimerSeconds == 120) {
            gTimerMessage = 'Running Out of Time...';
            DisplayMessage( gTimerMessage, "orange");
        }
        DisplayMessage( fmt + '  ' + gTimerMessage, "");
    }
}

<!--#include virtual="include\aspJSON1.17.asp" -->
<%
g_CB_API_KEY  = ""
g_CB_API_SECRET  = ""
g_CB_URL = "https://coinbase.com/api/v1/"
g_CB_Test = False
g_CB_TXNID = ""
g_CB_Nonce = 0
'***********************************************************************
Function SetCBKey(ByVal bvKey, ByVal bvSecret)
    On Error Resume Next
    g_CB_API_KEY = bvKey
    g_CB_API_SECRET = bvSecret
End Function

'***********************************************************************
Function GetCBTxn()
    On Error Resume Next
    GetCBTxn = g_CB_TXNID
End Function

'***********************************************************************
Function BitCoinButton( ByVal bvProduct, ByVal bvAmount, ByVal bvPaymentID ) 
    On Error Resume Next

    sURL = g_CB_URL + "buttons"
    If TRIM(bvProduct) = "" Then bvProduct = "Bitcoin Payment"

    sRequest = "{""button"":{" _
    + """name"":""" + bvProduct + """," _
    + """price_string"":""" + CStr(bvAmount) + """," _
    + """price_currency_iso"":""" + "USD" + """," _
    + """custom"":""" + CStr(bvPaymentID) + """" _
    + "}}"

    sResponse = CB_SendApiRequest( sURL, sRequest, "POST" )

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)
    Success = oJSON.data("success")

    If Success = True Then 
        BitCoinButton = oJSON.data("button")("code")
    Else	    
        BitCoinButton = "ERROR:" + sResponse
    End If

    Set oJSON = Nothing
End Function


'***********************************************************************
Function SendBitCoin( ByVal bvTo, ByVal bvAmount, ByVal bvNotes ) 
    On Error Resume Next

    sURL = g_CB_URL + "transactions/send_money"

    sRequest = "{""transaction"":{" _
    + """to"":""" + bvTo + """," _
    + """amount_string"":""" + CStr(bvAmount) + """," _
    + """amount_currency_iso"":""" + "USD" + """," _
    + """notes"":""" + CStr(bvNotes) + """" _
    + "}}"

    sResponse = CB_SendApiRequest( sURL, sRequest, "POST" )

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)
    Success = oJSON.data("success")

    If Success = True Then 
        SendBitCoin = "OK"
    Else	    
        SendBitCoin = oJSON.data("errors").item(0)
    End If	

    Set oJSON = Nothing
End Function

'***********************************************************************
Function RequestBitCoin( ByVal bvFrom, ByVal bvAmount, ByVal bvNotes, ByVal bvPaymentID ) 
    On Error Resume Next

    sURL = g_CB_URL + "transactions/request_money"
    bvNotes = CStr(bvPaymentID) + " " + bvNotes 

    sRequest = "{""transaction"":{" _
    + """from"":""" + bvFrom + """," _
    + """amount_string"":""" + CStr(bvAmount) + """," _
    + """amount_currency_iso"":""" + "USD" + """," _
    + """notes"":""" + CStr(bvNotes) + """" _
    + "}}"

    sResponse = CB_SendApiRequest( sURL, sRequest, "POST" )

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)
    Success = oJSON.data("success")

    If Success = True Then 
        g_CB_TXNID = oJSON.data("transaction")("id")
        RequestBitCoin = "OK"
    Else	    
        g_CB_TXNID = ""
        RequestBitCoin = oJSON.data("errors").item(0)
    End If	

    Set oJSON = Nothing
End Function

'***********************************************************************
Function RerequestBitCoin( ByVal bvTxn ) 
    On Error Resume Next

    sURL = g_CB_URL + "transactions/" + bvTxn + "/resend_request"

    sRequest = ""

    sResponse = CB_SendApiRequest( sURL, sRequest, "PUT" )

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)
    Success = oJSON.data("success")

    If Success = True Then 
        RerequestBitCoin = "OK"
    Else	    
        RerequestBitCoin = oJSON.data("errors").item(0)
    End If	

    Set oJSON = Nothing
End Function

'***********************************************************************
Function CancelRequestBitCoin( ByVal bvTxn ) 
    On Error Resume Next

    sURL = g_CB_URL + "transactions/" + bvTxn + "/cancel_request"

    sRequest = ""

    sResponse = CB_SendApiRequest( sURL, sRequest, "DELETE" )

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)
    Success = oJSON.data("success")

    If Success = True Then 
        CancelRequestBitCoin = "OK"
    Else	    
        CancelRequestBitCoin = oJSON.data("errors").item(0)
    End If	

    Set oJSON = Nothing
End Function

'***********************************************************************
Function GetBitCoinRequest( ByVal bvTxn ) 
    On Error Resume Next

    If bvTxn = "" Then bvTxn = g_CB_TXNID
    sURL = g_CB_URL + "transactions/" + bvTxn 

    sRequest = ""

    sResponse = CB_SendApiRequest( sURL, sRequest, "GET" )
    GetBitCoinRequest = sResponse
End Function

'****************************************************************************************
Function CB_SendApiRequest(byVal bvURL, byVal bvRequest, byVal bvMethod)
    On Error Resume Next
    Dim oHTTP, sResponse, message, signature

    If g_CB_Nonce = 0 Then
        g_CB_Nonce = DateDiff("s", "6/28/2013", Now() ) * 100000
    Else
        g_CB_Nonce = g_CB_Nonce + 1
    End If

    message = CStr(g_CB_Nonce) + bvUrl + bvRequest
    signature = CB_SHA256(g_CB_API_SECRET, message)

    If g_CB_Test Then Response.Write "<BR><BR>URL: " & bvURL
    If g_CB_Test Then Response.Write "<BR>Request: " & bvRequest

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open bvMethod, bvURL
        .setRequestHeader "ACCESS_KEY", g_CB_API_KEY
        .setRequestHeader "ACCESS_SIGNATURE", signature
        .setRequestHeader "ACCESS_NONCE", g_CB_Nonce
        .setRequestHeader "Content-Type", "application/Json"
        .send bvRequest
        sResponse = .responseText
    End With
    Set oHTTP = Nothing

    If g_CB_Test Then Response.Write "<BR><BR>Response: " & sResponse
    CB_SendApiRequest = sResponse
End Function

'****************************************************************************************
Function CB_SHA256(byVal bvKey, byVal bvString)
    On Error Resume Next
    Dim oSHA256
    Set oSHA256 = GetObject( "script:" & Server.MapPath("include/sha256md5.wsc") )
    With oSHA256
        .hexcase = 0
        CB_SHA256 = .hex_hmac_sha256(bvKey, bvString)
    End With
    Set oSHA256 = Nothing
End Function

%>

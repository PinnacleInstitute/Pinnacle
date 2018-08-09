<!--#include virtual="include\aspJSON1.17.asp" -->
<%
'***** Blockchain.info API *********************************************
g_BC_API_GUID  = ""
g_BC_API_PSWD  = ""
g_BC_API_PSWD2  = ""
g_BC_BitCoinAddress = "15BfNTpdJoc89VyE9FUojgMorLyXUNdWVL"
g_BC_URL = "https://blockchain.info/"
g_BC_Test = false

'***********************************************************************
Function GetUSDBTC( ByVal bvAmount ) 
    On Error Resume Next
    sURL = g_BC_URL + "tobtc?currency=USD&value=" + CStr(bvAmount)

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open "GET", sURL
        .send 
        sResponse = .responseText
    End With
    Set oHTTP = Nothing

    GetUSDBTC = sResponse
End Function

'***********************************************************************
Function ReceiveBitCoin( ByVal bvTo, ByVal bvPaymentID, ByVal bvAmount ) 
    On Error Resume Next

    If bvTo = "" Then bvTo = g_BC_BitCoinAddress

    sCallback = "https://www.gcrmarketing.com/BlockchainCallback.asp?p=" + CStr(bvPaymentID) + "&a=" + CStr(bvAmount)

    sURL = g_BC_URL + "api/receive?method=create"
    sURL = sURL + "&address=" + bvTo
    sURL = sURL + "&callback=" + Server.URLEncode( sCallback )

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open "GET", sURL
        .send 
        sResponse = .responseText
    End With
    Set oHTTP = Nothing

    Set oJSON = New aspJSON
    oJSON.loadJSON( sResponse )
    error = oJSON.data("error")
    If error = "" Then
        ReceiveBitCoin = oJSON.data("input_address")
    Else
        ReceiveBitCoin = error
    End If
    Set oJSON = Nothing

End Function

'***********************************************************************
Function AuthenticateBC(ByVal bvStr)
    On Error Resume Next
    a = Split(bvStr, "|")
    g_BC_API_GUID = a(0)
    g_BC_API_PSWD = a(1)
    g_BC_API_PSWD2 = a(2)
End Function

'***********************************************************************
Function SendBitCoin( ByVal bvTo, ByVal bvAmount, ByVal bvNotes, ByRef brMessage ) 
    On Error Resume Next

    If g_BC_API_GUID <> "" And g_BC_API_PSWD <> "" Then
        sURL = g_BC_URL + "merchant/" + g_BC_API_GUID + "/payment?password=" + g_BC_API_PSWD
        sURL = sURL + "&second_password=" + g_BC_API_PSWD2
        sURL = sURL + "&to=" + bvTo
        sURL = sURL + "&amount=" + CSTR(bvAmount)
        sURL = sURL + "&note=" + bvNotes

	If Test Then response.write "<BR>URL: " + sURL

        Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
        With oHTTP
            .open "GET", sURL
            .send 
            sResponse = .responseText
        End With
        Set oHTTP = Nothing

	If Test Then response.write "<BR>RESPONSE: " + sResponse 

        Set oJSON = New aspJSON
        oJSON.loadJSON( sResponse )
        error = oJSON.data("error")
        If error = "" Then
            brMessage = oJSON.data("message")
            SendBitCoin = "OK"
        Else
            SendBitCoin = error
        End If
        Set oJSON = Nothing
    Else
        SendBitCoin = "ERROR: Missing Authentication"
    End If

End Function

%>

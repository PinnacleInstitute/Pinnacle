<%
g_STP_NAME  = ""
g_STP_PSWD  = ""
g_STP_SALT  = "s+E_a*"
g_STP_URL = "https://solidtrustpay.com/accapi/process.php"
g_STP_Test = True

'***********************************************************************
Function STPAuthenticate(ByVal bvStr)
    On Error Resume Next
    a = Split(bvStr, "|")
    g_STP_NAME = a(0)
    g_STP_PSWD = a(1)
End Function

'***********************************************************************
Function STPPayout( ByVal bvCompanyID, ByVal bvTo, ByVal bvAmount, ByVal bvNote, ByVal bvPayoutID )
    On Error Resume Next
    result = ""
    
    If g_STP_NAME <> "" Then

        sURL = g_STP_URL
        If g_STP_Test Then TestMode = "1" Else TestMode = "0" 

        HashPswd = STP_MD5( g_STP_PSWD + g_STP_SALT )

        sRequest = "api_id=" + g_STP_NAME + "&api_pwd=" + HashPswd + "&testmode=" + TestMode

        sRequest = sRequest + "&user=" + bvTo + "&amount=" + CSTR(bvAmount) + "&paycurrency=USD" + "&comments=" + bvNote + "&udf1=" + CSTR(bvPayoutID)
    
        sResponse = STP_SendApiRequest( sURL, sRequest, "POST" )

        If InStr( sResponse, "ACCEPTED" ) > 0 Then
            result = "OK"
        Else
            result = sResponse
        End If
    Else
        result = "Missing Authentication"
    End If

    STPPayout = result

End Function

'****************************************************************************************
Function STP_SendApiRequest(byVal bvURL, byVal bvRequest, byVal bvMethod)
    On Error Resume Next
    Dim oHTTP, sResponse, message

    If g_STP_Test Then
        Response.Write "<BR><BR>URL: " & bvURL
        Response.Write "<BR>Request: " & bvRequest
    End If

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open bvMethod, bvURL
        .send bvRequest
        sResponse = .responseText
    End With
    Set oHTTP = Nothing

    If g_STP_Test Then Response.Write "<BR><BR>Response: " & sResponse
    STP_SendApiRequest = sResponse
End Function

'****************************************************************************************
Function STP_MD5(byVal bvString)
    On Error Resume Next
    Dim oSHA256
    Set oSHA256 = GetObject( "script:" & Server.MapPath("include/sha256md5.wsc") )
    With oSHA256
        .hexcase = 0
        STP_MD5 = .hex_md5( bvString )
    End With
    Set oSHA256 = Nothing
End Function

%>

<%
'g_Test = true
'g_URL = "https://testewallet.com/eWalletWS/ws_Adapter.aspx"
g_Test = false
g_URL = "https://www.i-payout.net/eWalletWS/ws_Adapter.aspx"

'****************************************************************************************
Function iPayout_RegisterUser( byval bvAccount, byval bvUserName, byval bvFirstName, byval bvLastName, byval bvEmail )
	On Error Resume Next
	
    URL = g_URL + "?" + bvAccount
    URL = URL + "&fn=eWallet_RegisterUser"
    URL = URL + "&UserName=" + bvUserName
    URL = URL + "&FirstName=" + bvFirstName
    URL = URL + "&LastName=" + bvLastName
    URL = URL + "&EmailAddress=" + bvEmail

    result = HTTP(URL)

    'Replace encoded characters
    result = Replace(result, "%3d", "=")
    result = Replace(result, "%26", "&")

    LogFile "iPayout", result + " | " + URL

    If Left(result,5) <> "ERROR" Then
        value = URLValue(result, "m_Code", "&")

        If value = "NO_ERROR" Then
            iPayout_RegisterUser = ""
        Else
            iPayout_RegisterUser = URLValue(result, "m_Text", "&")
        End If
    Else          
        iPayout_RegisterUser = result
    End If
   
End Function

'****************************************************************************************
Function HTTP(byVal bvRequest)

    If g_Test Then Response.Write "<BR><BR>Request: " & bvRequest

    On Error Resume Next

    Set oHTTP = Server.CreateObject("Microsoft.XMLHTTP")
    oHTTP.open "GET", bvRequest, False
    oHTTP.send
    result = oHTTP.responseText
    Set oHTTP = Nothing
	
    If g_Test Then Response.Write "<BR><BR>Response: " & result

    If Err.Number = 0 Then 
        HTTP = result
    Else
        HTTP = "ERROR: " + Err.Description
    End If

End Function

'****************************************************************************************
Function URLValue(ByVal bvURL, ByVal bvName, ByVal bvDelim)
   pos = InStr(bvURL, bvName)
   If pos > 0 Then
      pos = InStr(pos, bvURL, "=")
      If pos > 1 Then
         pos2 = InStr(pos, bvURL, bvDelim)
         If pos2 > 1 Then
            URLValue = Mid(bvURL, pos + 1, (pos2 - 1) - pos)
         Else
            URLValue = Mid(bvURL, pos + 1)
         End If
      End If
   Else
      URLValue = "MissingToken"
   End If

End Function

%>


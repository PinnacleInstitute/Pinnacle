<%
'****************************************************************************************
' Countries Supported by PayQuicker (* = NO EFT) 
'****************************************************************************************
'AUSTRALIA 14, AUSTRIA 13, *BAHAMAS 31, BELGIUM 21, BRAZIL 30, BULGARIA 23, CANADA 37, *COSTA RICA 49, *CROATIA 96
'CZECH REPUBLIC 55, DENMARK 58, *DOMINICAN REPUBLIC 60, ESTONIA 63, FINLAND 69, FRANCE 74, GERMANY 56, GIBRALTAR 81
'*HONG KONG 93, HUNGARY 98, INDIA 102, IRELAND 100, ITALY 107, JAPAN 110, LITHUANIA 129, LUXEMBOURG 130, *MALAYSIA 152
'MEXICO 151, NETHERLANDS 160, *NEW ZEALAND 165, NORWAY 161, *PERU 168, POLAND 173, PORTUGAL 178, ROMANIA 183
'*SAN MARINO 197, *SINGAPORE 191, SOUTH AFRICA 237, SPAIN 67, SWEDEN 190, SWITZERLAND 42, UNITED KINGDOM 76, UNITED STATES 224
'****************************************************************************************
Function PayQuickerCountry( byVal bvCode)
    On Error Resume Next
'    IsCountry = InStr(",14,13,31,21,30,23,37,49,96,55,58,60,63,69,74,56,81,93,98,102,100,107,110,129,130,152,151,160,165,161,168,173,178,183,197,191,237,67,190,42,76,224,", "," + CStr(bvCode) + "," )
'    IsCountry = InStr(",14,13,21,30,23,37,55,58,63,69,74,56,81,98,102,100,107,110,129,130,151,160,161,173,178,183,237,67,190,42,76,224,", "," + CStr(bvCode) + "," )
    IsCountry = InStr(",224,", "," + CStr(bvCode) + "," )
    PayQuickerCountry = IsCountry    
End Function

'****************************************************************************************
' Countries Rejected by Solid Trust Pay 
'****************************************************************************************
'Afghanistan (3), Belarus (35), Burma / Myanmar (140), Chad (206), Cote d'Ivoire / Ivory Coast (43), Cuba (51), Democratic Republic of the Congo (39)
'Equatorial Guinea (86), Iran (105), Iraq (104), Lebanon (123), Liberia (127), North Korea (117), Rwanda (185), Sudan (189), Syria (203), Zimbabwe (239)
'****************************************************************************************
Function STPCountry( byVal bvCode)
    On Error Resume Next
    'Rejected Countries
    IsCountry = InStr(",3,35,140,206,43,51,39,86,105,104,123,127,117,185,189,203,239,", "," + CStr(bvCode) + "," )
    If IsCountry = 0 Then STPCountry = 1 Else STPCountry = 0    
End Function

'****************************************************************************************
Function GetWalletProcessor( byVal bvWalletTypes, byVal bvWalletAccts, byVal bvPayType, byRef brAcct)
    On Error Resume Next
    Processor = 0
    brAcct = ""
    ' check if the payment type is is the wallet types    
    If InStr( bvWalletTypes, CStr(bvPayType) ) > 0 Then
        ' get arrays of types and accts    
        aTypes = Split(bvWalletTypes, ",")     
        aAccts = Split(bvWalletAccts, ",")
        ' make sure we have the same number of types and accts    
        If UBOUND(aTypes) = UBOUND(aAccts) Then
            'look for the payment type in the wallet types
            For x = 0 to UBOUND(aTypes)
                If aTypes(x) = CStr(bvPayType) Then
                    Processor = bvPayType + 200
                    brAcct = aAccts(x)
                    exit for
                End If
            Next    
        End If
    End If
    GetWalletProcessor = Processor    
End Function

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
    On Error Resume Next

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
	Err.Clear
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


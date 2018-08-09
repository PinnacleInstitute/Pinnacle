<!--#include virtual="include\aspJSON1.17.asp" -->
<%
'***** Blockchain.info API V2 ******************************************
g_BC_API_GUID  = ""
g_BC_API_PSWD  = ""
g_BC_API_PSWD2  = ""
'g_BC_URL = "https://blockchain.info/"
'g_BC_URL = "http://localhost:3000/merchant/"
g_BC_URL = "http://10.10.11.41:3000/merchant/"
g_BC_Test = False

'***********************************************************************
Function BC_Authenticate(ByVal bvStr)
    On Error Resume Next
    a = Split(bvStr, "|")
    g_BC_API_GUID = a(0)
    g_BC_API_PSWD = Server.URLencode( a(1) )
    g_BC_API_PSWD2 = Server.URLencode( a(2) )
End Function

'***********************************************************************
Function BC_TestAddress( ByVal bvAddress ) 
    Dim sURL, sResponse
    On Error Resume Next
    If g_BC_API_GUID <> "" And g_BC_API_PSWD <> "" Then
        sURL = g_BC_URL + g_BC_API_GUID + "/address_balance?"
        sURL = sURL + "password=" + g_BC_API_PSWD
        sURL = sURL + "&address=" + bvAddress

        sResponse = BC_SendURL( sURL ) 
        If sResponse = "" Then	
            BC_TestAddress = ""
        Else
            BC_TestAddress = BC_GetResponse( sResponse, 4, "" ) 
        End If
    Else
        BC_TestAddress = ""
    End If
End Function

'***********************************************************************
Function BC_AddressBalance( ByVal bvAddress ) 
    Dim sURL, sResponse
    On Error Resume Next
    If g_BC_API_GUID <> "" And g_BC_API_PSWD <> "" Then
        sURL = g_BC_URL + g_BC_API_GUID + "/address_balance?"
        sURL = sURL + "password=" + g_BC_API_PSWD
        sURL = sURL + "&address=" + bvAddress

        sResponse = BC_SendURL( sURL ) 
        If sResponse = "" Then	
            BC_AddressBalance = ""
        Else
            BC_AddressBalance = BC_GetResponse( sResponse, 3, "" ) 
        End If
    Else
        BC_AddressBalance = ""
    End If
End Function

'***********************************************************************
Function BC_NewAddress( ByVal bvLabel ) 
    Dim sURL, sResponse
    On Error Resume Next
    If g_BC_API_GUID <> "" And g_BC_API_PSWD <> "" Then
        sURL = g_BC_URL + g_BC_API_GUID + "/new_address?"
        sURL = sURL + "password=" + g_BC_API_PSWD
        sURL = sURL + "&second_password=" + g_BC_API_PSWD2
        If bvLabel <> "" Then sURL = sURL + "&label=" + bvLabel

        sResponse = BC_SendURL( sURL ) 
        If sResponse = "" Then	
            BC_NewAddress = ""
        Else
            BC_NewAddress = BC_GetResponse( sResponse, 1, "" ) 
        End If
    Else
        BC_NewAddress = "ERROR: Missing Authentication"
    End If
End Function

'***********************************************************************
Function BC_SendBitCoin( ByVal bvTo, ByVal bvAmount, ByRef brMessage ) 
    Dim sURL, sResponse
    On Error Resume Next
    If g_BC_API_GUID <> "" And g_BC_API_PSWD <> "" Then
        sURL = g_BC_URL + g_BC_API_GUID + "/payment?password=" + g_BC_API_PSWD
        sURL = sURL + "&second_password=" + g_BC_API_PSWD2
        sURL = sURL + "&to=" + bvTo
        sURL = sURL + "&amount=" + CSTR(bvAmount)

        sResponse = BC_SendURL( sURL ) 
        If sResponse = "" Then	
             BC_SendBitCoin = ""
        Else
            BC_SendBitCoin = BC_GetResponse( sResponse, 2, brMessage ) 
        End If
    Else
        BC_SendBitCoin = "ERROR: Missing Authentication"
    End If
End Function

'***********************************************************************
Function BC_SendURL( ByVal bvURL ) 
    On Error Resume Next
    If g_BC_Test Then response.write "<BR>URL: " + bvURL
    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open "GET", bvURL
        .send 
        BC_SendURL = .responseText
    End With
    Set oHTTP = Nothing
End Function

'***********************************************************************
Function BC_GetResponse( ByVal bvResponse, ByVal bvType, ByRef brMessage ) 

    On Error Resume Next
    Dim result

    If g_BC_Test Then response.write "<BR>Response: " + bvResponse
    Set oJSON = New aspJSON
    oJSON.loadJSON( bvResponse )
    Select Case bvType
    Case 1 'New Address
        BC_GetResponse = oJSON.data("address")
    Case 2 'Send Bitcoins
        brMessage = oJSON.data("message")
        If brMessage <> "" Then
            BC_GetResponse = "OK"
        Else
            brMessage = oJSON.data("error")
            BC_GetResponse = "ERROR"
        End If
    Case 3 'Address Balance
        result = oJSON.data("balance")
        If IsNumeric(result) Then
            BC_GetResponse = result
        Else
            BC_GetResponse = 0
        End If
    Case 4 'Test Address
        BC_GetResponse = oJSON.data("address")
    End Select
    Set oJSON = Nothing
End Function

%>

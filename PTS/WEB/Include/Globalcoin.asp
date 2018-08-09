<!--#include virtual="include\aspJSON1.17.asp" -->
<%
g_GC_API_SECRET  = ""
g_GC_NAME  = "globalcoin"
g_GC_URL = "https://globalcoinorders.coincraft.io/"
g_GC_Test = False
'***********************************************************************
Function SetGCSecret(ByVal bvSecret)
    On Error Resume Next
    g_GC_API_SECRET = bvSecret
End Function

'***********************************************************************
Function SendGCOrder( ByVal bvMemberID, ByVal bvProduct, ByVal bvUsername, ByVal bvPassword ) 
    On Error Resume Next

    UpdateOrder = 0

    If InStr(bvProduct, "u") > 0 Then
        UpdateOrder = 1
        bvProduct = Replace(bvProduct, "u", "" )
    End If
    'Package Upgrades
    If InStr("111,112,113,114,115,116", bvProduct) > 0 Then
        UpdateOrder = 1
        If bvProduct = 111 Then bvProduct = 103
        If bvProduct = 112 Then bvProduct = 104
        If bvProduct = 113 Then bvProduct = 105
        If bvProduct = 114 Then bvProduct = 104
        If bvProduct = 115 Then bvProduct = 105
        If bvProduct = 116 Then bvProduct = 105
    End If
    
    sURL = g_GC_URL + "order/generate"
    Product = ""
    Select Case bvProduct
        Case 101,102: Product = "wallet"
        Case 103,203: Product = "pack_a"
        Case 104,204: Product = "pack_b"
        Case 105,205: Product = "pack_c"
        Case 106,206: Product = "pack_d"
        Case 107,207: Product = "pack_e"
        Case 108,208: Product = "pack_f"
    End Select

    If Product = "" Or (Product = "wallet" And bvUserName = "") Then
        SendGCOrder = "None"
    Else
        If UpdateOrder <> 0 Then Product = "u_" + Product

        sRequest = "{" _
        + """product_type"":""" + Product + """," _
        + """user_id"":" + CStr(bvMemberID) + "," _
        + """username"":""" + bvUserName + """," _
        + """password"":""" + bvPassword + """" _
        + "}"

'DONT SEND ORDERS TO ANTHONY
'        sResponse = GC_SendApiRequest( sURL, sRequest, "POST" )
sResponse = ""

'        LogGCFile "GCOrder", sResponse

        If InStr( sResponse, """id"":" ) = 0 Then
'            LogGCFile "GCOrder", sRequest
            SendGCOrder = "ERROR: " + sResponse
        Else
            Set oJSON = New aspJSON
            oJSON.loadJSON(sResponse)

            IF Len(bvUsername) > 0 Then
                SendGCOrder = oJSON.data("token")
            Else
                SendGCOrder = oJSON.data("id")
            End If 
             
            Set oJSON = Nothing
        End If
    End If
End Function

'***********************************************************************
Function UpdateUser( ByVal bvMemberID, ByVal bvToken, ByVal bvUsername, ByVal bvPassword ) 
    On Error Resume Next

    sURL = g_GC_URL + "order/generate"

    Product = "u_Wallet"
    
    sRequest = "{" _
    + """product_type"":""" + Product + """," _
    + """user_id"":" + CStr(bvMemberID) + "," _
    + """user_token"":" + CStr(bvToken) + "," _
    + """username"":""" + bvUserName + """," _
    + """password"":""" + bvPassword + """" _
    + "}"

    sResponse = GC_SendApiRequest( sURL, sRequest, "POST" )

    LogGCFile "GCUpdate", sResponse

    If InStr( sResponse, """id"":" ) = 0 Then LogGCFile "GCUpdate", sRequest

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)

    UpdateUser = oJSON.data("id")

    Set oJSON = Nothing
End Function

'****************************************************************************************
Function GC_SendApiRequest(byVal bvURL, byVal bvRequest, byVal bvMethod)
    On Error Resume Next
    Dim signature, oHTTP, sResponse 

    signature = GC_SHA256(g_GC_API_SECRET, bvRequest)

    bvRequest = "{""username"":""" + g_GC_NAME + """," _
    + """signature"":""" + signature + """," _
    + """body"":" _
    + bvRequest _
    + "}"

'    If g_GC_Test Then Response.Write "<BR><BR>URL: " & bvURL
    If g_GC_Test Then Response.Write "<BR><BR>Request: " & bvRequest

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open bvMethod, bvURL
        .setRequestHeader "Content-Type", "application/Json"
        .send bvRequest
        sResponse = .responseText
    End With
    Set oHTTP = Nothing

    If g_GC_Test Then Response.Write "<BR><BR>Response: " & sResponse
    GC_SendApiRequest = sResponse
End Function

'****************************************************************************************
Function GC_SHA256(byVal bvKey, byVal bvString)
    On Error Resume Next
    Dim oSHA256
    Set oSHA256 = GetObject( "script:" & Server.MapPath("include/sha256md5.wsc") )
    With oSHA256
        .hexcase = 0
        GC_SHA256 = .hex_hmac_sha256(bvKey, bvString)
    End With
    Set oSHA256 = Nothing
End Function

'**************************************************************************************
Function LogGCFile(ByVal bvFilename, ByVal bvLine)
   On Error Resume Next
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	'Open the text file for appending
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Log\"
	Set objTextStream = objFSO.OpenTextFile(FilePath + bvFilename + ".txt", 8, 1)
	'write the line to the file 
	objTextStream.WriteLine CSTR(Date()) + " " + CSTR(Time()) + " " + bvLine
	'Close the file and clean up
	objTextStream.Close
	Set objTextStream = Nothing
	Set objFSO = Nothing
End Function


%>

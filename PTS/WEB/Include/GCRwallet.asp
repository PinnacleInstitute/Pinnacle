<!--#include virtual="include\aspJSON1.17.asp" -->
<%
g_GC_API_SECRET  = "vV4kSPTKUrXRy9WwjOd40G0T7X4GQ7DN"
g_GC_URL = "https://wallet.gcrmarketing.com/api/"
g_GC_Test = False

'***********************************************************************
Function GCRWallet_Create( ByVal bvEmail, ByRef brPassword ) 
    On Error Resume Next
    '{
    '	"success" : true,
    '	"result" : [{ "RandomPassword" : "1837629133" }]
    '}
    '{"success":false,"message":"User already exists."}

    sURL = g_GC_URL + "createuser/?email=" + bvEmail
    sResponse = GC_SendApiRequest( sURL, "", "POST" )

    LogGCFile "GCRWallet", "CREATE: " + bvEmail + " - " + sResponse

    If InStr( sResponse, """success"":" ) = 0 Then
        CreateGCRWallet = "ERROR: " + sResponse
    Else
        Set oJSON = New aspJSON
        oJSON.loadJSON(sResponse)

        success = oJSON.data("success")
        If success Then
            For Each itm In oJSON.data("result") 'process array
                Set this = oJSON.data("result").item(itm)
                brPassword = this.item("RandomPassword")
            Next
            GCRWallet_Create = "ok"
        Else
            GCRWallet_Create = oJSON.data("message")
        End If 
             
        Set oJSON = Nothing
    End If
End Function

'***********************************************************************
Function GCRWallet_Info( ByVal bvEmail, ByRef brAddress, ByRef brBalance, ByRef br2FA, ByRef brCreated ) 
    On Error Resume Next
    '{
    '	"success" : true,
    '	"result" : [{ "EmailAddress" : "some@example.com", "DepositAddress" : "GPjKbYQaqS7cTQCy9eJMZyu6JGWxT1fRKh", "AvailableBalance" : "0.00000000" }]
    '}
    '{"success":false,"message":"User not found."}

    sURL = g_GC_URL + "getuser/?email=" + bvEmail
    sResponse = GC_SendApiRequest( sURL, "", "POST" )

    LogGCFile "GCRWallet", "INFO: " + bvEmail + " - " + sResponse

    If InStr( sResponse, """success"":" ) = 0 Then
        GCRWallet_Info = "ERROR: " + sResponse
    Else
        Set oJSON = New aspJSON

        oJSON.loadJSON(sResponse)

        success = oJSON.data("success")
        If success Then
            For Each itm In oJSON.data("result") 'process array
                Set this = oJSON.data("result").item(itm)
                brAddress = this.item("DepositAddress")
                brBalance = this.item("AvailableBalance")
                br2FA = this.item("2FA")
                brCreated = this.item("Created")
            Next
            GCRWallet_Info = "ok"
        Else
            GCRWallet_Info = oJSON.data("message")
        End If 
             
        Set oJSON = Nothing
    End If
End Function

'***********************************************************************
Function GCRWallet_Credit( ByVal bvEmail, ByVal bvCredit ) 
    On Error Resume Next
    '{"success":true}
    '{"success":false,"message":"User not found."}

    sURL = g_GC_URL + "credituser/?email=" + bvEmail + "&credit=" + CStr(bvCredit)
    sResponse = GC_SendApiRequest( sURL, "", "POST" )

    LogGCFile "GCRWallet", "CREDIT: " + bvEmail + " - " + CStr(bvCredit) + " - " + sResponse

    If InStr( sResponse, """success"":" ) = 0 Then
        GCRWallet_Credit = "ERROR: " + sResponse
    Else
        Set oJSON = New aspJSON
        oJSON.loadJSON(sResponse)

        success = oJSON.data("success")
        If success Then
            GCRWallet_Credit = "ok"
        Else
            GCRWallet_Credit = "ERROR:" + oJSON.data("message")
        End If 
             
        Set oJSON = Nothing
    End If
End Function

'***********************************************************************
Function GCRWallet_Disable2FA( ByVal bvEmail ) 
    On Error Resume Next
    '{"success":true}
    '{"success":false,"message":"User not found."}

    sURL = g_GC_URL + "disable2fa/?email=" + bvEmail
    sResponse = GC_SendApiRequest( sURL, "", "POST" )

    LogGCFile "GCRWallet", "DISABLE: " + bvEmail + " - " + sResponse

    If InStr( sResponse, """success"":" ) = 0 Then
        GCRWallet_Disable2FA = "ERROR: " + sResponse
    Else
        Set oJSON = New aspJSON
        oJSON.loadJSON(sResponse)

        success = oJSON.data("success")
        If success Then
            GCRWallet_Disable2FA = "ok"
        Else
            GCRWallet_Disable2FA = "ERROR:" + oJSON.data("message")
        End If 
             
        Set oJSON = Nothing
    End If
End Function

'***********************************************************************
Function GCRWallet_UpdateEmail( ByVal bvEmail, ByVal bvNewEmail ) 
    On Error Resume Next
    '{"success":true}
    '{"success":false,"message":"Email already used."}

    sURL = g_GC_URL + "updateemail/?email=" + bvEmail + "&newemail=" + bvNewEmail
    sResponse = GC_SendApiRequest( sURL, "", "POST" )

    LogGCFile "GCRWallet", "EMAIL: " + bvEmail + " - " + bvNewEmail + " - " + sResponse

    If InStr( sResponse, """success"":" ) = 0 Then
        GCRWallet_UpdateEmail = "ERROR: " + sResponse
    Else
        Set oJSON = New aspJSON
        oJSON.loadJSON(sResponse)

        success = oJSON.data("success")
        If success Then
            GCRWallet_UpdateEmail = "ok"
        Else
            GCRWallet_UpdateEmail = "ERROR:" + oJSON.data("message")
        End If 
             
        Set oJSON = Nothing
    End If
End Function

'****************************************************************************************
Function GC_SendApiRequest(byVal bvURL, byVal bvRequest, byVal bvMethod)
    On Error Resume Next
    Dim signature, oHTTP, sResponse 

    signature = GC_SHA256(g_GC_API_SECRET, bvURL)

    If g_GC_Test Then Response.Write "<BR><BR>URL: " & bvURL

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open bvMethod, bvURL
        .setRequestHeader "apisign", signature
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

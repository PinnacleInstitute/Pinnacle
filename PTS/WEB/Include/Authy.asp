<!--#include virtual="include\aspJSON1.17.asp" -->
<%
g_AUTHY_API_KEY  = ""
g_AUTHY_API_KEY_TEST = "f45ec9af9dcb7419dc52b05889c858e9"
g_AUTHY_API_KEY_PRODUCTION = "22f3b423891d5432e029c42d10429c0e"
g_AUTHY_URL = "https://api.authy.com"
g_AUTHY_TESTURL = "http://sandbox-api.authy.com"
g_AUTHY_Test = False
'***********************************************************************
Function SetAuthyKey(ByVal bvKey)
    On Error Resume Next
    g_AUTHY_API_KEY = bvKey
End Function

'***********************************************************************
Function CreateAuthyUser( ByVal bvEmail, ByVal bvCellPhone, ByVal bvCountryCode ) 
    On Error Resume Next

    If g_AUTHY_Test Then
        sURL = g_AUTHY_TESTURL
        If g_AUTHY_API_KEY  = "" Then g_AUTHY_API_KEY = g_AUTHY_API_KEY_TEST
    Else
        sURL = g_AUTHY_URL 
        If g_AUTHY_API_KEY  = "" Then g_AUTHY_API_KEY = g_AUTHY_API_KEY_PRODUCTION
    End If

    sURL = sURL + "/protected/json/users/new?api_key=" + g_AUTHY_API_KEY
    
    sRequest = "{" _
    + """user[email]"":""" + bvEmail + """," _
    + """user[cellphone]"":""" + bvCellPhone + """," _
    + """user[country_code]"":""" + bvCountryCode + """" _
    + "}"

    sResponse = AUTHY_SendApiRequest( sURL, sRequest, "POST" )

    LogAUTHYFile "Authy", sRequest + " - " + sResponse

    If InStr( sResponse, """id"":" ) = 0 Then
        CreateAuthyUser = "ERROR: " + sResponse
    Else
        Set oJSON = New aspJSON
        oJSON.loadJSON(sResponse)
        CreateAuthyUser = oJSON.data("id")
        Set oJSON = Nothing
    End If
End Function

'***********************************************************************
Function VerifyAuthyUser( ByVal bvAuthyID, ByVal bvToken ) 
    On Error Resume Next

    If g_AUTHY_Test Then
        sURL = g_AUTHY_TESTURL
        If g_AUTHY_API_KEY  = "" Then g_AUTHY_API_KEY = g_AUTHY_API_KEY_TEST
    Else
        sURL = g_AUTHY_URL 
        If g_AUTHY_API_KEY  = "" Then g_AUTHY_API_KEY = g_AUTHY_API_KEY_PRODUCTION
    End If
    
    sURL = sURL + "/protected/json/verify/" + bvToken + "/" + bvAuthyID + "?api_key=" + g_AUTHY_API_KEY

    sRequest = ""

    sResponse = AUTHY_SendApiRequest( sURL, sRequest, "GET" )

    LogAUTHYFile "Authy", bvToken + "/" + bvAuthyID + " - " + sResponse

    Verify = InStr( sResponse, """success"":""true""" )

    If Verify = 0 Then
	    VerifyAuthyUser = "ERROR: " + sResponse 
    Else
	    VerifyAuthyUser = "1"
    End If 

End Function

'****************************************************************************************
Function AUTHY_SendApiRequest(byVal bvURL, byVal bvRequest, byVal bvMethod)
    On Error Resume Next
    Dim signature, oHTTP, sResponse 

    If g_AUTHY_Test Then Response.Write "<BR><BR>URL: " & bvURL
    If g_AUTHY_Test Then Response.Write "<BR><BR>Request: " & bvRequest

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open bvMethod, bvURL
        .setRequestHeader "Content-Type", "application/Json"
        .send bvRequest
        sResponse = .responseText
    End With
    Set oHTTP = Nothing77

    If g_AUTHY_Test Then Response.Write "<BR><BR>Response: " & sResponse
    AUTHY_SendApiRequest = sResponse
End Function

'**************************************************************************************
Function LogAUTHYFile(ByVal bvFilename, ByVal bvLine)
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
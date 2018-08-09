<!--#include virtual="include\aspJSON1.17.asp" -->
<!--#include virtual="include\Base64.asp" -->
<%
'Test Member ID = 454651018446 / netellertest_USD@neteller.com
g_NT_MERCHANT  = "45432"
g_NT_ID  = ""
g_NT_SECRET  = ""
g_NT_URL = "https://api.neteller.com/v1/"
g_NT_URL = "https://test.api.neteller.com/v1/"
g_NT_Test = True
'***********************************************************************
Function NT_Security(ByVal bvID, ByVal bvSecret)
    On Error Resume Next
    g_NT_ID = bvID
    g_NT_SECRET = bvSecret
End Function

'***********************************************************************
Function NT_Payment( ByVal bvPaymentID, ByVal bvAmount ) 
    On Error Resume Next

    sURL = g_NT_URL + "orders"

    sRequest = "{""order"":{" _
    + """merchantRefId"":""" + CStr(bvPaymentID) + """," _
    + """totalAmount"":" + NT_Amount(bvAmount) + "," _
    + """currency"":""USD""," _
    + """lang"":""en_US""" _
    + "}}"

    sResponse = NT_SendApiRequest( sURL, sRequest, "POST" )

    NT_LogFile "NTPayment", sResponse

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)
    status = oJSON.data("transaction")("status")

    If status <> "pending" Then
        result = "ERROR: " + oJSON.data("error")("message")
        NT_LogFile "NTPayment", sRequest
    Else
        result = oJSON.data("orderId")
    End If
    NT_Payment = result
    Set oJSON = Nothing
             
End Function

'***********************************************************************
Function NT_Payout( ByVal bvUsername, ByVal bvPayoutID, ByVal bvAmount, ByVal bvMessage ) 
    On Error Resume Next

    sURL = g_NT_URL + "transferOut"

    If bvMessage = "" Then bvMessage = "GCR Marketing Payout"
    If InStr(bvUsername, "@") > 0 Then identity = "email" Else identity = "accountid"
    
    sRequest = "{""payeeProfile"":{" _
    + """" + identity + """:""" + bvUsername + """" _
    + "},""transaction"":{" _
    + """amount"":" + NT_Amount(bvAmount) + "," _
    + """currency"":""USD""," _
    + """merchantRefId"":""" + CStr(bvPayoutID) + """" _
    + "}," _
    + """message"":""" + bvMessage + """" _
    + "}}"

    sResponse = NT_SendApiRequest( sURL, sRequest, "POST" )

    NT_LogFile "NTPayout", sResponse

    Set oJSON = New aspJSON
    oJSON.loadJSON(sResponse)
    status = oJSON.data("transaction")("status")

    If status <> "accepted" Then
        result = "ERROR: " + oJSON.data("error")("message")
        NT_LogFile "NTPayout", sRequest
    Else
        result = oJSON.data("transaction")("id")
    End If

    NT_Payout = result

    Set oJSON = Nothing
End Function

'***********************************************************************
Function NT_Amount( ByVal bvAmount ) 
    On Error Resume Next

    sAmount = CStr(bvAmount)
    If InStr(sAmount, ".") > 0 Then
        NT_Amount = Replace(sAmount, ".", "")
    Else
        NT_Amount = sAmount + "00"
    End If 
End Function
    
'****************************************************************************************
Function NT_SendApiRequest(byVal bvURL, byVal bvRequest, byVal bvMethod)
    On Error Resume Next
    Dim oHTTP, sResponse 

    If g_NT_Test Then Response.Write "<BR><BR>URL: " & bvURL
    If g_NT_Test Then Response.Write "<BR><BR>Request: " & bvRequest

    tmpAuthCode = Base64Encode( g_NT_ID  + ":" + g_NT_SECRET )
'    If g_NT_Test Then Response.Write "<BR><BR>AuthCode: " & tmpAuthCode

    'Get Token for API Call
    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        tmpURL = g_NT_URL + "oauth2/token?grant_type=client_credentials"
        .open "POST", tmpURL
        .setRequestHeader "Authorization", "Basic " + tmpAuthCode
        .setRequestHeader "Content-Type", "application/Json"
        .setRequestHeader "Cache-Control", "no-cache"
        .send ""
        sResponse = .responseText

	If g_NT_Test Then Response.Write "<BR><BR>Response: " & sResponse

        Set oJSON = New aspJSON
        oJSON.loadJSON(sResponse)
        tmpToken = oJSON.data("accessToken")
        Set oJSON = Nothing
    End With
    Set oHTTP = Nothing

'    If g_NT_Test Then Response.Write "<BR><BR>Token: " & tmpToken

    sResponse = ""
    If tmpToken <> "" Then
        Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
        With oHTTP
            .open bvMethod, bvURL
            .setRequestHeader "Content-Type", "application/Json"
            .setRequestHeader "Authorization", "Bearer " + tmpToken
            .send bvRequest
            sResponse = .responseText
        End With
        Set oHTTP = Nothing
    End If

    If g_NT_Test Then Response.Write "<BR><BR>Response: " & sResponse
    NT_SendApiRequest = sResponse
End Function

'**************************************************************************************
Function NT_LogFile(ByVal bvFilename, ByVal bvLine)
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

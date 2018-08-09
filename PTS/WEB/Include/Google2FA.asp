<%
'***********************************************************************
'*** Google Authenticator 2FA Functions
'*** Reference: https://brandonpotter.wordpress.com/2014/09/07/implementing-free-two-factor-authentication-in-net-using-google-authenticator/
'***********************************************************************
Function Create2FAUser( ByVal bvApp, ByVal bvUser, ByVal bvKey, ByRef brQRCodeUrl, ByRef brSetupCode ) 
    On Error Resume Next
    Result = 0
    Set o2FA = server.CreateObject("Google2FA.Authenticator")
    If o2FA Is Nothing Then
        Response.write "Unable to Create Object - Google2FA.Authenticator"
    Else
        With o2FA
         	.GenerateSetupCode bvApp, bvUser, bvKey, 300, 300
 	        brQRCodeUrl = .GetQrCodeImageUrl
            brSetupCode = .GetManualEntrySetupCode
            Result = 1
        End With
    End If
    Set o2FA = Nothing
    Create2FAUser = Result
End Function

'***********************************************************************
Function Verify2FAUser( ByVal bvKey, ByVal bvCode ) 
    On Error Resume Next
    Set o2FA = server.CreateObject("Google2FA.Authenticator")
    If o2FA Is Nothing Then
        Response.write "Unable to Create Object - Google2FA.Authenticator"
    Else
       	Verify2FAUser = o2FA.ValidateTwoFactorPIN( bvKey, bvCode )
    End If
    Set o2FA = Nothing
End Function
    
'UUID Generator for UUID Version 4 (Random)
'Ref: http://www.ietf.org/rfc/rfc4122.txt
'Sample UUID: 7d265bf8-931c-42dc-8417-9ef3c2bbaa4e
'***********************************************************************
Randomize Timer
Function UUID()
   Dim i, RndNum
   For i = 0 to 7
      RndNum = CLng(rnd * "&HFFFF")
     'if i = 0 then RndNum = RndNum Xor (CLng(Date) And "&HFFFF")
      If i = 3 Then RndNum = (RndNum And "&HFFF") Or "&H4000"
      If i = 4 Then RndNum = (RndNum And "&H3FFF") Or "&H8000"
      UUID = UUID + String(4 - Len(Hex(RndNum)), "0") + LCase(Hex(RndNum))
      If i=1 Or i=2 Or i=3 Or i=4 Then UUID = UUID + "-"
   Next
End Function

'***********************************************************************
Function Log2FAFile(ByVal bvFilename, ByVal bvLine)
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
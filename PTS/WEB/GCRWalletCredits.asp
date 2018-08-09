<!--#include file="Include\GCRWallet.asp"-->

<% Response.Buffer=true
On Error Resume Next

PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST Test = 0

Server.ScriptTimeout = 14400

If Test = 1 Then Response.write "<BR>Start: " + Err.description

Set oGCRs = server.CreateObject("ptsGCRUser.CGCRs")
If  Test = 1 And oGCRs Is Nothing Then
    Response.write "Unable to Create Object - ptsGCRUser.CGCRs"
    Response.end
End If

Set oGCR = server.CreateObject("ptsGCRUser.CGCR")
If  Test = 1 And oGCR Is Nothing Then
    Response.write "Unable to Create Object - ptsGCRUser.CGCR"
    Response.end
End If


Today = DATE()
LogFilename = CSTR(Year(Today)) + "-" + CSTR(Month(Today)) + "-" + CSTR(Day(Today))

With oGCRs
    .CustomList 2, 0, 0, 0

    For Each oItem in oGCRs
        With oItem
            If Test = 0 Then
                a = Split(.Result, "|")
                Email = a(0)
                Coins = a(1)
                GCRWallet_Credit Email, Coins
                LogFile LogFilename, Email + " - " + CStr(Coins)
                'Update This Mining Status = distributed 
                MiningID = CLng(.GCRID)
                oGCR.Custom 400, 0, MiningID, 0
            End If
        End With
    Next
End With

Set oGCR = Nothing
Set oGCRs = Nothing

If Test = 1 Then Response.write "<BR>End: " + Err.description

'*****************************************************************************
Function LogFile(ByVal bvFilename, ByVal bvLine)
   On Error Resume Next
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	'Open the text file for appending
	FilePath = "C:\PTS\WEB\Log\Mining\"
	Set objTextStream = objFSO.OpenTextFile(FilePath + bvFilename + ".txt", 8, 1)
	'write the line tothe file 
	objTextStream.WriteLine CSTR(Time()) + " " + bvLine
	'Close the file and clean up
	objTextStream.Close
	Set objTextStream = Nothing
	Set objFSO = Nothing
End Function

%>
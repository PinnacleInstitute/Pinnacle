<!--#include file="Include\LiveDrive.asp"-->
<% Response.Buffer=true

On Error Resume Next
Server.ScriptTimeout = 14400

Set oCloudZows = server.CreateObject("ptsCloudZowUser.CCloudZows")
If oCloudZows Is Nothing Then
	Response.write "Error Creating Object - ptsCloudZowUser.CCloudZows"
End If
Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
If oMachine Is Nothing Then
	Response.write "Error Creating Object - ptsMachineUser.CMachine"
End If

oCloudZows.CustomList 2, 0, 0, 0
total = 0
good = 0
bad = 0
For Each oItem in oCloudZows
	total = total + 1
	MachineID = oItem.CloudZowID
	With oMachine
		.Load MachineID, 1
		Result = GetUser( oMachine )
		If Result = "OK" Then
			.Save 1
			good = good + 1
		Else
			bad = bad + 1	
		End If	
	End With
Next
'response.write "<BR>Total: " & total
'response.write "<BR>Good: " & good
'esponse.write "<BR>Bad: " & bad
LogFile "GetBackupData", "Total:" + CStr(total) + " Good:" + CStr(good) + " Bad:" + CStr(bad)
	      
Set oMachine = Nothing
Set oCloudZow = Nothing

'*****************************************************************************
Function LogFile(ByVal bvFilename, ByVal bvLine)
   On Error Resume Next
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	'Open the text file for appending
	FilePath = SysPath + "Log\"
	Set objTextStream = objFSO.OpenTextFile(FilePath + bvFilename + ".txt", 8, 1)
	'write the line tothe file 
	objTextStream.WriteLine CSTR(Date()) + " " + CSTR(Time()) + " " + bvLine
	'Close the file and clean up
	objTextStream.Close
	Set objTextStream = Nothing
	Set objFSO = Nothing
End Function

%>
'*****************************************************************************
' Get Backed up data for all active LiveDrive Computers with no backup data
'*****************************************************************************
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST SysFile = "NoBackupData"

On Error Resume Next

IncludeFile "Include\LiveDrive_vbs.asp"

Set oCloudZows = CreateObject("ptsCloudZowUser.CCloudZows")
Set oMachine = CreateObject("ptsMachineUser.CMachine")

LogFile SysFile, "Started"

oCloudZows.CustomList 4, 0, 0, 0
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
LogFile SysFile, "Total:" + CStr(total) + " Good:" + CStr(good) + " Bad:" + CStr(bad)
	      
Set oMachine = Nothing
Set oCloudZows = Nothing

'*****************************************************************************
Function IncludeFile(ByVal bvFilename)
   On Error Resume Next
	Set oFSO = CreateObject("Scripting.FileSystemObject")
	Set oTextStream = oFSO.OpenTextFile(SysPath + bvFilename, 1)
	sText = oTextStream.ReadAll
	oTextStream.Close
	ExecuteGlobal sText
	Set oTextStream = Nothing
	Set oFSO = Nothing
End Function

'*****************************************************************************
Function LogFile(ByVal bvFilename, ByVal bvLine)
   On Error Resume Next
	Set oFSO = CreateObject("Scripting.FileSystemObject")
	'Open the text file for appending
	FilePath = SysPath + "Log\"
	Set oTextStream = oFSO.OpenTextFile(FilePath + bvFilename + ".txt", 8, 1)
	'write the line to the file 
	oTextStream.WriteLine CSTR(Date()) + " " + CSTR(Time()) + " " + bvLine
	'Close the file and clean up
	oTextStream.Close
	Set oTextStream = Nothing
	Set oFSO = Nothing
End Function


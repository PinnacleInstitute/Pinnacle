'*****************************************************************************
' Drip Email Campaign for No Backup Data
'*****************************************************************************
PUBLIC CONST SysFile = "NoBackupOld"
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST SysEmail = """CloudZow!"" <support@cloudzow.com>"

On Error Resume Next

Set oHTMLFile = CreateObject("wtHTMLFile.CHTMLFile")
Set oEmailees = CreateObject("ptsEmaileeUser.CEmailees")
Set oMail = CreateObject("CDO.Message")
With oMail
    .Sender = SysEmail
    .From = SysEmail
End With

For x = 3 To 3
	tmpDay = 0
	tmpSubject = ""
	isCC = 0
	Select Case x
	Case 1 
		tmpDay = 1
		tmpSubject = "Is Your Important Information Safe?"
	Case 2
		tmpDay = 3
		tmpSubject = "Don't Risk Your Important Information!"
	Case 3
		tmpDay = 5
		tmpSubject = "Eliminate the PAIN from Lost Information!"
	End Select
	
    With oHTMLFile
		.Filename = SysFile + CSTR(tmpDay) + ".htm"
		.Path = SysPath + "Drip\"
		.Language = "en"
		.Project = "Pinnacle"
		.Load 
		Body = .Data
    End With

	With oEmailees
		'Get Machines with no backup data activated before 6/15/12
		.ListCustom 5, 205, "6/15/12", "", "", "", ""
		
		For Each oItem in oEmailees
			tmpTo = ""
			tmpCC = ""
			tmpBody = ""
			With oItem
				tmpTo = .Email
				tmpName = .FirstName + " " + .LastName
				If isCC = 1 Then tmpCC = .Data3
				tmpBody = Replace( Body, "{id}", .EmaileeID )
				tmpBody = Replace( tmpBody, "{firstname}", .FirstName )
				tmpBody = Replace( tmpBody, "{lastname}", .LastName )
			End With	
			With oMail
				.To = tmpTo
				.CC = tmpCC
				.Subject = tmpName + ": " + tmpSubject
				.HTMLBody = tmpBody
				.Send
			End With
			LogFile SysFile, tmpTo + " - " + CStr(tmpDay)
		Next
	End With
Next

Set oMail = Nothing
Set oEmailees = Nothing
Set oHTMLFile = Nothing

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

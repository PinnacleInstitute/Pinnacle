'*****************************************************************************
' Drip Email Campaign for Free Trials
'*****************************************************************************
PUBLIC CONST SysFile = "FreeTrial"
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

For x = 1 To 6
	tmpDay = 0
	tmpSubject = ""
	isCC = 0
	Select Case x
	Case 1
		tmpDay = 3
		tmpSubject = "CloudZow protects all your valuable information"
	Case 2
		tmpDay = 8
		tmpSubject = "CloudZow Backup can be optimized for your personal computer"
	Case 3
		tmpDay = 13
		tmpSubject = "Your CloudZow Trial is about to expire - subscribe today"
	Case 4
		tmpDay = 15
		tmpSubject = "Your CloudZow Online Data backup account expires today!"
	Case 5
		tmpDay = 17
		tmpSubject = "IMPORTANT REMINDER: Your CloudZow Trial has expired."
		isCC = 1
	Case 6
		tmpDay = 22
		tmpSubject = "URGENT: Last chance to keep backup files from being deleted"
		isCC = 1
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
		.ListCustom 5, 200, CStr(tmpDay), "", "", "", ""
		
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

'*****************************************************************************
' Drip Email Campaign for New Affiliates
'*****************************************************************************
PUBLIC CONST SysFile = "7NewMember"
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST SysEmail = """myTrackerPro!"" <support@myTrackerPro.com>"

On Error Resume Next

Set oHTMLFile = CreateObject("wtHTMLFile.CHTMLFile")
Set oEmailees = CreateObject("ptsEmaileeUser.CEmailees")
Set oMail = CreateObject("CDO.Message")
With oMail
    .Sender = SysEmail
    .From = SysEmail
End With

For x = 1 To 9
	tmpDay = 0
	tmpSubject = ""
	isCC = 0
	Select Case x
	Case 1 
		tmpDay = 1
		tmpSubject = "21 days to a GREAT habit!"
	Case 2
		tmpDay = 2
		tmpSubject = "Get the most out of your Tracker!"
	Case 3
		tmpDay = 3
		tmpSubject = "How to double your productivity AND your income!"
	Case 4
		tmpDay = 4
		tmpSubject = "The best feeling in the world!"
	Case 5
		tmpDay = 5
		tmpSubject = "4 'Money-Sucking' distractions to eliminate"
	Case 6
		tmpDay = 6
		tmpSubject = "Simple trick to get more done...PERIOD"
	Case 7
		tmpDay = 7
		tmpSubject = "How to have a 'Heart-Pumping' sense of urgency"
	Case 8
		tmpDay = 8
		tmpSubject = "Are you wasting $255.61 PER HOUR?"
	Case 9
		tmpDay = 9
		tmpSubject = "The cure for 'Lack Of Money Syndrome'"
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
		.ListCustom 7, 210, CStr(tmpDay), "", "", "", ""
		
		For Each oItem in oEmailees
			tmpTo = ""
			tmpCC = ""
			tmpBody = ""
			With oItem
				tmpTo = .Email
				tmpName = .FirstName + " " + .LastName
				tmpGroupID = .Data4
				If isCC = 1 Then tmpCC = .Data3
				tmpBody = Replace( Body, "{id}", .EmaileeID )
				tmpBody = Replace( tmpBody, "{grp}", tmpGroupID )
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

'*****************************************************************************
' Drip Email Campaign for New Affiliates
'*****************************************************************************
PUBLIC CONST SysFile = "NewAffiliate"
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

Start = DateDiff( "d", "6/28/12", Date() )

For x = Start To Start
	tmpDay = 0
	tmpSubject = ""
	isCC = 0
	Select Case x
	Case 1 
		tmpDay = 1
		tmpSubject = "Getting Started with CloudZow!"
	Case 2
		tmpDay = 2
		tmpSubject = "CloudZow Fast Start Program"
	Case 3
		tmpDay = 3
		tmpSubject = "Let's Get Started with CloudZow!"
	Case 4
		tmpDay = 4
		tmpSubject = "Work Your CloudZow Plan!"
	Case 5
		tmpDay = 5
		tmpSubject = "CloudZow Formula for Success!"
	Case 6
		tmpDay = 6
		tmpSubject = "How to Really Make Money with CloudZow!"
	Case 7
		tmpDay = 7
		tmpSubject = "Learn How to Use the CloudZow Tools!"
	Case 8
		tmpDay = 8
		tmpSubject = "More CloudZow Fast Start Money!"
	Case 9
		tmpDay = 9
		tmpSubject = "Build Your Business with Sizzle Cards!"
	Case 10
		tmpDay = 10
		tmpSubject = "CloudZow Compensation Plan"
	Case 15
		tmpDay = 15
		tmpSubject = "CloudZow Manager-A-Month"
	Case 20
		tmpDay = 20
		tmpSubject = "CloudZow Leadership Development"
	End Select

If tmpDay > 0 Then
	
    With oHTMLFile
		.Filename = SysFile + CSTR(tmpDay) + ".htm"
		.Path = SysPath + "Drip\"
		.Language = "en"
		.Project = "Pinnacle"
		.Load 
		Body = .Data
    End With

	With oEmailees
		'Get all old members enrolled before 6/28/12
		.ListCustom 5, 202, "-1", "", "", "", ""
		
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
			LogFile SysFile + "Old", tmpTo + " - " + CStr(tmpDay)
		Next
	End With

End If
	
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

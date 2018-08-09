<!--#include file="Include\System.asp"-->
<% Response.Buffer=true

On Error Resume Next

Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
If oHTMLFile Is Nothing Then
	Response.Write "<BR>Error Creating Object wtHTMLFile.CHTMLFile"
End If	
Set oEmailees = server.CreateObject("ptsEmaileeUser.CEmailees")
If oEmailees Is Nothing Then
	Response.Write "<BR>Error Creating Object ptsEmaileeUser.CEmailees"
End If	
Set oMail = server.CreateObject("CDO.Message")
If oMail Is Nothing Then
	Response.Write "<BR>Error Creating Object CDO.Message"
End If	
With oMail
    .Sender = "support@cloudzow.com"
    .From = "support@cloudzow.com"
End With

reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")

For x = 1 To 4
	tmpDay = 0
	tmpSubject = ""
	isCC = 0
	Select Case x
	Case 1 
		tmpDay = 13
		tmpSubject = "Your CloudZow Trial is about to expire - subscribe today"
	Case 2
		tmpDay = 15
		tmpSubject = "Your CloudZow Online Data backup account expires today!"
	Case 3
		tmpDay = 17
		tmpSubject = "IMPORTANT REMINDER: Your CloudZow Trial has expired."
		isCC = 1
	Case 4
		tmpDay = 22
		tmpSubject = "URGENT: Last chance to keep backup files from being deleted"
		isCC = 1
	End Select
	
    With oHTMLFile
		.Filename = "FreeTrial" + CSTR(tmpDay) + ".htm"
		.Path = reqSysWebDirectory + "Sections\"
		.Language = "en"
		.Project = "Pinnacle"
		.Load 
		Body = .Data
    End With

	With oEmailees
		.ListCustom 5, 95, "2", CStr(tmpDay), "", "", ""
		
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
		Next
	End With
Next

Set oMail = Nothing
Set oEmailees = Nothing
Set oHTMLFile = Nothing

%>
<!--#include file="Include\System.asp"-->
<% Response.Buffer=true

reqMID = Request.Item("MID")

Set oMember = server.CreateObject("ptsMemberUser.CMember")
With oMember
	.SysCurrentLanguage = reqSysLanguage
	.Load CLng(reqMID), 1
	tmpAuthUserID = .AuthUserID
	tmpIcons = .Icons
End With 

File = "LiveDesktop\Users\" + CStr(tmpAuthUserID) + ".xml"
Set oSystem = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oSystem.load server.MapPath(File)
If oSystem.parseError <> 0 Then
   Response.Write "Load System file failed with error code " + CStr(oSystem.parseError)
   Response.End
End If
SET oNode = oSystem.selectSingleNode("SYSTEM")
With oNode
   reqSysUserOptions = .getAttribute("useroptions")
   reqVisitDate = .getAttribute("visitdate")
End With

With oMember
	If reqVisitDate = "" Then reqVisitDate = .VisitDate
	If reqVisitDate = "" Then reqVisitDate = Date()
	xmlDB = .Dashboard(CLng(reqMID), CDate(reqVisitDate), reqSysUserOptions)
End With 
Set oMember = Nothing

If (InStr(reqSysUserOptions,"2") <> 0) Then
	Set oAppts = server.CreateObject("ptsApptUser.CAppts")
	With oAppts
		.ListToday CLng(reqMID), Date(), reqSysUserOptions
	    
		'calculate and store day and time
		For Each oAppt in oAppts
			With oAppt
				If .StartDate <> .EndDate Then .Opt = "1"
				If .IsEdit <> "0" Then .Opt = "2"
				If .IsAllDay = 0 Then .ApptName = .StartTime + " " + .ApptName
				'convert ApptID for other types
				Select Case .ApptType
					Case "-70" 
						.ApptID = CLng(.ApptID) mod 700000000 'Goals 
						'If the goal date has happened yet, don't mark status 
						If CDate(.StartDate) >= Date() And .Status <> "3" Then .Status = 0
					Case "-701" 
						.ApptID = CLng(.ApptID) mod 700000000 'Service Goals 
						'If the goal date has happened yet, don't mark status 
						If CDate(.StartDate) >= Date() And .Status <> "3" Then .Status = 0
					Case "-22" 
						.ApptID = CLng(.ApptID) mod 220000000 'Leads 
						If CDate(.StartDate) < Date() Then .CalendarID = 1
					Case "-81" 
						.ApptID = CLng(.ApptID) mod 810000000 'Sales 
						If CDate(.StartDate) < Date() Then .CalendarID = 1
					Case "-96" 
						.ApptID = CLng(.ApptID) mod 960000000 'Events
					Case "-75" 
						.ApptID = CLng(.ApptID) mod 750000000 'Projects 
						'If the project date has happened yet, don't mark status 
						If CDate(.StartDate) >= Date() And .Status <> "2" Then .Status = 0
					Case "-74" 
						.ApptID = CLng(.ApptID) mod 740000000 'Tasks 
						'If the task date has happened yet, don't mark status 
						If CDate(.StartDate) >= Date() And .Status <> "2" Then .Status = 0
				End Select
				'Calculate the Military Time for sorting the appts 
				If .StartTime = "" Then 
					.Reminder = 0
				Else
					tmpTime = .StartTime
					newTime = "0"
					length = Len(tmpTime)
					For x = 1 to length
						c = Mid(tmpTime, x, 1)
						If IsNumeric(c) Then newTime = newTime + c
					Next
					If Left(newTime,3) = "012" Then
						If InStr(UCase(tmpTime), "A") Then 
							newTime = "0" + Mid(tmpTime, 3,2)
						End If
					Else
						If InStr(UCase(tmpTime), "P") Then 
							newTime = (Clng(newTime) + 1200)
						End If
					End If
					.Reminder = newTime
				End If   
			End With
		Next
		xmlAppts = .XMLDashboard()
	End With
	Set oAppts = Nothing
End If

If (InStr(reqSysUserOptions,"H") <> 0) Then
	Set oGoals = server.CreateObject("ptsGoalUser.CGoals")
	With oGoals
		.SysCurrentLanguage = reqSysLanguage
		.ListActiveTrack CLng(reqMID)
		xmlGoals = .XMLDashboard()
	End With
	Set oGoals = Nothing
End If

xmlIcons = "<ICONS>"
While tmpIcons <> "" 
    tmpIcon = Left(tmpIcons, 1)
    tmpIcons = Mid(tmpIcons, 2)
    tmpName = ""
    tmpFile = ""
    tmpURL = ""
    Select Case tmpIcon
        Case "E"
        If InStr(reqSysUserOptions,"E") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Sales"" file=""IconE.gif"" url=""8101.asp""/>"
        End If
        Case "F"
        If InStr(reqSysUserOptions,"F") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Projects"" file=""IconF.gif"" url=""7501.asp""/>"
        End If
        Case "G"
        If InStr(reqSysUserOptions,"G") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Mentoring"" file=""IconG.gif"" url=""0410.asp""/>"
        End If
        Case "H"
        If InStr(reqSysUserOptions,"H") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Goals"" file=""IconH.gif"" url=""7001.asp""/>"
        End If
        Case "I"
        If InStr(reqSysUserOptions,"I") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""MyInfo"" file=""IconI.gif"" url=""0403.asp""/>"
        End If
        Case "K"
        If InStr(reqSysUserOptions,"K") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Classes"" file=""IconK.gif"" url=""1311.asp""/>"
        End If
        Case "L"
        If InStr(reqSysUserOptions,"L") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Assessments"" file=""IconL.gif"" url=""3411.asp""/>"
        End If
        Case "2"
        If InStr(reqSysUserOptions,"2") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Calendar"" file=""Icon2.gif"" url=""Calendar.asp""/>"
        End If
        Case "6"
        If InStr(reqSysUserOptions,"6") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Customers"" file=""Icon6.gif"" url=""8151.asp""/>"
        End If
        Case "a"
        If InStr(reqSysUserOptions,"a") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Resources"" file=""Icon_a.gif"" url=""9304.asp""/>"
        End If
        Case "h"
        If InStr(reqSysUserOptions,"h") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Contacts"" file=""Icon_h.gif"" url=""2201.asp""/>"
        End If
        Case "o"
        If InStr(reqSysUserOptions,"o") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Genealogy"" file=""Icon_o.gif"" url=""0470.asp""/>"
        End If
        Case "w"
        If InStr(reqSysUserOptions,"w") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Finances"" file=""Icon_w.gif"" url=""0475.asp""/>"
        End If
    End Select
Wend
xmlIcons = xmlIcons + "</ICONS>"

Set oShortcuts = server.CreateObject("ptsShortcutUser.CShortcuts")
With oShortcuts
	.List tmpAuthUserID, 1
	xmlShortcuts = .XMLShortcuts()
End With
Set oShortcuts = Nothing

If err.Number = 0 Then
    Response.Write "<DATA>" + xmlAppts + xmlGoals + xmlDB + xmlIcons + xmlShortcuts + "</DATA>"
Else
    Response.Write "<ERROR number=""" + CStr(Err.number) + """>" + CleanXML(Err.Description) + "</ERROR>"
End If

Response.End

%>
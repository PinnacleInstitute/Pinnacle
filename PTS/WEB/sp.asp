<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionAdd = 1
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oSeminar, xmlSeminar
Dim oMeetings, xmlMeetings
Dim oHTMLFile, xmlHTMLFile
Dim oSeminarLog, xmlSeminarLog
'-----declare page parameters
Dim reqs
Dim reql
Dim reqr
Dim reqPreview
On Error Resume Next

'-----Call Common System Function
CommonSystem()

Sub DoError(ByVal bvNumber, ByVal bvSource, ByVal bvErrorMsg)
   bvErrorMsg = Replace(bvErrorMsg, Chr(39), Chr(34))
   Set oUtil = server.CreateObject("wtSystem.CUtility")
   With oUtil
      tmpMsgFld = .ErrMsgFld( bvErrorMsg )
      tmpMsgVal = .ErrMsgVal( bvErrorMsg )
   End With
   Set oUtil = Nothing
   xmlError = "<ERROR number=" + Chr(34) & bvNumber & Chr(34) + " src=" + Chr(34) + bvSource + Chr(34) + " msgfld=" + Chr(34) + tmpMsgFld + Chr(34) + " msgval=" + Chr(34) + tmpMsgVal + Chr(34) + ">" + CleanXML(bvErrorMsg) + "</ERROR>"
   Err.Clear
End Sub

'-----initialize the error data
xmlError = ""

reqSysTestFile = GetInput("SysTestFile", reqPageData)
If Len(reqSysTestFile) > 0 Then
   SetCache "SYSTESTFILE", reqSysTestFile
Else
   reqSysTestFile = GetCache("SYSTESTFILE")
End If

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
reqSysDate = CStr(Date())
reqSysTime = CStr(Time())
reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
reqSysServerName = Request.ServerVariables("SERVER_NAME")
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(LCASE(reqSysServerPath), "sp")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqs =  Numeric(GetInput("s", reqPageData))
reql =  GetInput("l", reqPageData)
reqr =  GetInput("r", reqPageData)
reqPreview =  Numeric(GetInput("Preview", reqPageData))
'-----get language settings
reqLangDefault = "en"
reqSysLanguage = GetInput("SysLanguage", reqPageData)
If Len(reqSysLanguage) = 0 Then
   reqSysLanguage = GetCache("LANGUAGE")
   If Len(reqSysLanguage) = 0 Then
      GetLanguage reqLangDialect, reqLangCountry, reqLangDefault
      If len(reqLangDialect) > 0 Then
         reqSysLanguage = reqLangDialect
      ElseIf len(reqLangCountry) > 0 Then
         reqSysLanguage = reqLangCountry
      Else
         reqSysLanguage = reqLangDefault
      End If
      SetCache "LANGUAGE", reqSysLanguage
   End If
Else
   SetCache "LANGUAGE", reqSysLanguage
End If

Sub LoadPage()
   On Error Resume Next

   Set oSeminar = server.CreateObject("ptsSeminarUser.CSeminar")
   If oSeminar Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSeminarUser.CSeminar"
   Else
      With oSeminar
         .SysCurrentLanguage = reqSysLanguage
         .Load reqs, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         SeminarName = .SeminarName
         SeminarDesc = .Description
         If (.Status <> 2) And (reqPreview = 0) Then
            Response.write "Seminar Not Available"
            Response.end
         End If
      End With
   End If
   Set oSeminar = Nothing

   Set oMeetings = server.CreateObject("ptsMeetingUser.CMeetings")
   If oMeetings Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMeetingUser.CMeetings"
   Else
      With oMeetings
         .SysCurrentLanguage = reqSysLanguage
         .ListSeminar reqs, 0
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            tmpMeetings = ""
            cnt = 0
            For Each oItem in oMeetings
              With oItem
                If .VenueName <> "~" Then
                  VenueName = "<b>" + .VenueName + "</b>"
                  Description = .Description
                Else
                  If cnt = 0 Then Check = " checked" Else Check = ""
                  cnt = cnt + 1
                  If .Status = 2 Then
                    Input = "<input type=""radio"" name=""Meeting"" value=""" + .MeetingID + """" + Check +"/>"
                  Else
                      Input = "&nbsp;&nbsp;&nbsp;"
                  End If
                  If .Status = 3 Then Full = " (FULL)" Else Full = ""
                  MeetingTime = .StartTime
                  If .EndTime <> "" Then MeetingTime = MeetingTime + " - " + .EndTime
                  DayStr = ""
                  Select Case Weekday(.MeetingDate)
                  Case 1 DayStr = "Sunday"
                  Case 2 DayStr = "Monday"
                  Case 3 DayStr = "Tuesday"
                  Case 4 DayStr = "Wednesday"
                  Case 5 DayStr = "Thursday"
                  Case 6 DayStr = "Friday"
                  Case 7 DayStr = "Saturday"
                  End Select
            Label = "<span id=""venue""> " + VenueName + Full + "<BR>&nbsp;&nbsp;&nbsp;" + DayStr + " " + .MeetingDate + " " + MeetingTime + "<BR>&nbsp;&nbsp;&nbsp;" + Description
                  tmpMeetings = tmpMeetings + Input + Label + "<br></span>"
                End If
              End With
            Next
           
      End With
   End If
   Set oMeetings = Nothing

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Seminar" & reqS & ".htm"
         .Path = reqSysWebDirectory + "Seminar\"
         .Language = tmpLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlHTMLFile = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing
   
          If reqActionCode = 1 And xmlError = "" Then tmpDisplay = "block" Else tmpDisplay = "none"
          If reqActionCode = 1 Then xmlHTMLFile = Replace( xmlHTMLFile, "autoplay=1", "autoplay=0" )
          xmlHTMLFile = Replace( xmlHTMLFile, "{display}", tmpDisplay )
          xmlHTMLFile = Replace( xmlHTMLFile, "{seminarname}", SeminarName )
          xmlHTMLFile = Replace( xmlHTMLFile, "{description}", SeminarDesc )
          xmlHTMLFile = Replace( xmlHTMLFile, "{meetings}", CleanXMLComment(tmpMeetings) )
        
End Sub

Function EmailConfirmation(pEmail, pMeetingID)
   On Error Resume Next
   If (InStr(pEmail, "@") <> 0) Then

      Set oSeminar = server.CreateObject("ptsSeminarUser.CSeminar")
      If oSeminar Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSeminarUser.CSeminar"
      Else
         With oSeminar
            .SysCurrentLanguage = reqSysLanguage
            .Load reqs, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            SeminarName = .SeminarName
         End With
      End If
      Set oSeminar = Nothing

      Set oMeeting = server.CreateObject("ptsMeetingUser.CMeeting")
      If oMeeting Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMeetingUser.CMeeting"
      Else
         With oMeeting
            .SysCurrentLanguage = reqSysLanguage
            .Load pMeetingID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            VenueID = .VenueID
            MeetingDate = .MeetingDate
            StartTime = .StartTime
            EndTime = .EndTime
         End With
      End If
      Set oMeeting = Nothing

      Set oVenue = server.CreateObject("ptsVenueUser.CVenue")
      If oVenue Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsVenueUser.CVenue"
      Else
         With oVenue
            .SysCurrentLanguage = reqSysLanguage
            .Load VenueID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            VenueName = .VenueName
            Street1 = .Street1
            Street2 = .Street2
            City = .City
            State = .State
            Zip = .Zip
            
              DayStr = ""
              Select Case Weekday(MeetingDate)
              Case 1 DayStr = "Sunday"
              Case 2 DayStr = "Monday"
              Case 3 DayStr = "Tuesday"
              Case 4 DayStr = "Wednesday"
              Case 5 DayStr = "Thursday"
              Case 6 DayStr = "Friday"
              Case 7 DayStr = "Saturday"
              End Select
            
         End With
      End If
      Set oVenue = Nothing
      CompanyID = 21
      CompanyEmail = "support@NexxusUniversity.com"
      
            tmpSubject = "SUCCESSFUL REGISTRATION - " + SeminarName
            MeetingDate = MeetingDate + "  " + StartTime
            If EndTime <> "" Then MeetingDate = MeetingDate + " - " + EndTime
            tmpBody = "We look forward to your attendance at:<br><b>" + VenueName + "</b><br>" + DayStr + " " + MeetingDate + "<br>" + Street1 + " " + Street2 + ", " + City + " " + State + " " + Zip
            SendEmail CompanyID, CompanyEmail, CompanyEmail, pEmail, "", "", tmpSubject, tmpBody
          
   End If
End Function

Sub AddLog()
   On Error Resume Next

   Set oSeminarLog = server.CreateObject("ptsSeminarLogUser.CSeminarLog")
   If oSeminarLog Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSeminarLogUser.CSeminarLog"
   Else
      With oSeminarLog
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .SeminarID = reqs
         .LogDate = Now
         SeminarLogID = CLng(.Add(1))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSeminarLog = Nothing
End Sub

tmpLanguage = reql
If (tmpLanguage = "") Then
   tmpLanguage = reqSysLanguage
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadPage
      If (reqPreview = 0) Then
         AddLog
      End If

   Case CLng(cActionAdd):
      If (reqPreview = 0) Then
         tmpEmail = Request.Form.Item("Email")
         tmpMeetingID = Request.Form.Item("Meeting")

         Set oAttendee = server.CreateObject("ptsAttendeeUser.CAttendee")
         If oAttendee Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAttendeeUser.CAttendee"
         Else
            With oAttendee
               .SysCurrentLanguage = reqSysLanguage
               .Load 0, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .SeminarID = reqs
               .MeetingID = tmpMeetingID
               .Status = 1
               .RegisterDate = Now
               .IP = Request.ServerVariables("REMOTE_ADDR")
               .Refer = Left(reqr,20)
               .NameLast = Request.Form.Item("NameLast")
               .NameFirst = Request.Form.Item("NameFirst")
               .Email = tmpEmail
               .Phone = Request.Form.Item("Phone")
               .City = Request.Form.Item("City")
               .Guests = Request.Form.Item("Guests")
               AttendeeID = CLng(.Add(1))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oAttendee = Nothing

         If (xmlError = "") Then
            Set oMeeting = server.CreateObject("ptsMeetingUser.CMeeting")
            If oMeeting Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMeetingUser.CMeeting"
            Else
               With oMeeting
                  .SysCurrentLanguage = reqSysLanguage
                  Result = .CountGuests(tmpMeetingID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oMeeting = Nothing
         End If
         If (xmlError = "") Then
            EmailConfirmation tmpEmail, tmpMeetingID
         End If
         LoadPage
      End If
End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " s=" + Chr(34) + CStr(reqs) + Chr(34)
xmlParam = xmlParam + " l=" + Chr(34) + CleanXML(reql) + Chr(34)
xmlParam = xmlParam + " r=" + Chr(34) + CleanXML(reqr) + Chr(34)
xmlParam = xmlParam + " preview=" + Chr(34) + CStr(reqPreview) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlSeminar
xmlTransaction = xmlTransaction +  xmlMeetings
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlSeminarLog
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
fileLanguage = "Language" + "\sp[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\sp[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "sp Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild

xmlLanguage = oLanguage.XML
Set oLanguage = Nothing

'-----If there is an Error, get the Error Labels XML
If xmlError <> "" Then
fileLanguage = "Language\Error[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Error[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "sp Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the data XML
xmlData = "<DATA>"
xmlData = xmlData +  xmlTransaction
xmlData = xmlData +  xmlHead
xmlData = xmlData +  xmlParam
xmlData = xmlData +  xmlLanguage
xmlData = xmlData +  xmlError
xmlData = xmlData +  xmlErrorLabels
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "sp.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "sp Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "sp Load file (oData) failed with error code " + CStr(oData.parseError)
   Response.Write "<BR/>" + xmlData
   Response.End
End If

If Len(reqSysTestFile) > 0 Then
   oData.save reqSysTestFile
End If

'-----transform the XML with the XSL
Response.Write oData.transformNode(oStyle)

Set oData = Nothing
Set oStyle = Nothing
Set oLanguage = Nothing
%>
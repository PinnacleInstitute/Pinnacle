<!--#include file="Include\System.asp"-->
<!--#include file="Include\CompanyHeader.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionPrevYear = 1
Const cActionPrevMonth = 2
Const cActionNextMonth = 3
Const cActionNextYear = 4
Const cActionCalendar = 5
'-----page variables
Dim oData
Dim oStyle
'-----system variables
Dim reqActionCode
Dim reqSysTestFile, reqSysLanguage
Dim reqSysHeaderImage, reqSysFooterImage, reqSysReturnImage, reqSysNavBarImage, reqSysHeaderURL, reqSysReturnURL
Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType
Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGA_ACCTID, reqSysGA_DOMAIN
Dim reqLangDialect, reqLangCountry, reqLangDefault
Dim xmlSystem, xmlConfig, xmlParam, xmlError, xmlErrorLabels, reqConfirm
Dim xmlTransaction, xmlData
'-----language variables
Dim oLanguage, xmlLanguage
Dim xslPage
Dim fileLanguage
'-----object variables
Dim oCalendars, xmlCalendars
Dim oCompany, xmlCompany
Dim oMember, xmlMember
Dim oCalendar, xmlCalendar
Dim oAppts, xmlAppts
'-----other transaction data variables
Dim xmlCell
'-----declare page parameters
Dim reqC
Dim reqM
Dim reqNewC
Dim reqMemberID
Dim reqCompanyID
Dim reqFromDate
Dim reqToDate
Dim reqTitle
Dim reqEdit
Dim reqOptions
Dim reqURL
Dim reqPopup
Dim reqContentPage
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

'-----save the return URL and form data if supplied
If (Len(Request.Item("ReturnURL")) > 0) Then
   reqReturnURL = Replace(Request.Item("ReturnURL"), "&", "%26")
   reqReturnData = Replace(Request.Item("ReturnData"), "&", "%26")
   SetCache "CalendarURL", reqReturnURL
   SetCache "CalendarDATA", reqReturnData
End If

'-----restore my form if it was cached
reqPageData = GetCache("RETURNDATA")
SetCache "RETURNDATA", ""

reqSysTestFile = GetInput("SysTestFile", reqPageData)
If Len(reqSysTestFile) > 0 Then
   SetCache "SYSTESTFILE", reqSysTestFile
Else
   reqSysTestFile = GetCache("SYSTESTFILE")
End If

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
reqSysHeaderImage = GetCache("HEADERIMAGE")
reqSysFooterImage = GetCache("FOOTERIMAGE")
reqSysReturnImage = GetCache("RETURNIMAGE")
reqSysNavBarImage = GetCache("NAVBARIMAGE")
reqSysHeaderURL = GetCache("HEADERURL")
reqSysReturnURL = GetCache("RETURNURL")
reqConfirm = GetCache("CONFIRM")
SetCache "CONFIRM", ""
reqSysEmployeeID = Numeric(GetCache("EMPLOYEEID"))
reqSysCustomerID = Numeric(GetCache("CUSTOMERID"))
reqSysAffiliateID = Numeric(GetCache("AFFILIATEID"))
reqSysAffiliateType = Numeric(GetCache("AFFILIATETYPE"))
reqSysDate = CStr(Date())
reqSysTime = CStr(Time())
reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
reqSysServerName = Request.ServerVariables("SERVER_NAME")
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(LCASE(reqSysServerPath), "calendar")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

reqSysCompanyID = Numeric(GetCache("COMPANYID"))
reqSysTrainerID = Numeric(GetCache("TRAINERID"))
reqSysMemberID = Numeric(GetCache("MEMBERID"))
reqSysOrgID = Numeric(GetCache("ORGID"))
reqSysUserMode = Numeric(GetCache("USERMODE"))
reqSysUserOptions = GetCache("USEROPTIONS")
reqSysGA_ACCTID = GetCache("GA_ACCTID")
reqSysGA_DOMAIN = GetCache("GA_DOMAIN")

'-----fetch page parameters
reqC =  Numeric(GetInput("C", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqNewC =  Numeric(GetInput("NewC", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
reqTitle =  GetInput("Title", reqPageData)
reqEdit =  Numeric(GetInput("Edit", reqPageData))
reqOptions =  GetInput("Options", reqPageData)
reqURL =  GetInput("URL", reqPageData)
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
If (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0
reqSysUserStatus = GetCache("USERSTATUS")
reqSysUserName = GetCache("USERNAME")

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

Sub GetCalendars()
   On Error Resume Next

   Set oCalendars = server.CreateObject("ptsCalendarUser.CCalendars")
   If oCalendars Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCalendarUser.CCalendars"
   Else
      With oCalendars
         .SysCurrentLanguage = reqSysLanguage
         If (reqSysUserGroup = 41) And (reqCompanyID <> 0) Then
            .ListCompanyPublic CLng(reqCompanyID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqSysUserGroup <> 41) And (reqCompanyID <> 0) Then
            .ListCompany CLng(reqCompanyID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         
         tmpCnt = 0
         xmlCalendars = "<PTSCALENDARS>"
         If reqCompanyID <> 0 Then
            For Each oCalendar in oCalendars
               With oCalendar
                  tmpCnt = tmpCnt + 1
                  If tmpCnt = 1 AND reqC = 0 Then reqC = .CalendarID
                  xmlCalendars = xmlCalendars + "<ENUM id=""" + .CalendarID + """ name=""" + "**" + CleanXML(.CalendarName) + ""
                  If reqC = CLng(.CalendarID) Then xmlCalendars = xmlCalendars + """ selected=""1"
                  xmlCalendars = xmlCalendars + """/>"
               End With
            Next      
         End If

         If (reqMemberID <> 0) Then
            .ListMember CLng(reqMemberID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         
         If reqMemberID <> 0 Then
            For Each oCalendar in oCalendars
               With oCalendar
                  tmpCnt = tmpCnt + 1
                  If tmpCnt = 1 AND reqC = 0 Then reqC = .CalendarID
                  xmlCalendars = xmlCalendars + "<ENUM id=""" + .CalendarID + """ name=""" + CleanXML(.CalendarName) + ""
                  If reqC = CLng(.CalendarID) Then xmlCalendars = xmlCalendars + """ selected=""1"
                  xmlCalendars = xmlCalendars + """/>"
               End With
            Next      
         End If
         xmlCalendars = xmlCalendars + "</PTSCALENDARS>"

         If (tmpCnt = 0) Then
            NewCalendar
         End If
      End With
   End If
   Set oCalendars = Nothing
End Sub

Sub NewCalendar()
   On Error Resume Next

   If (reqMemberID = 0) Then
      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqCompanyID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCompanyID = .CompanyID
            tmpCalendarName = .CompanyName + " Calendar"
         End With
      End If
      Set oCompany = Nothing
   End If

   If (reqMemberID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCompanyID = .CompanyID
            tmpTimezone = .Timezone
            If (.IsCompany <> 0) Then
               tmpCalendarName = .CompanyName + " Calendar"
            End If
            If (.IsCompany = 0) Then
               tmpCalendarName = .NameFirst + " " + .NameLast + " Calendar"
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   Set oCalendar = server.CreateObject("ptsCalendarUser.CCalendar")
   If oCalendar Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCalendarUser.CCalendar"
   Else
      With oCalendar
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CompanyID = tmpCompanyID
         .MemberID = reqMemberID
         .Layout = 3
         .CalendarName = tmpCalendarName
         .Timezone = tmpTimezone
         .IsAppt = 1
         If (reqSysUserGroup = 41) Then
            If (InStr(reqSysUserOptions,"K") <> 0) Then
               .IsClass = 1
            End If
            If (InStr(reqSysUserOptions,"L") <> 0) Then
               .IsAssess = 1
            End If
            If (InStr(reqSysUserOptions,"H") <> 0) Then
               .IsGoal = 1
            End If
            If (InStr(reqSysUserOptions,"E") <> 0) Then
               .IsSales = 1
            End If
            If (InStr(reqSysUserOptions,"E") <> 0) Then
               .IsActivities = 1
            End If
            If (InStr(reqSysUserOptions,"E") <> 0) Then
               .IsEvents = 1
            End If
            If (InStr(reqSysUserOptions,"6") <> 0) Then
               .IsService = 1
            End If
            If (InStr(reqSysUserOptions,"h") <> 0) Then
               .IsLead = 1
            End If
         End If
         reqC = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCalendar = Nothing
End Sub

Sub LoadCalendar()
   On Error Resume Next

   Set oCalendar = server.CreateObject("ptsCalendarUser.CCalendar")
   If oCalendar Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCalendarUser.CCalendar"
   Else
      With oCalendar
         .SysCurrentLanguage = reqSysLanguage
         .Load reqC, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         If (reqSysCompanyID = 0) Then
            reqSysCompanyID = reqCompanyID
            SetCompanyHeader reqCompanyID, reqSysLanguage
         End If
         If (reqMemberID = 0) Then
            reqMemberID = .MemberID
         End If
         If (reqM <> 0) And (0 <> CLng(.MemberID)) Then
            reqEdit = 1
         End If
         If (reqSysUserGroup = 41) And (reqSysMemberID = CLng(.MemberID)) Then
            reqEdit = 1
         End If
         If (reqSysUserGroup <= 23) Then
            reqEdit = 1
         End If
         If (reqSysUserGroup = 51) Then
            reqEdit = 1
         End If
         If (reqEdit = 0) And (.IsPrivate <> 0) Then
            reqEdit = -1
         End If
         tmpLayout = .Layout
         xmlCalendar = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
         If reqMemberID = 0 Then
            reqOptions = "1"
         Else
            reqOptions = ""
            If .IsAppt = 1 Then reqOptions = reqOptions + "1"
            If .IsClass = 1 Then reqOptions = reqOptions + "C"
            If .IsAssess = 1 Then reqOptions = reqOptions + "A"
            If .IsGoal = 1 Then reqOptions = reqOptions + "G"
            If .IsProject = 1 Then reqOptions = reqOptions + "P"
            If .IsTask = 1 Then reqOptions = reqOptions + "T"
            If .IsLead = 1 Then reqOptions = reqOptions + "L"
            If .IsSales = 1 Then reqOptions = reqOptions + "S"
            If .IsActivities = 1 Then reqOptions = reqOptions + "N"
            If .IsEvents = 1 Then reqOptions = reqOptions + "E"
            If .IsService = 1 Then reqOptions = reqOptions + "V"
            If reqOptions = "" Then reqOptions = "1"
         End If

      End With
   End If
   Set oCalendar = Nothing
   If (reqEdit = 1) Then
      GetCalendars
   End If
   
   If reqFromDate = "" Then
      reqFromDate = Date()
      Select Case tmpLayout
         Case 1  'Day - today
         Case 2  'Week
            reqFromDate = DateAdd( "d", (WeekDay(reqFromDate, 2)-1) * -1, reqFromDate) 
         Case 3  'Month
            reqFromDate = DateSerial(Year(reqFromDate), Month(reqFromDate), 1)
         Case 4  'List - today
      End Select
   End If      
   If reqToDate = "" Then
      reqToDate = Date()
      Select Case tmpLayout
         Case 1  'Day - today
         Case 2  'Week
            reqToDate = DateAdd( "d", 7, reqFromDate) 
         Case 3  'Month
            reqToDate = DateAdd("d", -1, DateAdd( "m", 1, reqFromDate))
         Case 4  'List - today
      End Select
   End If      


   If (reqEdit <> -1) Then
      Set oAppts = server.CreateObject("ptsApptUser.CAppts")
      If oAppts Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsApptUser.CAppts"
      Else
         With oAppts
            .SysCurrentLanguage = reqSysLanguage
            If (reqEdit = 0) Then
               .ListCalendar reqC, reqFromDate, reqToDate
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqEdit = 1) Then
               If (reqOptions = "1") Then
                  .ListCalendarAll reqC, reqFromDate, reqToDate
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqOptions <> "1") Then
                  .ListCalendarOptions reqC, reqFromDate, reqToDate, reqOptions
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            
         'calculate and store day and time
         For Each oAppt in oAppts
            With oAppt
               .Opt = 0
               'Create a list of days this appt spans this month
               'If this is a weekly recurring appt. get all days
               If .Recur = 1 Then
                  tmpDay1 = Day(reqFromDate)
                  tmpDay2 = Day(reqToDate)
                  If CDate(.StartDate) > CDate(reqFromDate) Then tmpDay1 = Day(.StartDate)
                  If IsDate(.RecurDate) Then
                     If CDate(.RecurDate) < CDate(reqToDate) Then tmpDay2 = Day(.RecurDate)
                  End If
                  tmpStr = "~"
                  FromDay = WeekDay(reqFromDate)
                  StartDay = WeekDay(.StartDate)
                  If StartDay = FromDay Then x = 1
                  If StartDay > FromDay Then x = (StartDay - FromDay) + 1
                  If StartDay < FromDay Then x = (StartDay + 8) - FromDay
                  While x <= 31 
                     If x >= tmpDay1 And x <= tmpDay2 Then
                        tmpStr = tmpStr + CStr(x) + "~"
                     End If   
                     x = x + 7
                  Wend
                  .Email = tmpStr
               Else
                  If .StartDate = .EndDate Then
                     .Email = "~" + CStr(Day(.StartDate)) + "~"
                  Else
                     tmpStartDate = .StartDate
                     tmpEndDate = .EndDate
                     tmpMonth = Month(reqFromDate)
                     tmpStr = "~"
                     days = DATEDIFF("d", tmpStartDate, tmpEndDate)
                     For x = 0 to days 
                        dte = DATEADD("d", x, tmpStartDate)
                        If Month(dte) = tmpMonth Then
                           tmpStr = tmpStr + CStr(Day(dte)) + "~"
                        End If   
                     Next
                     .Email = tmpStr
                     .Opt = 1
                  End If
                  If .IsEdit <> "0" Then .Opt = 2   
               End If   
               If reqEdit = 0 AND .Show = 3 Then .ApptName = "Busy"
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
                     If CDate(.StartDate) < Date() Then .CalendarID = 1 Else .CalendarID = 0
                  Case "-81" 
                     .ApptID = CLng(.ApptID) mod 810000000 'Sales 
                     If CDate(.StartDate) < Date() Then .CalendarID = 1 Else .CalendarID = 0
                  Case "-90" 
                     .ApptID = CLng(.ApptID) mod 900000000 'Notes
                  Case "-96" 
                     .ApptID = CLng(.ApptID) mod 960000000 'Events
                  Case "-13" 
                     .ApptID = CLng(.ApptID) mod 130000000 'Classes
                  Case "-31" 
                     .ApptID = CLng(.ApptID) mod 310000000 'Assessments
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

            xmlAppts = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAppts = Nothing
   End If
   
If reqEdit <> - 1 Then
   If tmpLayout = 1 Then  'Day
      xmlCell = "<PTSCELLS>"
      x = tmpDailyStart
      while x < tmpDailyEnd
         xmlCell = xmlCell + "<PTSCELL " + "time=" + chr(34) & (x*100) & chr(34) + "/>"
         xmlCell = xmlCell + "<PTSCELL " + "time=" + chr(34) & (x*100)+30 & chr(34) + "/>"
         x = x + 1
      wend
      xmlCell = xmlCell + "</PTSCELLS>"
   End If
   If tmpLayout = 2 Then  'Week
      xmlCell = "<PTSCELLS>"
      x = 0
      while x < 7
         xmlCell = xmlCell + "<PTSCELL " + "day=" + chr(34) & (x+1) & chr(34) + "/>"
         x = x + 1
      wend
      xmlCell = xmlCell + "</PTSCELLS>"
   End If
   If tmpLayout = 3 Then  'Month
      Dim Dte, FirstDayNo, WeekNo, DayNo
       reqTitle = MonthName(Month(reqFromDate)) + " " & Year(reqFromDate)
      xmlCell = "<PTSCELLS>"
      Y = Year(reqFromDate)
      M = Month(reqFromDate)
      DayNo = Weekday(DateSerial(Y, M, 1),2)
      If DayNo > 1 Then
         For D = 1 To DayNo - 1
            xmlCell = xmlCell + "<PTSCELL " + "day=""""/>"
         Next
      End If
      Today = Date()
      For D = 1 To 31
         Dte = DateSerial(Y, M, D)
         If D = 1 Then FirstDayNo = Weekday(Dte,2)
         If M = Month(Dte) And D = Day(Dte) Then
            xmlCell = xmlCell + "<PTSCELL " + "day=""" & D & """"
            If Dte = Today Then xmlCell = xmlCell + " today=""" & 1 & """"
            xmlCell = xmlCell + "/>"
            DayNo = Weekday(Dte,2)
         End If
      Next
      If DayNo <> 7 Then
         For D = DayNo + 1 To 7
            xmlCell = xmlCell + "<PTSCELL " + "day=""""/>"
         Next
      End If
      xmlCell = xmlCell + "</PTSCELLS>"
   End If
   reqNewC = reqC
End If

End Sub


   reqURL = "http://" + reqSysServerName + reqSysServerPath + "calendar.asp?c=" & reqC

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqC = 0) Then
         GetCalendars

         If (reqC <> 0) Then
            Response.Redirect "Calendar.asp" & "?C=" & reqC & "&M=" & reqM & "&MemberID=" & reqMemberID
         End If
      End If
      If (reqC <> 0) Then
         LoadCalendar
      End If

   Case CLng(cActionPrevYear):
      reqFromDate = DateAdd("yyyy", -1, reqFromDate)
      reqToDate = ""
      LoadCalendar

   Case CLng(cActionPrevMonth):
      reqFromDate = DateAdd("m", -1, reqFromDate)
      reqToDate = ""
      LoadCalendar

   Case CLng(cActionNextMonth):
      reqFromDate = DateAdd("m", 1, reqFromDate)
      reqToDate = ""
      LoadCalendar

   Case CLng(cActionNextYear):
      reqFromDate = DateAdd("yyyy", 1, reqFromDate)
      reqToDate = ""
      LoadCalendar

   Case CLng(cActionCalendar):
      reqNewC = Request.Form.Item("NewC")

      If (xmlError = "") Then
         Response.Redirect "Calendar.asp" & "?C=" & reqNewC & "&M=" & reqM & "&MemberID=" & reqMemberID
      End If
End Select

'-----get system data
xmlSystem = "<SYSTEM"
xmlSystem = xmlSystem + " headerimage=" + Chr(34) + reqSysHeaderImage + Chr(34)
xmlSystem = xmlSystem + " footerimage=" + Chr(34) + reqSysFooterImage + Chr(34)
xmlSystem = xmlSystem + " returnimage=" + Chr(34) + reqSysReturnImage + Chr(34)
xmlSystem = xmlSystem + " navbarimage=" + Chr(34) + reqSysNavBarImage + Chr(34)
xmlSystem = xmlSystem + " headerurl=" + Chr(34) + reqSysHeaderURL + Chr(34)
xmlSystem = xmlSystem + " returnurl=" + Chr(34) + CleanXML(reqSysReturnURL) + Chr(34)
xmlSystem = xmlSystem + " language=" + Chr(34) + reqSysLanguage + Chr(34)
xmlSystem = xmlSystem + " langdialect=" + Chr(34) + reqLangDialect + Chr(34)
xmlSystem = xmlSystem + " langcountry=" + Chr(34) + reqLangCountry + Chr(34)
xmlSystem = xmlSystem + " langdefault=" + Chr(34) + reqLangDefault + Chr(34)
xmlSystem = xmlSystem + " userid=" + Chr(34) + CStr(reqSysUserID) + Chr(34)
xmlSystem = xmlSystem + " usergroup=" + Chr(34) + CStr(reqSysUserGroup) + Chr(34)
xmlSystem = xmlSystem + " userstatus=" + Chr(34) + CStr(reqSysUserStatus) + Chr(34)
xmlSystem = xmlSystem + " username=" + Chr(34) + CleanXML(reqSysUserName) + Chr(34)
xmlSystem = xmlSystem + " customerid=" + Chr(34) + CStr(reqSysCustomerID) + Chr(34)
xmlSystem = xmlSystem + " employeeid=" + Chr(34) + CStr(reqSysEmployeeID) + Chr(34)
xmlSystem = xmlSystem + " affiliateid=" + Chr(34) + CStr(reqSysAffiliateID) + Chr(34)
xmlSystem = xmlSystem + " affiliatetype=" + Chr(34) + CStr(reqSysAffiliateType) + Chr(34)
xmlSystem = xmlSystem + " actioncode=" + Chr(34) + CStr(reqActionCode) + Chr(34)
xmlSystem = xmlSystem + " confirm=" + Chr(34) + CStr(reqConfirm) + Chr(34)
xmlSystem = xmlSystem + " pageData=" + Chr(34) + CleanXML(reqPageData) + Chr(34)
xmlSystem = xmlSystem + " pageURL=" + Chr(34) + CleanXML(reqPageURL) + Chr(34)
xmlSystem = xmlSystem + " currdate=" + Chr(34) + reqSysDate + Chr(34)
xmlSystem = xmlSystem + " currtime=" + Chr(34) + reqSysTime + Chr(34)
xmlSystem = xmlSystem + " currtimeno=" + Chr(34) + reqSysTimeno + Chr(34)
xmlSystem = xmlSystem + " servername=" + Chr(34) + reqSysServerName + Chr(34)
xmlSystem = xmlSystem + " serverpath=" + Chr(34) + reqSysServerPath + Chr(34)
xmlSystem = xmlSystem + " webdirectory=" + Chr(34) + reqSysWebDirectory + Chr(34)
xmlSystem = xmlSystem + " companyid=" + Chr(34) + CStr(reqSysCompanyID) + Chr(34)
xmlSystem = xmlSystem + " trainerid=" + Chr(34) + CStr(reqSysTrainerID) + Chr(34)
xmlSystem = xmlSystem + " memberid=" + Chr(34) + CStr(reqSysMemberID) + Chr(34)
xmlSystem = xmlSystem + " orgid=" + Chr(34) + CStr(reqSysOrgID) + Chr(34)
xmlSystem = xmlSystem + " usermode=" + Chr(34) + CStr(reqSysUserMode) + Chr(34)
xmlSystem = xmlSystem + " useroptions=" + Chr(34) + reqSysUserOptions + Chr(34)
xmlSystem = xmlSystem + " ga_acctid=" + Chr(34) + reqSysGA_ACCTID + Chr(34)
xmlSystem = xmlSystem + " ga_domain=" + Chr(34) + reqSysGA_DOMAIN + Chr(34)
xmlSystem = xmlSystem + " />"
xmlOwner = "<OWNER"
xmlOwner = xmlOwner + " id=" + Chr(34) + CStr(reqOwnerID) + Chr(34)
xmlOwner = xmlOwner + " title=" + Chr(34) + CleanXML(reqOwnerTitle) + Chr(34)
xmlOwner = xmlOwner + " entity=" + Chr(34) + CStr(reqOwner) + Chr(34)
xmlOwner = xmlOwner + " />"
xmlConfig = "<CONFIG"
xmlConfig = xmlConfig + " isdocuments=" + Chr(34) + GetCache("ISDOCUMENTS") + Chr(34)
xmlConfig = xmlConfig + " documentpath=" + Chr(34) + GetCache("DOCUMENTPATH") + Chr(34)
xmlConfig = xmlConfig + " />"
xmlParam = "<PARAM"
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " newc=" + Chr(34) + CStr(reqNewC) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " edit=" + Chr(34) + CStr(reqEdit) + Chr(34)
xmlParam = xmlParam + " options=" + Chr(34) + CleanXML(reqOptions) + Chr(34)
xmlParam = xmlParam + " url=" + Chr(34) + CleanXML(reqURL) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCalendars
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCalendar
xmlTransaction = xmlTransaction +  xmlAppts
xmlTransaction = xmlTransaction +  xmlCell
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Calendar[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Calendar[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "Calendar Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild

'-----append common labels
fileLanguage = "Language\Common[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Common[en].xml"
End If
Set oCommon = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oCommon.load server.MapPath(fileLanguage)
If oCommon.parseError <> 0 Then
   Response.Write "Calendar Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
   Response.End
End If
Set oLabels = oCommon.selectNodes("LANGUAGE/LABEL")
For Each oLabel In oLabels
Set oAdd = oLanguage.selectSingleNode("LANGUAGE").appendChild(oLabel.cloneNode(True))
Set oAdd = Nothing
Next
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
   Response.Write "Calendar Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the data XML
xmlData = "<DATA>"
xmlData = xmlData +  xmlTransaction
xmlData = xmlData +  xmlSystem
xmlData = xmlData +  xmlParam
xmlData = xmlData +  xmlOwner
xmlData = xmlData +  xmlConfig
xmlData = xmlData +  xmlParent
xmlData = xmlData +  xmlBookmark
xmlData = xmlData +  xmlLanguage
xmlData = xmlData +  xmlError
xmlData = xmlData +  xmlErrorLabels
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "Calendar.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "Calendar Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "Calendar Load file (oData) failed with error code " + CStr(oData.parseError)
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
<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionReturnClasses = 2
Const cActionCancel = 3
Const cActionCertificate = 4
Const cActionEvaluation = 5
Const cActionRemove = 6
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
Dim oMember, xmlMember
Dim oSession, xmlSession
Dim oCourse, xmlCourse
Dim oSessionLessons, xmlSessionLessons
'-----declare page parameters
Dim reqSessionID
Dim reqCourseID
Dim reqMemberID
Dim reqRegister
Dim reqPopup
Dim reqLessons
Dim reqLesson
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
   SetCache "m_1330URL", reqReturnURL
   SetCache "m_1330DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_1330")
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
reqSessionID =  Numeric(GetInput("SessionID", reqPageData))
reqCourseID =  Numeric(GetInput("CourseID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqRegister =  Numeric(GetInput("Register", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqLessons =  GetInput("Lessons", reqPageData)
reqLesson =  Numeric(GetInput("Lesson", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
m_CheckSecurity reqSysUserID, reqSysUserGroup, 1, 98, "MobileHome.asp"
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

Sub Register()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpMemberNameFirst = .NameFirst
         tmpMemberNameLast = .NameLast
         tmpStatus = .Status
      End With
   End If
   Set oMember = Nothing

   Set oSession = server.CreateObject("ptsSessionUser.CSession")
   If oSession Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
   Else
      With oSession
         .SysCurrentLanguage = reqSysLanguage
         reqSessionID = CLng(.CheckCourse(CLng(reqCourseID), CLng(reqMemberID), CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSession = Nothing

   If (reqSessionID = 0) Then
      Set oSession = server.CreateObject("ptsSessionUser.CSession")
      If oSession Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
      Else
         With oSession
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .CourseID = reqCourseID
            .MemberID = reqMemberID
            .Status = 1
            .CommStatus = 1
            .RegisterDate = reqSysDate
            .NameLast = tmpMemberNameLast
            .NameFirst = tmpMemberNameFirst
            reqSessionID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSession = Nothing
   End If
End Sub

If (reqSysUserGroup = 41) And (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

         Response.Redirect "m_0101.asp" & "?ActionCode=" & 9
      End If
      If (reqRegister <> 0) And (reqSessionID = 0) And (reqMemberID <> 0) And (reqCourseID <> 0) Then
         Register
      End If

      If (reqSessionID > 0) Then
         Set oSession = server.CreateObject("ptsSessionUser.CSession")
         If oSession Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
         Else
            With oSession
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqSessionID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqCourseID = .CourseID
               reqMemberID = .MemberID
               tmpStatus = .Status
               tmpRating1 = .Rating1
               xmlSession = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oSession = Nothing
      End If

      Set oCourse = server.CreateObject("ptsCourseUser.CCourse")
      If oCourse Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCourseUser.CCourse"
      Else
         With oCourse
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqCourseID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpNoEvaluation = .NoEvaluation
            xmlCourse = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCourse = Nothing
      If (tmpNoEvaluation = 0) And (tmpStatus > 2) And (tmpRating1 = 0) Then

         Response.Redirect "m_1304.asp" & "?SessionID=" & reqSessionID & "&Popup=" & reqPopup
      End If

      Set oSessionLessons = server.CreateObject("ptsSessionLessonUser.CSessionLessons")
      If oSessionLessons Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLessons"
      Else
         With oSessionLessons
            .SysCurrentLanguage = reqSysLanguage
            .ListSession CLng(reqCourseID), CLng(reqSessionID), reqLessons, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
                  'Display the inital lesson as active
                  tmpDisplay = "1"
                  prevQuiz = "1"
                  prevStatus = "4"
                  tmpLessonID = 0
                  For Each oSessionLesson in oSessionLessons
                  With oSessionLesson
                  If reqLesson > 0 AND .Seq = CSTR(reqLesson) Then tmpLessonID = .LessonID
                  secs = .Time
                  seconds = secs Mod 60
                  minutes = Int((secs / 60) Mod 60)
                  hours = Int(secs / 3600 )
                  fmt = ""
                  If hours > 0 Then fmt = Int(secs / 3600 ) & ":"
                  If minutes < 10 Then fmt = fmt + "0"
                  fmt = fmt & minutes & ":"
                  If seconds < 10 Then fmt = fmt + "0"
                  .Time = fmt & seconds & "(" & .Times & ")"

                  'If previous lessons are deactivated, inactivate all following lessons
                  If tmpDisplay = "0" Then
                  .IsPassQuiz = "0" 'do not display this lesson as active
                  Else
                  'If this lesson requires a passed quiz AND there is a quiz AND the quiz was passed
                  If .IsPassQuiz <> "0" AND prevQuiz > "1" AND prevStatus <> "4" Then
                  .IsPassQuiz = "0" 'do not display this lesson as active
                  tmpDisplay = "0" 'do not display anymore lessons.
                  Else
                  .IsPassQuiz = "1" 'display this lesson as active
                  End If
                  End If
                  prevQuiz = .Quiz
                  prevStatus = .Status
                  End With
                  Next
               
            xmlSessionLessons = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSessionLessons = Nothing
      If (tmpLessonID <> 0) Then

         Response.Redirect "m_2430.asp" & "?LessonID=" & tmpLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&MemberID=" & reqMemberID & "&Lessons=" & reqLessons & "&Popup=" & reqPopup
      End If

   Case CLng(cActionReturnClasses):

      Response.Redirect "m_1311.asp" & "?MemberID=" & reqMemberID

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("m_1330URL")
      reqReturnData = GetCache("m_1330DATA")
      SetCache "m_1330URL", ""
      SetCache "m_1330DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionCertificate):

      If (reqSessionID > 0) Then
         Set oSession = server.CreateObject("ptsSessionUser.CSession")
         If oSession Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
         Else
            With oSession
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqSessionID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqCourseID = .CourseID
            End With
         End If
         Set oSession = Nothing
      End If

      Set oCourse = server.CreateObject("ptsCourseUser.CCourse")
      If oCourse Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCourseUser.CCourse"
      Else
         With oCourse
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqCourseID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpIsCustomCertificate = .IsCustomCertificate
            xmlCourse = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCourse = Nothing

      If (tmpIsCustomCertificate = 0) Then
         Response.Redirect "1338.asp" & "?SessionID=" & reqSessionID
      End If

      If (tmpIsCustomCertificate <> 0) Then
         Response.Redirect "1107.asp" & "?SessionID=" & reqSessionID & "&I=" & 1
      End If

   Case CLng(cActionEvaluation):

      Response.Redirect "m_1304.asp" & "?SessionID=" & reqSessionID

   Case CLng(cActionRemove):

      Set oSession = server.CreateObject("ptsSessionUser.CSession")
      If oSession Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
      Else
         With oSession
            .SysCurrentLanguage = reqSysLanguage
            .Remove CLng(reqSessionID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSession = Nothing

      Response.Redirect "m_1311.asp" & "?MemberID=" & reqMemberID
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
xmlParam = xmlParam + " sessionid=" + Chr(34) + CStr(reqSessionID) + Chr(34)
xmlParam = xmlParam + " courseid=" + Chr(34) + CStr(reqCourseID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " register=" + Chr(34) + CStr(reqRegister) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " lessons=" + Chr(34) + CleanXML(reqLessons) + Chr(34)
xmlParam = xmlParam + " lesson=" + Chr(34) + CStr(reqLesson) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlSession
xmlTransaction = xmlTransaction +  xmlCourse
xmlTransaction = xmlTransaction +  xmlSessionLessons
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Session[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Session[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_1330 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_1330 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_1330 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "m_1330.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_1330 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_1330 Load file (oData) failed with error code " + CStr(oData.parseError)
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
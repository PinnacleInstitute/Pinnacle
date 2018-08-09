<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionTakeQuiz = 1
Const cActionReviewQuiz = 5
Const cActionNextLesson = 2
Const cActionGoToLesson = 4
Const cActionReturnClass = 3
Const cActionReturnLesson = 8
Const cActionReturnCourse = 9
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
Dim oSessionLesson, xmlSessionLesson
Dim oAttachments, xmlAttachments
Dim oHomeworks, xmlHomeworks
Dim oLesson, xmlLesson
Dim oSessionLessons, xmlSessionLessons
Dim oHTMLFile, xmlHTMLFile
'-----other transaction data variables
Dim xmlTextOptions
'-----declare page parameters
Dim reqLessonID
Dim reqSessionID
Dim reqCourseID
Dim reqSessionLessonID
Dim reqNextLessonID
Dim reqComplete
Dim reqPlayer
Dim reqURLOption
Dim reqMemberID
Dim reqAttachmentCount
Dim reqLessons
Dim reqContentPage
Dim reqPopup
Dim reqScormStudentID
Dim reqScormStudentName
Dim reqScormLessonLocation
Dim reqScormLessonStatus
Dim reqScormScoreRaw
Dim reqScormTotalTime
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
   SetCache "2430URL", reqReturnURL
   SetCache "2430DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "2430")
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
reqLessonID =  Numeric(GetInput("LessonID", reqPageData))
reqSessionID =  Numeric(GetInput("SessionID", reqPageData))
reqCourseID =  Numeric(GetInput("CourseID", reqPageData))
reqSessionLessonID =  Numeric(GetInput("SessionLessonID", reqPageData))
reqNextLessonID =  Numeric(GetInput("NextLessonID", reqPageData))
reqComplete =  GetInput("Complete", reqPageData)
reqPlayer =  Numeric(GetInput("Player", reqPageData))
reqURLOption =  Numeric(GetInput("URLOption", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqAttachmentCount =  Numeric(GetInput("AttachmentCount", reqPageData))
reqLessons =  GetInput("Lessons", reqPageData)
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqScormStudentID =  Numeric(GetInput("ScormStudentID", reqPageData))
reqScormStudentName =  GetInput("ScormStudentName", reqPageData)
reqScormLessonLocation =  GetInput("ScormLessonLocation", reqPageData)
reqScormLessonStatus =  GetInput("ScormLessonStatus", reqPageData)
reqScormScoreRaw =  Numeric(GetInput("ScormScoreRaw", reqPageData))
reqScormTotalTime =  Numeric(GetInput("ScormTotalTime", reqPageData))
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

Sub UpdateStatus()
   On Error Resume Next
   If (reqSessionID > 0) Then
      tmpSave = 0
      tmpTime = Request.Form.Item("Seconds")
      If (reqScormTotalTime <> 0) Then
         tmpTime = reqScormTotalTime
      End If
      reqComplete = Request.Form.Item("Complete")
      If (reqScormLessonStatus = "completed") Or (reqScormLessonStatus = "failed") Or (reqScormLessonStatus = "passed") Then
         reqComplete = "on"
      End If

      Set oSessionLesson = server.CreateObject("ptsSessionLessonUser.CSessionLesson")
      If oSessionLesson Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLesson"
      Else
         With oSessionLesson
            .SysCurrentLanguage = reqSysLanguage
            If (reqSessionLessonID = 0) Then
               reqSessionLessonID = CLng(.GetSessionLesson(CLng(reqSessionID), CLng(reqLessonID), CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            .Load CLng(reqSessionLessonID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.LessonLength = 0) Then
               reqComplete = "on"
            End If
            If (tmpTime >= 60) Then
               .Time = CLng(.Time) + CLng(tmpTime)
               .Times = CLng(.Times) + 1
               tmpSave = 1
            End If
            If (reqComplete = "on") And (.Status = 1) Then
               .Status = 2
               .CompleteDate = reqSysDate
               tmpSave = 1
            End If
            If (reqComplete = "") And (.Status = 2) Then
               .Status = 1
               .CompleteDate = 0
               tmpSave = 1
            End If
            .Location = reqScormLessonLocation
            If (reqScormScoreRaw <> 0) Then
               .QuizScore = reqScormScoreRaw
            End If
            
   If Len(reqScormLessonStatus) > 0 Then
      tmpSave = 1
      Select Case reqScormLessonStatus
         Case "not attempted": .Status = 0  ' not started
         Case "browsed": .Status = 1        ' started
         Case "incomplete": .Status = 1     ' incomplete
         Case "completed": .Status = 2      ' completed
         Case "failed": .Status = 3         ' Quized
         Case "passed": .Status = 4         ' Passed
      End Select
   End If

            If (tmpSave = 1) Then
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (xmlError <> "") Then
               xmlLesson = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oSessionLesson = Nothing

      Set oSession = server.CreateObject("ptsSessionUser.CSession")
      If oSession Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
      Else
         With oSession
            .SysCurrentLanguage = reqSysLanguage
            result = CLng(.SetStatus(CLng(reqSessionID), reqLessons))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (result > 0) Then
               Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
               If oHTTP Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
               Else
                  tmpServer = "http://" + reqSysServerName + reqSysServerPath
                  oHTTP.open "GET", tmpServer + "0418.asp" & "?MemberID=" & result & "&Notify=" & 1 & "&ID=" & reqSessionID
                  oHTTP.send
               End If
               Set oHTTP = Nothing
            End If
         End With
      End If
      Set oSession = Nothing
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqMemberID = 0) Then
         reqScormStudentID = 1
         reqScormStudentName = "Test, Joe"
      End If

      If (reqMemberID > 0) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqMemberID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqScormStudentID = reqMemberID
               reqScormStudentName = .MemberName
            End With
         End If
         Set oMember = Nothing
      End If

      If (reqSessionID > 0) Then
         Set oSessionLesson = server.CreateObject("ptsSessionLessonUser.CSessionLesson")
         If oSessionLesson Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLesson"
         Else
            With oSessionLesson
               .SysCurrentLanguage = reqSysLanguage
               reqSessionLessonID = CLng(.GetSessionLesson(CLng(reqSessionID), CLng(reqLessonID), CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (reqSessionLessonID = 0) Then
                  .Load 0, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .SessionID = reqSessionID
                  .LessonID = reqLessonID
                  .Status = 2
                  .CreateDate = reqSysDate
                  reqSessionLessonID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (xmlError = "") Then
                  .Load CLng(reqSessionLessonID), CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               reqScormLessonLocation = .Location
               reqScormScoreRaw = .QuizScore
               
   Select Case .Status
      Case 0: reqScormLessonStatus = "not attempted"  ' not started
      Case 1: reqScormLessonStatus = "browsed"        ' started
      Case 2: reqScormLessonStatus = "completed"      ' completed
      Case 3: reqScormLessonStatus = "failed"         ' Quized
      Case 4: reqScormLessonStatus = "passed"         ' Passed
   End Select

               curStatus = .Status
               If (.CompleteDate <> "0") Then
                  reqComplete = "on"
               End If
               xmlSessionLesson = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oSessionLesson = Nothing
      End If
      tmpSecurityLevel = GetCache("SECURITYLEVEL")
      If (tmpSecurityLevel = "") Then
         tmpSecurityLevel = 0
      End If

      Set oAttachments = server.CreateObject("ptsAttachmentUser.CAttachments")
      If oAttachments Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAttachmentUser.CAttachments"
      Else
         With oAttachments
            .SysCurrentLanguage = reqSysLanguage
            .ListAttachments CLng(reqLessonID), 23, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqAttachmentCount = CLng(.Count(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlAttachments = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAttachments = Nothing

      Set oHomeworks = server.CreateObject("ptsHomeworkUser.CHomeworks")
      If oHomeworks Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsHomeworkUser.CHomeworks"
      Else
         With oHomeworks
            .SysCurrentLanguage = reqSysLanguage
            If (reqSessionLessonID <> 0) Then
               .ListAttachment CLng(reqSessionLessonID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqSessionLessonID = 0) Then
               .List CLng(reqLessonID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            xmlHomeworks = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHomeworks = Nothing

      Set oLesson = server.CreateObject("ptsLessonUser.CLesson")
      If oLesson Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLessonUser.CLesson"
      Else
         With oLesson
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqLessonID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpContent = .Content
            curIsPassQuiz = .IsPassQuiz
            curQuiz = .Quiz
            If (reqSysUserGroup = 41) Or (reqSysUserGroup = 99) Then

               If (curQuiz = 3) Then
                  Response.Redirect "2112.asp" & "?LessonID=" & reqLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons & "&AutoQuiz=" & 1
               End If
            End If
            
   If InStr(.MediaURL,".rm") > 0 Or InStr(.MediaURL,".ram") > 0 Then reqPlayer = 1
   If InStr(.MediaURL,".swf") > 0 Or  InStr(.MediaURL,".flv") > 0 Or InStr(.MediaURL,".fla") > 0 Then reqPlayer = 2

   If .MediaType = 3 Then
      If .MediaWidth = 0 Then .MediaWidth = 800
      If .MediaHeight = 0 Then .MediaHeight = 600
   Else
      If .MediaWidth = 0 Then .MediaWidth = 320
      If .MediaHeight = 0 Then .MediaHeight = 240
   End If

   '--- Check if we have multiple Media URLs ---
   If InStr(.MediaURL,"[") > 0 Then
      reqURLOption = 0
      '--- Get the URL option from the form ---
      frmURLOption = Request.Form.Item("URLOption")
      reqURLOption = frmURLOption
      '--- If we don't have a URL selection, get it from the Cache ---
      cacURLOption = GetCache("URLOPTION")
      If reqURLOption = 0 Then reqURLOption = cacURLOption

      '--- If we don't have a sessionID, we are a trainer ---
      If reqSessionID = 0 Then
   '--- Set URL Option to 1 if it is 0 and cache it ---
   If reqURLOption = 0 Then reqURLOption = 1
   SetCache "URLOPTION", reqURLOption
   Else
   '--- If we got the URL option from the form (save it and cache it) OR ---
   '--- If we still have no URL option from the form or the Cache (get it and cache it) ---
   If frmURLOption > 0 OR reqURLOption = 0 Then
                  Set oSession = server.CreateObject("ptsSessionUser.CSession")
                  If oSession Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
                  Else
                     With oSession
                        .Load reqSessionID, CLng(reqSysUserID)  
                        '--- If we got the URL option from the form, save it in the Session and the Cache ---
                        If frmURLOption > 0 Then
                           .URLOption = reqURLOption
                           .Save CLng(reqSysUserID)
                           SetCache "URLOPTION", reqURLOption 
                        Else 
                           'Otherwise, Get the URL Option from the Session
                           reqURLOption = .URLOption
                           '--- If the Session didn't have a URL selection, default it to 1 and save it ---
                           If reqURLOption = 0 Then
                              reqURLOption = 1
                              .URLOption = reqURLOption
                              .Save CLng(reqSysUserID)
                           End If
                           SetCache "URLOPTION", reqURLOption 
                        End If
                     End With
                     Set oSession = Nothing
                  End If
               End If
            End If

            Set oTextOptions = server.CreateObject("wtSystem.CTextOptions")
            If oTextOptions Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - wtSystem.CTextOptions"
            Else
               With oTextOptions
                  .Load(oLesson.MediaURL)
                  xmlTextOptions = .XML(,1)
                  If .Count > 1 Then
                     oLesson.MediaURL = .Value(int(reqURLOption))
                  End If
               End With   
               Set oTextOptions = Nothing
             End If
          End If

            xmlLesson = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oLesson = Nothing

      Set oSessionLessons = server.CreateObject("ptsSessionLessonUser.CSessionLessons")
      If oSessionLessons Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLessons"
      Else
         With oSessionLessons
            .SysCurrentLanguage = reqSysLanguage
            .ListSession reqCourseID, CLng(reqSessionID), reqLessons, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
   reqNextLessonID = 0
   curLesson = 0
   nextIsPassQuiz = 0

   For Each oSessionLesson in oSessionLessons
      With oSessionLesson
         If curLesson = 1 Then
            reqNextLessonID = .LessonID
            nextIsPassQuiz = .IsPassQuiz
            Exit For
         End If
         If reqLessonID = Clng(.LessonID) Then curLesson = 1
      End With
   Next

   'NO NEXT LESSON if the next lesson requires a passed quiz AND this lesson has a quiz AND the quiz wasn't passed
   If nextIsPassQuiz <> "0" AND curQuiz > "1" AND curStatus <> "4" Then
                  reqNextLessonID = 0
               End If

            If (curIsPassQuiz = 0) Then
               xmlSessionLessons = .LessonXML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oSessionLessons = Nothing

      If (tmpContent > 1) And (reqLessonID <> 0) Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = CStr(reqLessonID) + ".htm"
               .Path = reqSysWebDirectory + "Sections\Course\" & CStr(reqCourseID)
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlHTMLFile = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oHTMLFile = Nothing
      End If

   Case CLng(cActionTakeQuiz):
      UpdateStatus

      Response.Redirect "2112.asp" & "?LessonID=" & reqLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons

   Case CLng(cActionReviewQuiz):
      UpdateStatus

      Response.Redirect "2112.asp" & "?LessonID=" & reqLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Review=" & 1 & "&Lessons=" & reqLessons

   Case CLng(cActionNextLesson):
      UpdateStatus
      reqNextLessonID = Request.Form.Item("NextLessonID")

      If (reqNextLessonID > 0) Then
         Response.Redirect "2430.asp" & "?LessonID=" & reqNextLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons & "&MemberID=" & reqMemberID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup
      End If

   Case CLng(cActionGoToLesson):
      UpdateStatus
      reqNextLessonID = Request.Form.Item("LessonID")

      If (reqNextLessonID > 0) Then
         Response.Redirect "2430.asp" & "?LessonID=" & reqNextLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons & "&MemberID=" & reqMemberID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup
      End If

   Case CLng(cActionReturnClass):
      UpdateStatus

      Response.Redirect "1330.asp" & "?SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&MemberID=" & reqMemberID & "&Lessons=" & reqLessons & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup

   Case CLng(cActionReturnLesson):

      Response.Redirect "2303.asp" & "?LessonID=" & reqLessonID

   Case CLng(cActionReturnCourse):

      Response.Redirect "1103.asp" & "?CourseID=" & reqCourseID
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
xmlParam = xmlParam + " lessonid=" + Chr(34) + CStr(reqLessonID) + Chr(34)
xmlParam = xmlParam + " sessionid=" + Chr(34) + CStr(reqSessionID) + Chr(34)
xmlParam = xmlParam + " courseid=" + Chr(34) + CStr(reqCourseID) + Chr(34)
xmlParam = xmlParam + " sessionlessonid=" + Chr(34) + CStr(reqSessionLessonID) + Chr(34)
xmlParam = xmlParam + " nextlessonid=" + Chr(34) + CStr(reqNextLessonID) + Chr(34)
xmlParam = xmlParam + " complete=" + Chr(34) + CleanXML(reqComplete) + Chr(34)
xmlParam = xmlParam + " player=" + Chr(34) + CStr(reqPlayer) + Chr(34)
xmlParam = xmlParam + " urloption=" + Chr(34) + CStr(reqURLOption) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " attachmentcount=" + Chr(34) + CStr(reqAttachmentCount) + Chr(34)
xmlParam = xmlParam + " lessons=" + Chr(34) + CleanXML(reqLessons) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " scormstudentid=" + Chr(34) + CStr(reqScormStudentID) + Chr(34)
xmlParam = xmlParam + " scormstudentname=" + Chr(34) + CleanXML(reqScormStudentName) + Chr(34)
xmlParam = xmlParam + " scormlessonlocation=" + Chr(34) + CleanXML(reqScormLessonLocation) + Chr(34)
xmlParam = xmlParam + " scormlessonstatus=" + Chr(34) + CleanXML(reqScormLessonStatus) + Chr(34)
xmlParam = xmlParam + " scormscoreraw=" + Chr(34) + CStr(reqScormScoreRaw) + Chr(34)
xmlParam = xmlParam + " scormtotaltime=" + Chr(34) + CStr(reqScormTotalTime) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlSessionLesson
xmlTransaction = xmlTransaction +  xmlAttachments
xmlTransaction = xmlTransaction +  xmlHomeworks
xmlTransaction = xmlTransaction +  xmlLesson
xmlTransaction = xmlTransaction +  xmlSessionLessons
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlTextOptions
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\SessionLesson[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\SessionLesson[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "2430 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "2430 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "2430 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "2430.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "2430 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "2430 Load file (oData) failed with error code " + CStr(oData.parseError)
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
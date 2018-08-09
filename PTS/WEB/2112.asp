<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionGradeNow = 1
Const cActionNextLesson = 2
Const cActionGoToLesson = 4
Const cActionReturnLesson = 5
Const cActionReturnClass = 3
Const cActionRetakeQuiz = 6
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
Dim oHTMLFile, xmlHTMLFile
Dim oSession, xmlSession
Dim oLesson, xmlLesson
Dim oOrgCourse, xmlOrgCourse
Dim oSessionLesson, xmlSessionLesson
Dim oSessionLessons, xmlSessionLessons
Dim oQuizQuestions, xmlQuizQuestions
Dim oQuizAnswers, xmlQuizAnswers
'-----declare page parameters
Dim reqLessonID
Dim reqSessionID
Dim reqCourseID
Dim reqNextLessonID
Dim reqGrade
Dim reqReview
Dim reqTotalPoints
Dim reqPassingPoints
Dim reqYourGrade
Dim reqQuizLimit
Dim reqAutoQuiz
Dim reqContentPage
Dim reqPopup
Dim reqIdentify
Dim reqMemberID
Dim reqLessons
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
   SetCache "2112URL", reqReturnURL
   SetCache "2112DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "2112")
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
reqNextLessonID =  Numeric(GetInput("NextLessonID", reqPageData))
reqGrade =  GetInput("Grade", reqPageData)
reqReview =  Numeric(GetInput("Review", reqPageData))
reqTotalPoints =  Numeric(GetInput("TotalPoints", reqPageData))
reqPassingPoints =  Numeric(GetInput("PassingPoints", reqPageData))
reqYourGrade =  Numeric(GetInput("YourGrade", reqPageData))
reqQuizLimit =  Numeric(GetInput("QuizLimit", reqPageData))
reqAutoQuiz =  Numeric(GetInput("AutoQuiz", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqIdentify =  Numeric(GetInput("Identify", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqLessons =  GetInput("Lessons", reqPageData)
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

Sub LoadQuiz()
   On Error Resume Next

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = CStr(reqLessonID) + "q.htm"
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

   If (reqSessionID > 0) Then
      Set oSession = server.CreateObject("ptsSessionUser.CSession")
      If oSession Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
      Else
         With oSession
            .SysCurrentLanguage = reqSysLanguage
            .Load reqSessionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqQuizLimit = .QuizLimit
            tmpOrgCourseID = .OrgCourseID
            reqMemberID = .MemberID
         End With
      End If
      Set oSession = Nothing
   End If

   Set oLesson = server.CreateObject("ptsLessonUser.CLesson")
   If oLesson Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLessonUser.CLesson"
   Else
      With oLesson
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqLessonID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpPassingGrade = .PassingGrade
         tmpQuizWeight = .QuizWeight
         If (.QuizWeight = 0) Then
            reqQuizLimit = 0
         End If
         tmpQuizLength = CLng(.QuizLength)
         curIsPassQuiz = .IsPassQuiz
         curQuiz = .Quiz
         xmlLesson = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLesson = Nothing

   If (tmpOrgCourseID > 0) And (tmpQuizWeight > 0) Then
      Set oOrgCourse = server.CreateObject("ptsOrgCourseUser.COrgCourse")
      If oOrgCourse Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsOrgCourseUser.COrgCourse"
      Else
         With oOrgCourse
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpOrgCourseID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.QuizLimit > 0) Then
               reqQuizLimit = .QuizLimit
            End If
         End With
      End If
      Set oOrgCourse = Nothing
   End If

   If (reqSessionID > 0) Then
      Set oSessionLesson = server.CreateObject("ptsSessionLessonUser.CSessionLesson")
      If oSessionLesson Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLesson"
      Else
         With oSessionLesson
            .SysCurrentLanguage = reqSysLanguage
            tmpSessionLessonID = CLng(.GetSessionLesson(reqSessionID, CLng(reqLessonID), CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load tmpSessionLessonID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqYourGrade = .QuizScore
            curStatus = .Status
            tmpQuestions = .Questions
         End With
      End If
      Set oSessionLesson = Nothing
   End If

   If (reqSessionID > 0) Then
      Set oSessionLessons = server.CreateObject("ptsSessionLessonUser.CSessionLessons")
      If oSessionLessons Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLessons"
      Else
         With oSessionLessons
            .SysCurrentLanguage = reqSysLanguage
            .ListSession reqCourseID, reqSessionID, reqLessons, CLng(reqSysUserID)
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
   End If

   Set oQuizQuestions = server.CreateObject("ptsQuizQuestionUser.CQuizQuestions")
   If oQuizQuestions Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuizQuestionUser.CQuizQuestions"
   Else
      With oQuizQuestions
         .SysCurrentLanguage = reqSysLanguage
         .ListQuizQuestion CLng(reqLessonID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
               tmpSaveQuestions = 0
               'If the quiz has a specific number of questions AND we have none Then get the questions
               If tmpQuizLength <> 0 AND tmpQuestions = "" Then
                  tmpSaveQuestions = 1
                  tmpQuestions = "~"
                  cnt = 0
                  total = 0
                  'Get all the non-random questions
                  For Each oQuizQuestion in oQuizQuestions
                     With oQuizQuestion
                        If cnt < tmpQuizLength AND .IsRandom = 0 Then
                           'Make sure we don't exceed the storage for the question IDs
                           If (Len(tmpQuestions) + Len(CStr(.QuizQuestionID)) + 1) < 200 Then
                              tmpQuestions = tmpQuestions + CStr(.QuizQuestionID) + "~"
                              cnt = cnt + 1
                              .Seq = cnt
                           Else
                              cnt = tmpQuizLength
                              Response.write "Length of Quiz Questions exceeds storage capacity - see administrator"
                           End If
                        End If
                     End With   
                     total = total + 1
                  Next
                  'Make sure we have enough questions
                  If tmpQuizLength > total Then tmpQuizLength = total
                  'If we still need more questions get the needed random questions
                  While cnt < tmpQuizLength
                     'get a random number
                     randomize
                     random = Int((total * Rnd) + 1)
                     With oQuizQuestions.Item(random)
                        tmpQuizQuestionID = .QuizQuestionID
                        tmpIsRandom = .IsRandom
                        If tmpIsRandom <> 0 Then
                           If InStr(tmpQuestions, "~" + CStr(tmpQuizQuestionID) + "~") = 0 Then
                              'Make sure we don't exceed the storage for the question IDs
                              If (Len(tmpQuestions) + Len(CStr(tmpQuizQuestionID)) + 1) < 200 Then
                                 tmpQuestions = tmpQuestions + CStr(tmpQuizQuestionID) + "~"
                                 cnt = cnt + 1
                                 .Seq = cnt
                              Else
                                 cnt = tmpQuizLength
                                 Response.write "Length of Quiz Questions exceeds storage capacity - see administrator"
                              End If
                           End If
                        End If
                     End With
                  Wend
               End If

               reqTotalPoints = 0
               For Each oQuizQuestion in oQuizQuestions
                  With oQuizQuestion
                     If tmpQuizLength = 0 Then
                        reqTotalPoints = reqTotalPoints + .Points
                     Else
                        'clear the name of the unused questions, otherwise get total points
                        If InStr(tmpQuestions, "~" + CStr(.QuizQuestionID) + "~") = 0 Then
                           .Question = ""
                           .Explain = ""
                           .MediaFile = ""
                        Else
                           reqTotalPoints = reqTotalPoints + .Points
                        End If
                     End If
                  End With
               Next
               reqPassingPoints = Round( (tmpPassingGrade * reqTotalPoints) / 100 )

         xmlQuizQuestions = .XML(1111)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
               xmlQuizQuestions = Replace(xmlQuizQuestions, "selected=""True", "selected=""on")

      End With
   End If
   Set oQuizQuestions = Nothing

   If (reqSessionID <> 0) And (tmpSaveQuestions = 1) Then
      Set oSessionLesson = server.CreateObject("ptsSessionLessonUser.CSessionLesson")
      If oSessionLesson Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLesson"
      Else
         With oSessionLesson
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpSessionLessonID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Questions = tmpQuestions
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSessionLesson = Nothing
   End If

   If (reqSessionID <> 0) Then
      Set oQuizAnswers = server.CreateObject("ptsQuizAnswerUser.CQuizAnswers")
      If oQuizAnswers Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuizAnswerUser.CQuizAnswers"
      Else
         With oQuizAnswers
            .SysCurrentLanguage = reqSysLanguage
            .ListQuizAnswer tmpSessionLessonID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlQuizAnswers = .ChoiceXML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
               if Len(xmlQuizAnswers) > 20 Then reqReview = 1

         End With
      End If
      Set oQuizAnswers = Nothing
   End If
End Sub

Sub GradeQuiz()
   On Error Resume Next
   If (reqSessionID > 0) And (reqGrade = "on") Then

      Set oSessionLesson = server.CreateObject("ptsSessionLessonUser.CSessionLesson")
      If oSessionLesson Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLesson"
      Else
         With oSessionLesson
            .SysCurrentLanguage = reqSysLanguage
            tmpSessionLessonID = CLng(.GetSessionLesson(reqSessionID, CLng(reqLessonID), CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSessionLesson = Nothing

      If (tmpSessionLessonID > 0) Then
         Set oQuizQuestions = server.CreateObject("ptsQuizQuestionUser.CQuizQuestions")
         If oQuizQuestions Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuizQuestionUser.CQuizQuestions"
         Else
            With oQuizQuestions
               .SysCurrentLanguage = reqSysLanguage
               .ListQuizQuestion CLng(reqLessonID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
               Set oQuizAnswer = server.CreateObject("ptsQuizAnswerUser.CQuizAnswer")
               If oQuizAnswer Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuizAnswerUser.CQuizAnswer"
               Else
                  With oQuizAnswer
                     .SysCurrentLanguage = reqSysLanguage
                     .SessionLessonID = tmpSessionLessonID
                     .CreateDate = reqSysDate
                  End With
               End If
               Set oQuizAnswers = server.CreateObject("ptsQuizAnswerUser.CQuizAnswers")
               If oQuizAnswers Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuizAnswerUser.CQuizAnswers"
               Else
                  With oQuizAnswers
                     .SysCurrentLanguage = reqSysLanguage
                     .ListQuizQuestion tmpSessionLessonID, CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If

               For Each oQuizQuestion in oQuizQuestions
                  tmpQuestionID = oQuizQuestion.QuizQuestionID
                  tmpCorrectID = oQuizQuestion.QuizChoiceID
                  tmpID = Request.Form.Item(tmpQuestionID)

                  If tmpID <> "" Then
                     'Check if the Question has already been Answered
                     tmpQuizAnswerID = 0
                     For Each oAnswer in oQuizAnswers
                        If oAnswer.QuizQuestionID = tmpQuestionID Then
                           tmpQuizAnswerID = oAnswer.QuizAnswerID
                           Exit For
                        End If
                     Next

                     With oQuizAnswer
                        .QuizQuestionID = tmpQuestionID
                     .QuizChoiceID = tmpID
                     .IsCorrect = 0
                     If (tmpID = tmpCorrectID) Then .IsCorrect = 1

                        If tmpQuizAnswerID > 0 Then
                        .QuizAnswerID = tmpQuizAnswerID
                        .Save reqSysUserID
                        Else
                        QuizAnswerID = CLng(.Add( reqSysUserID ))
                        End If
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     End With
                  End If
               Next
               result = oQuizAnswer.Grade( tmpSessionLessonID, reqSysUserID )
               Set oQuizAnswer = Nothing
               Set oQuizAnswers = Nothing

            End With
         End If
         Set oQuizQuestions = Nothing
      End If

      Set oSession = server.CreateObject("ptsSessionUser.CSession")
      If oSession Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
      Else
         With oSession
            .SysCurrentLanguage = reqSysLanguage
            result = CLng(.SetStatus(reqSessionID, reqLessons))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSession = Nothing
      If (xmlError <> "") Then
         LoadQuiz
      End If
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqSysUserGroup = 41) And (reqIdentify = 0) Then
         reqIdentify = GetCache("IDENTIFY")
      End If
      If (reqReview = 0) Then
         reqGrade = "on"
      End If
      LoadQuiz

   Case CLng(cActionGradeNow):
      reqGrade = "on"
      GradeQuiz
      reqGrade = ""
      reqReview = 1
      If (xmlError = "") Then
         LoadQuiz
      End If

   Case CLng(cActionNextLesson):
      reqGrade = Request.Form.Item("Grade")
      GradeQuiz
      If (xmlError = "") Then
         reqNextLessonID = Request.Form.Item("NextLessonID")

         If (reqNextLessonID > 0) Then
            Response.Redirect "2430.asp" & "?LessonID=" & reqNextLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
         End If
      End If

   Case CLng(cActionGoToLesson):
      reqGrade = Request.Form.Item("Grade")
      GradeQuiz
      If (xmlError = "") Then
         reqNextLessonID = Request.Form.Item("LessonID")

         If (reqNextLessonID > 0) Then
            Response.Redirect "2430.asp" & "?LessonID=" & reqNextLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
         End If
      End If

   Case CLng(cActionReturnLesson):
      reqGrade = Request.Form.Item("Grade")
      GradeQuiz
      If (xmlError = "") Then

         Response.Redirect "2430.asp" & "?LessonID=" & reqLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
      End If

   Case CLng(cActionReturnClass):
      reqGrade = Request.Form.Item("Grade")
      GradeQuiz
      If (xmlError = "") Then

         Response.Redirect "1330.asp" & "?SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup
      End If

   Case CLng(cActionRetakeQuiz):

      Set oSessionLesson = server.CreateObject("ptsSessionLessonUser.CSessionLesson")
      If oSessionLesson Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLesson"
      Else
         With oSessionLesson
            .SysCurrentLanguage = reqSysLanguage
            tmpSessionLessonID = CLng(.DeleteQuiz(reqSessionID, CLng(reqLessonID), CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSessionLesson = Nothing

      Response.Redirect "2112.asp" & "?LessonID=" & reqLessonID & "&SessionID=" & reqSessionID & "&CourseID=" & reqCourseID & "&Lessons=" & reqLessons & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
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
xmlParam = xmlParam + " nextlessonid=" + Chr(34) + CStr(reqNextLessonID) + Chr(34)
xmlParam = xmlParam + " grade=" + Chr(34) + CleanXML(reqGrade) + Chr(34)
xmlParam = xmlParam + " review=" + Chr(34) + CStr(reqReview) + Chr(34)
xmlParam = xmlParam + " totalpoints=" + Chr(34) + CStr(reqTotalPoints) + Chr(34)
xmlParam = xmlParam + " passingpoints=" + Chr(34) + CStr(reqPassingPoints) + Chr(34)
xmlParam = xmlParam + " yourgrade=" + Chr(34) + CStr(reqYourGrade) + Chr(34)
xmlParam = xmlParam + " quizlimit=" + Chr(34) + CStr(reqQuizLimit) + Chr(34)
xmlParam = xmlParam + " autoquiz=" + Chr(34) + CStr(reqAutoQuiz) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " identify=" + Chr(34) + CStr(reqIdentify) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " lessons=" + Chr(34) + CleanXML(reqLessons) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlSession
xmlTransaction = xmlTransaction +  xmlLesson
xmlTransaction = xmlTransaction +  xmlOrgCourse
xmlTransaction = xmlTransaction +  xmlSessionLesson
xmlTransaction = xmlTransaction +  xmlSessionLessons
xmlTransaction = xmlTransaction +  xmlQuizQuestions
xmlTransaction = xmlTransaction +  xmlQuizAnswers
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\QuizQuestion[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\QuizQuestion[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "2112 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "2112 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "2112 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "2112.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "2112 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "2112 Load file (oData) failed with error code " + CStr(oData.parseError)
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
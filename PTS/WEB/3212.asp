<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionAdd = 2
Const cActionCancel = 3
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
Dim oAssessment, xmlAssessment
Dim oMemberAssess, xmlMemberAssess
Dim oAssessQuestion, xmlAssessQuestion
Dim oAssessQuestions, xmlAssessQuestions
Dim oAssessChoices, xmlAssessChoices
Dim oAssessAnswers, xmlAssessAnswers
'-----declare page parameters
Dim reqAssessmentID
Dim reqMemberAssessID
Dim reqAssessQuestionID
Dim reqGrp
Dim reqCount
Dim reqQuestions
Dim reqMemberID
Dim reqContentPage
Dim reqPopup
Dim reqSeconds
Dim reqTimeLimit
Dim reqIdentify
Dim reqIsCertify
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
   SetCache "3212URL", reqReturnURL
   SetCache "3212DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "3212")
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
reqAssessmentID =  Numeric(GetInput("AssessmentID", reqPageData))
reqMemberAssessID =  Numeric(GetInput("MemberAssessID", reqPageData))
reqAssessQuestionID =  Numeric(GetInput("AssessQuestionID", reqPageData))
reqGrp =  Numeric(GetInput("Grp", reqPageData))
reqCount =  Numeric(GetInput("Count", reqPageData))
reqQuestions =  GetInput("Questions", reqPageData)
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqSeconds =  Numeric(GetInput("Seconds", reqPageData))
reqTimeLimit =  Numeric(GetInput("TimeLimit", reqPageData))
reqIdentify =  Numeric(GetInput("Identify", reqPageData))
reqIsCertify =  Numeric(GetInput("IsCertify", reqPageData))
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

Sub LoadQuestion()
   On Error Resume Next

   Set oAssessment = server.CreateObject("ptsAssessmentUser.CAssessment")
   If oAssessment Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessmentUser.CAssessment"
   Else
      With oAssessment
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqAssessmentID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqTimeLimit = .TimeLimit
         reqIsCertify = .IsCertify
         tmpFirstQuestionCode = .FirstQuestionCode
         tmpAssessmentType = .AssessmentType
         tmpNewURL = .NewURL
         tmpEditURL = .EditURL
         tmpResultType = .ResultType
         xmlAssessment = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAssessment = Nothing

   Set oMemberAssess = server.CreateObject("ptsMemberAssessUser.CMemberAssess")
   If oMemberAssess Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberAssessUser.CMemberAssess"
   Else
      With oMemberAssess
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberAssessID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlMemberAssess = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (tmpAssessmentType = 2) Then
            tmpExternalID = .ExternalID
            reqMemberID = .MemberID

            If (xmlError = "") Then
               Response.Redirect "CONST(tmpNewURL).asp" & "?NameLast=" & tmpNameLast & "&NameFirst=" & tmpNameFirst & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
            End If
         End If
      End With
   End If
   Set oMemberAssess = Nothing

   If (reqAssessQuestionID <> 0) Then
      Set oAssessQuestion = server.CreateObject("ptsAssessQuestionUser.CAssessQuestion")
      If oAssessQuestion Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessQuestionUser.CAssessQuestion"
      Else
         With oAssessQuestion
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqAssessQuestionID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqGrp = .Grp
            tmpQuestionType = .QuestionType
            tmpQuestion = .Question
            xmlAssessQuestion = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAssessQuestion = Nothing
   End If

   If (reqAssessQuestionID = 0) Then
      Set oAssessQuestion = server.CreateObject("ptsAssessQuestionUser.CAssessQuestion")
      If oAssessQuestion Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessQuestionUser.CAssessQuestion"
      Else
         With oAssessQuestion
            .SysCurrentLanguage = reqSysLanguage
            If (tmpFirstQuestionCode <> 0) Then
               .LoadQuestionCode CLng(reqAssessmentID), tmpFirstQuestionCode
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (tmpFirstQuestionCode = 0) Then
               .LoadDefaultQuestion CLng(reqAssessmentID), -1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            reqAssessQuestionID = .AssessQuestionID
            tmpQuestion = .Question
            reqGrp = .NextGrp
            tmpQuestionType = .QuestionType
            xmlAssessQuestion = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAssessQuestion = Nothing
   End If
   If (tmpResultType = 3) Then
      reqQuestions = Request.Form.Item("Questions")
      
               If reqQuestions = "" Then
                  reqQuestions = CStr(reqAssessQuestionID)
               Else
                  reqQuestions = reqQuestions + "," + CStr(reqAssessQuestionID)
               End If

   End If
   If (tmpQuestionType = 4) Then
      
               reqQuestions = reqQuestions + ";" + CStr(tmpQuestion)

      CalcResult
   End If

   If (tmpQuestionType <> 4) Then
      Set oAssessQuestions = server.CreateObject("ptsAssessQuestionUser.CAssessQuestions")
      If oAssessQuestions Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessQuestionUser.CAssessQuestions"
      Else
         With oAssessQuestions
            .SysCurrentLanguage = reqSysLanguage
            .ListGroup CLng(reqAssessmentID), CLng(reqGrp), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCount = CLng(.Count(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlAssessQuestions = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            tmpGetChoices = 0
            For Each oAssessQuestion in oAssessQuestions
               If oAssessQuestion.QuestionType = 3 Then
                  tmpGetChoices = 1
                  Exit For
               End If
            Next

         End With
      End If
      Set oAssessQuestions = Nothing
   End If

   If (tmpQuestionType <> 4) And (tmpGetChoices = 1) Then
      Set oAssessChoices = server.CreateObject("ptsAssessChoiceUser.CAssessChoices")
      If oAssessChoices Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessChoiceUser.CAssessChoices"
      Else
         With oAssessChoices
            .SysCurrentLanguage = reqSysLanguage
            .ListGroup CLng(reqAssessmentID), CLng(reqGrp), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlAssessChoices = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAssessChoices = Nothing
   End If

   If (tmpQuestionType <> 4) Then
      Set oAssessAnswers = server.CreateObject("ptsAssessAnswerUser.CAssessAnswers")
      If oAssessAnswers Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessAnswerUser.CAssessAnswers"
      Else
         With oAssessAnswers
            .SysCurrentLanguage = reqSysLanguage
            .ListGroup CLng(reqMemberAssessID), CLng(reqAssessmentID), CLng(reqGrp), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlAssessAnswers = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAssessAnswers = Nothing
   End If
End Sub

Sub SaveAnswer()
   On Error Resume Next
   reqGrp = Request.Form.Item("Grp")

   Set oAssessQuestions = server.CreateObject("ptsAssessQuestionUser.CAssessQuestions")
   If oAssessQuestions Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessQuestionUser.CAssessQuestions"
   Else
      With oAssessQuestions
         .SysCurrentLanguage = reqSysLanguage
         .ListGroup CLng(reqAssessmentID), CLng(reqGrp), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            
            Set oAssessAnswers = server.CreateObject("ptsAssessAnswerUser.CAssessAnswers")
            If oAssessAnswers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessAnswerUser.CAssessAnswers"
            Else
               With oAssessAnswers
                  .SysCurrentLanguage = reqSysLanguage
                  .ListGroup CLng(reqMemberAssessID), CLng(reqAssessmentID), CLng(reqGrp), CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If

            tmpGetChoices = 0
            For Each oAssessQuestion in oAssessQuestions
               If oAssessQuestion.QuestionType = 3 and oAssessQuestion.Multiselect <> 0 Then
                  tmpGetChoices = 1
                  Exit For
               End If
            Next

            If (tmpGetChoices = 1) Then
               Set oAssessChoices = server.CreateObject("ptsAssessChoiceUser.CAssessChoices")
               If oAssessChoices Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessChoiceUser.CAssessChoices"
               Else
                  With oAssessChoices
                     .SysCurrentLanguage = reqSysLanguage
                     .ListGroup CLng(reqAssessmentID), CLng(reqGrp), CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
            End If
            
            Set oAssessAnswer = server.CreateObject("ptsAssessAnswerUser.CAssessAnswer")
            If oAssessAnswer Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessAnswerUser.CAssessAnswer"
            Else
               With oAssessAnswer
                  .SysCurrentLanguage = reqSysLanguage
                  .MemberAssessID = reqMemberAssessID
                  .AnswerDate = Now
               End With
            End If
            
            For Each oAssessQuestion in oAssessQuestions
               With oAssessQuestion
                  tmpAssessQuestionID = .AssessQuestionID                            
                  tmpQuestionType = .QuestionType
                  tmpMultiselect = .Multiselect
               End With
                  
               '--- If we have multiselect checkboxes ---
               If tmpQuestionType = 3 And tmpMultiselect <> 0 Then
                  '--- walk through each of the choices for this question ---
                  For Each oChoice in oAssessChoices
                     tmpAssessAnswerID = 0
                     '--- if the choice belongs to the current question ---
                     If oChoice.AssessQuestionID = tmpAssessQuestionID Then
                        tmpChoiceID = oChoice.AssessChoiceID
                        '--- if this is not the first time for this assessment ---
                        '--- check if an answer exists for this choice ---
                        For Each oAnswer in oAssessAnswers
                           '--- if the answer exists ---
                           If oAnswer.AssessChoiceID = tmpChoiceID Then
                              '--- save the AssessAnswerID and get out of the loop ---
                              tmpAssessAnswerID = oAnswer.AssessAnswerID
                              Exit For
                           End If
                        Next
                        '--- get the checkbox value from the form ---
                        tmpAnswer = Request.Form.Item("C" & tmpChoiceID)
                        With oAssessAnswer
                           .AssessQuestionID = tmpAssessQuestionID
                           .AssessChoiceID = tmpChoiceID
                           .Answer = 0
                           '--- if the checkbox was checked and there was no existing answer, Add it ---
                           If tmpAnswer = "on"  and tmpAssessAnswerID = 0 Then
                               AssessAnswerID = CLng(.Add( reqSysUserID ))
                           End If
                           '--- if the checkbox was not checked and there was an existing answer, Delete it ---
                           If tmpAnswer = ""  and tmpAssessAnswerID <> 0 Then
                              .Delete CLng(tmpAssessAnswerID),reqSysUserID
                           End If
                        End With
                     End If
                  Next
               Else  
                  '--- process everything except multiselect checkboxes ---
                  tmpAssessAnswerID = 0
                  '--- if this is not the first time for this assessment ---
                  'Check if the Question has already been Answered
                  For Each oAnswer in oAssessAnswers
                     If oAnswer.AssessQuestionID = tmpAssessQuestionID Then
                        '--- save the AssessAnswerID and get out of the loop ---
                        tmpAssessAnswerID = oAnswer.AssessAnswerID
                        Exit For
                     End If
                  Next
               
                  '--- get the user input from the form ---
                  tmpAnswer = Request.Form.Item(tmpAssessQuestionID)
                  With oAssessAnswer
                     .AssessQuestionID = tmpAssessQuestionID
                     '--- set the user input value  ---
                     Select Case tmpQuestionType
                        Case 1,2:  '--- priority or rank textbox value
                           .Answer = tmpAnswer
                           .AssessChoiceID = 0
                        Case 3:      '--- choice radio button
                           .AssessChoiceID = tmpAnswer
                           .Answer = 0
                        Case 5:      '--- text
                           .AssessChoiceID = 0
                           .Answer = 0
                           .AnswerText = tmpAnswer
                     End Select
                     '--- If the answer already exists, update it 
                     If tmpAssessAnswerID > 0 Then
                        .AssessAnswerID = tmpAssessAnswerID
                        .Save reqSysUserID
                     Else
                        '--- If the answer deos not exist, add it 
                        AssessAnswerID = CLng(.Add( reqSysUserID ))
                     End If
                  End With
               End If
                
            Next
            
            
            Set oAssessChoices = Nothing
            Set oAssessAnswer = Nothing
            Set oAssessAnswers = Nothing
            

      End With
   End If
   Set oAssessQuestions = Nothing
End Sub

Sub CalcResult()
   On Error Resume Next

   Set oMemberAssess = server.CreateObject("ptsMemberAssessUser.CMemberAssess")
   If oMemberAssess Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberAssessUser.CMemberAssess"
   Else
      With oMemberAssess
         .SysCurrentLanguage = reqSysLanguage
         Result = .CalcResult(CLng(reqMemberAssessID), reqQuestions)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load CLng(reqMemberAssessID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlMemberAssess = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
         If oHTTP Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
         Else
            tmpServer = "http://" + reqSysServerName + reqSysServerPath
            oHTTP.open "GET", tmpServer + "0418.asp" & "?MemberID=" & reqMemberID & "&Notify=" & 2 & "&ID=" & reqAssessmentID
            oHTTP.send
         End If
         Set oHTTP = Nothing
      End With
   End If
   Set oMemberAssess = Nothing
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqSeconds = 0
      LoadQuestion
      If (reqSysUserGroup = 41) And (reqIsCertify <> 0) And (reqIdentify = 0) Then
         reqIdentify = GetCache("IDENTIFY")
      End If

   Case CLng(cActionAdd):
      SaveAnswer
      If (reqTimeLimit = 0) Or (reqSeconds < CLng(reqTimeLimit) * 60) Then
         reqAssessQuestionID = Request.Form.Item("AssessQuestionID")

         Set oAssessQuestion = server.CreateObject("ptsAssessQuestionUser.CAssessQuestion")
         If oAssessQuestion Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAssessQuestionUser.CAssessQuestion"
         Else
            With oAssessQuestion
               .SysCurrentLanguage = reqSysLanguage
               reqAssessQuestionID = CLng(.GetNextQuestion(CLng(reqAssessQuestionID), CLng(reqMemberAssessID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (reqAssessQuestionID = 0) Then
                  CalcResult
               End If
               If (reqAssessQuestionID <> 0) Then
                  LoadQuestion
               End If
            End With
         End If
         Set oAssessQuestion = Nothing
      End If
      If (reqTimeLimit <> 0) And (reqSeconds >= CLng(reqTimeLimit) * 60) Then
         reqTimeLimit = 0
         CalcResult
      End If

   Case CLng(cActionCancel):

      Set oMemberAssess = server.CreateObject("ptsMemberAssessUser.CMemberAssess")
      If oMemberAssess Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberAssessUser.CMemberAssess"
      Else
         With oMemberAssess
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberAssessID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpMemberID = .MemberID
         End With
      End If
      Set oMemberAssess = Nothing

      Response.Redirect "3411.asp" & "?MemberID=" & tmpMemberID
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
xmlParam = xmlParam + " assessmentid=" + Chr(34) + CStr(reqAssessmentID) + Chr(34)
xmlParam = xmlParam + " memberassessid=" + Chr(34) + CStr(reqMemberAssessID) + Chr(34)
xmlParam = xmlParam + " assessquestionid=" + Chr(34) + CStr(reqAssessQuestionID) + Chr(34)
xmlParam = xmlParam + " grp=" + Chr(34) + CStr(reqGrp) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " questions=" + Chr(34) + CleanXML(reqQuestions) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " seconds=" + Chr(34) + CStr(reqSeconds) + Chr(34)
xmlParam = xmlParam + " timelimit=" + Chr(34) + CStr(reqTimeLimit) + Chr(34)
xmlParam = xmlParam + " identify=" + Chr(34) + CStr(reqIdentify) + Chr(34)
xmlParam = xmlParam + " iscertify=" + Chr(34) + CStr(reqIsCertify) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlAssessment
xmlTransaction = xmlTransaction +  xmlMemberAssess
xmlTransaction = xmlTransaction +  xmlAssessQuestion
xmlTransaction = xmlTransaction +  xmlAssessQuestions
xmlTransaction = xmlTransaction +  xmlAssessChoices
xmlTransaction = xmlTransaction +  xmlAssessAnswers
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\AssessQuestion[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\AssessQuestion[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "3212 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "3212 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "3212 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "3212.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "3212 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "3212 Load file (oData) failed with error code " + CStr(oData.parseError)
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
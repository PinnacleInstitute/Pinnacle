<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionTask = 4
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
Dim oNote, xmlNote
Dim oGoal, xmlGoal
Dim oGoals, xmlGoals
'-----declare page parameters
Dim reqGoalID
Dim reqCount
Dim reqTitle
Dim reqUpdateGoalID
Dim reqClearGoal
Dim reqContentPage
Dim reqPopup
Dim reqMemberID
Dim reqProspectID
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
   SetCache "7003URL", reqReturnURL
   SetCache "7003DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "7003")
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
reqGoalID =  Numeric(GetInput("GoalID", reqPageData))
reqCount =  Numeric(GetInput("Count", reqPageData))
reqTitle =  GetInput("Title", reqPageData)
reqUpdateGoalID =  Numeric(GetInput("UpdateGoalID", reqPageData))
reqClearGoal =  Numeric(GetInput("ClearGoal", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqProspectID =  Numeric(GetInput("ProspectID", reqPageData))
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

Function AddNote(prmNotes, prmGoalID)
   On Error Resume Next

   Set oNote = server.CreateObject("ptsNoteUser.CNote")
   If oNote Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
   Else
      With oNote
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .AuthUserID = reqSysUserID
         .NoteDate = Now
         .OwnerType = 70
         .OwnerID = prmGoalID
         .IsLocked = 1
         .Notes = prmNotes
         NoteID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oNote = Nothing
End Function

Sub LoadGoal()
   On Error Resume Next

   Set oGoal = server.CreateObject("ptsGoalUser.CGoal")
   If oGoal Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsGoalUser.CGoal"
   Else
      With oGoal
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqGoalID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpMentoringID = GetCache("MENTORINGID")
         reqMemberID = .MemberID
         reqProspectID = .ProspectID
         If (tmpMentoringID = "") Then
            tmpMentoringID = -1
         End If
         If (reqSysUserGroup = 41) And (Clng(.MemberID) <> reqSysMemberID) And (Clng(.MemberID) <> Clng(tmpMentoringID)) Then

            Response.Redirect "0101.asp" & "?ActionCode=" & 9
         End If
         reqTitle = .GoalName
         xmlGoal = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oGoal = Nothing

   Set oGoals = server.CreateObject("ptsGoalUser.CGoals")
   If oGoals Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsGoalUser.CGoals"
   Else
      With oGoals
         .SysCurrentLanguage = reqSysLanguage
         .ListParent CLng(reqGoalID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlGoals = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCount = CLng(.Count(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oGoals = Nothing
End Sub

Function ReturnGoal(prmParentID, prmMemberID)
   On Error Resume Next

   Set oGoal = server.CreateObject("ptsGoalUser.CGoal")
   If oGoal Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsGoalUser.CGoal"
   Else
      With oGoal
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqGoalID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         prmParentID = .ParentID
         prmMemberID = .MemberID
         tmpCompanyID = .CompanyID
         tmpTemplate = .Template
      End With
   End If
   Set oGoal = Nothing
   If (prmParentID = 0) Then

      If (tmpCompanyID <> 0) Then
         Response.Redirect "7014.asp" & "?CompanyID=" & tmpCompanyID & "&Template=" & tmpTemplate
      End If
      If (tmpCompanyID = 0) Then

         If (tmpTemplate = 1) Or (tmpTemplate = 2) Then
            Response.Redirect "7014.asp" & "?MemberID=" & prmMemberID & "&Template=" & tmpTemplate
         End If

         Response.Redirect "7001.asp" & "?MemberID=" & prmMemberID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup
      End If
   End If

   If (prmParentID <> 0) Then
      Response.Redirect "7003.asp" & "?GoalID=" & prmParentID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup & "&ReturnURL=" & reqPageURL
   End If
End Function

Sub UpdateGoal()
   On Error Resume Next

   If (reqUpdateGoalID > 0) Then
      Set oGoal = server.CreateObject("ptsGoalUser.CGoal")
      If oGoal Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsGoalUser.CGoal"
      Else
         With oGoal
            .SysCurrentLanguage = reqSysLanguage
            .Load reqUpdateGoalID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCommitDate = .CommitDate
            tmpCompleteDate = .CompleteDate
            tmpStatus = .Status
            If (reqClearGoal = 0) Then
               If (.Status = 2) Then
                  .Status = 3
                  .CompleteDate = reqSysDate
                  .RemindDate = ""
               End If
               If (.Status = 0) Or (.Status = 1) Then
                  .Status = 2
                  .CommitDate = reqSysDate
               End If
            End If
            If (reqClearGoal <> 0) Then
               .Status = 0
               .CommitDate = ""
               .CompleteDate = ""
               .RemindDate = ""
               .Variance = 0
               .ActQty = 0
            End If
            
            If .Status < 4 Then
               If IsDate(.CommitDate) Then
                  .Status = 2
                  If IsDate(.CompleteDate) Then
                     .Status = 3
                     .Variance = DATEDIFF("d", .CommitDate, .CompleteDate)
                     .RemindDate = ""
                  End If
               End If
            End If

            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (xmlError = "") And (.Template <> 1) And (.Template <> 2) Then
               If (tmpCommitDate <> "0") And (tmpCommitDate <> .CommitDate) Then
                  AddNote "Projected Date Changed from " + tmpCommitDate + " to " + .CommitDate, reqUpdateGoalID
               End If
               If (tmpCompleteDate <> "0") And (tmpCompleteDate <> .CompleteDate) Then
                  AddNote "Complete Date Changed from " + tmpCompleteDate + " to " + .CompleteDate, reqUpdateGoalID
               End If
            End If
            If (xmlError = "") And (tmpStatus <> 3) And (.Status = 3) Then
               Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
               If oHTTP Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
               Else
                  tmpServer = "http://" + reqSysServerName + reqSysServerPath
                  oHTTP.open "GET", tmpServer + "0418.asp" & "?MemberID=" & .MemberID & "&Notify=" & 4 & "&ID=" & .GoalID
                  oHTTP.send
               End If
               Set oHTTP = Nothing
               If (.MemberID <> reqSysMemberID) Then
                  Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
                  If oHTTP Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
                  Else
                     tmpServer = "http://" + reqSysServerName + reqSysServerPath
                     oHTTP.open "GET", tmpServer + "0438.asp" & "?MemberID=" & .MemberID & "&Notify=" & 4 & "&ID=" & .GoalID
                     oHTTP.send
                  End If
                  Set oHTTP = Nothing
               End If
            End If
         End With
      End If
      Set oGoal = Nothing
   End If

   Response.Redirect "7003.asp" & "?GoalID=" & reqGoalID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqUpdateGoalID > 0) Then
         UpdateGoal
      End If
      LoadGoal

   Case CLng(cActionUpdate):

      Response.Redirect "7004.asp" & "?GoalID=" & reqGoalID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup & "&ReturnURL=" & reqPageURL

   Case CLng(cActionCancel):
      If (xmlError = "") Then
         ReturnGoal -1, -1
      End If

   Case CLng(cActionTask):

      Response.Redirect "7002.asp" & "?MemberID=" & reqMemberID & "&ProspectID=" & reqProspectID & "&ParentID=" & reqGoalID & "&ReturnURL=" & reqPageURL
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
xmlParam = xmlParam + " goalid=" + Chr(34) + CStr(reqGoalID) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " updategoalid=" + Chr(34) + CStr(reqUpdateGoalID) + Chr(34)
xmlParam = xmlParam + " cleargoal=" + Chr(34) + CStr(reqClearGoal) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlNote
xmlTransaction = xmlTransaction +  xmlGoal
xmlTransaction = xmlTransaction +  xmlGoals
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Goal[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Goal[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "7003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "7003 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "7003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "7003.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "7003 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "7003 Load file (oData) failed with error code " + CStr(oData.parseError)
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
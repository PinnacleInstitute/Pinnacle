<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
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
Dim oProject, xmlProject
Dim oProjects, xmlProjects
Dim oTasks, xmlTasks
Dim oAttachments, xmlAttachments
Dim oTask, xmlTask
'-----declare page parameters
Dim reqProjectID
Dim reqProjectCount
Dim reqTaskCount
Dim reqAttachmentCount
Dim reqTitle
Dim reqParentTitle
Dim reqParentID
Dim reqProjectMemberID
Dim reqVarCost
Dim reqUpdateTaskID
Dim reqClearTask
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
   SetCache "7503URL", reqReturnURL
   SetCache "7503DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "7503")
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
reqProjectID =  Numeric(GetInput("ProjectID", reqPageData))
reqProjectCount =  Numeric(GetInput("ProjectCount", reqPageData))
reqTaskCount =  Numeric(GetInput("TaskCount", reqPageData))
reqAttachmentCount =  Numeric(GetInput("AttachmentCount", reqPageData))
reqTitle =  GetInput("Title", reqPageData)
reqParentTitle =  GetInput("ParentTitle", reqPageData)
reqParentID =  Numeric(GetInput("ParentID", reqPageData))
reqProjectMemberID =  Numeric(GetInput("ProjectMemberID", reqPageData))
reqVarCost =  Numeric(GetInput("VarCost", reqPageData))
reqUpdateTaskID =  Numeric(GetInput("UpdateTaskID", reqPageData))
reqClearTask =  Numeric(GetInput("ClearTask", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
tmpMemberID = 0
tmpCompanyID = 0
tmpForumID = 0
tmpIsForum = 0
tmpIsChat = 0
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 61
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

Sub LoadProject()
   On Error Resume Next

   Set oProject = server.CreateObject("ptsProjectUser.CProject")
   If oProject Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProject"
   Else
      With oProject
         .SysCurrentLanguage = reqSysLanguage
         If (reqUpdateTaskID <> 0) Then
            Result = CLng(.Change(CLng(reqProjectID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         .Load CLng(reqProjectID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqTitle = .ProjectName
         reqParentID = .ParentID
         reqVarCost = CCUR(.VarCost)
         tmpMemberID = .MemberID
         tmpCompanyID = .CompanyID
         tmpForumID = .ForumID
         tmpIsForum = .IsForum
         tmpIsChat = .IsChat
         xmlProject = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProject = Nothing

   If (reqParentID <> 0) Then
      Set oProject = server.CreateObject("ptsProjectUser.CProject")
      If oProject Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProject"
      Else
         With oProject
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqParentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqProjectMemberID = .MemberID
            reqParentTitle = .ProjectName
         End With
      End If
      Set oProject = Nothing
   End If
   tmpMentoringID = GetCache("MENTORINGID")
   If (tmpMentoringID = "") Then
      tmpMentoringID = -1
   End If

   If (reqSysUserGroup = 41) And (CLng(tmpMemberID) <> reqSysMemberID) And (CLng(tmpMemberID) <> CLng(tmpMentoringID)) And (reqProjectMemberID <> reqSysMemberID) And (reqProjectMemberID <> CLng(tmpMentoringID)) Then
      Set oProject = server.CreateObject("ptsProjectUser.CProject")
      If oProject Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProject"
      Else
         With oProject
            .SysCurrentLanguage = reqSysLanguage
            If (tmpMentoringID > -1) Then
               Result = CLng(.Access(CLng(reqProjectID), CLng(tmpMentoringID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (Result = 0) Then
               Result = CLng(.Access(CLng(reqProjectID), CLng(reqSysMemberID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (Result = 0) Then

               Response.Redirect "0101.asp" & "?ActionCode=" & 9
            End If
         End With
      End If
      Set oProject = Nothing
   End If

   If (reqProjectID <> 0) Then
      Set oProjects = server.CreateObject("ptsProjectUser.CProjects")
      If oProjects Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProjects"
      Else
         With oProjects
            .SysCurrentLanguage = reqSysLanguage
            .ListParent CLng(reqProjectID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlProjects = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqProjectCount = CLng(.Count(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProjects = Nothing
   End If

   Set oTasks = server.CreateObject("ptsTaskUser.CTasks")
   If oTasks Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsTaskUser.CTasks"
   Else
      With oTasks
         .SysCurrentLanguage = reqSysLanguage
         .ListProject CLng(reqProjectID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlTasks = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqTaskCount = CLng(.Count(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oTasks = Nothing

   Set oAttachments = server.CreateObject("ptsAttachmentUser.CAttachments")
   If oAttachments Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAttachmentUser.CAttachments"
   Else
      With oAttachments
         .SysCurrentLanguage = reqSysLanguage
         .ListAttachments CLng(reqProjectID), 75, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqAttachmentCount = CLng(.Count(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlAttachments = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAttachments = Nothing
End Sub

Function ReturnProject(prmParentID, prmMemberID)
   On Error Resume Next

   If (prmParentID = -1) Or (prmMemberID = -1) Then
      Set oProject = server.CreateObject("ptsProjectUser.CProject")
      If oProject Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProject"
      Else
         With oProject
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqProjectID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            prmParentID = .ParentID
         End With
      End If
      Set oProject = Nothing
   End If

   If (prmParentID = 0) Then
      Response.Redirect "7501.asp" & "?ContentPage=" & reqContentPage & "&Popup=" & reqPopup
   End If

   If (prmParentID <> 0) Then
      Response.Redirect "7503.asp" & "?ProjectID=" & prmParentID & "&ContentPage=" & reqContentPage & "&ReturnURL=" & reqPageURL
   End If
End Function

Sub UpdateTask()
   On Error Resume Next

   If (reqUpdateTaskID > 0) Then
      Set oTask = server.CreateObject("ptsTaskUser.CTask")
      If oTask Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsTaskUser.CTask"
      Else
         With oTask
            .SysCurrentLanguage = reqSysLanguage
            .Load reqUpdateTaskID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpProjectID = .ProjectID
            If (reqClearTask = 0) Then
               If (.Status = 1) Then
                  .Status = 2
                  .ActEndDate = reqSysDate
               End If
               If (.Status = 0) Then
                  .Status = 1
                  .ActStartDate = reqSysDate
               End If
            End If
            If (reqClearTask <> 0) Then
               .Status = 0
               .ActStartDate = ""
               .ActEndDate = ""
            End If
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oTask = Nothing
   End If

   Set oProject = server.CreateObject("ptsProjectUser.CProject")
   If oProject Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProject"
   Else
      With oProject
         .SysCurrentLanguage = reqSysLanguage
         Result = CLng(.Change(tmpProjectID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProject = Nothing

   Response.Redirect "7503.asp" & "?ProjectID=" & reqProjectID
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqUpdateTaskID > 0) Then
         UpdateTask
      End If
      LoadProject

   Case CLng(cActionUpdate):

      Response.Redirect "7504.asp" & "?ProjectID=" & reqProjectID & "&ReturnURL=" & reqPageURL

   Case CLng(cActionCancel):
      If (xmlError = "") Then
         ReturnProject -1, -1
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
xmlParam = xmlParam + " projectid=" + Chr(34) + CStr(reqProjectID) + Chr(34)
xmlParam = xmlParam + " projectcount=" + Chr(34) + CStr(reqProjectCount) + Chr(34)
xmlParam = xmlParam + " taskcount=" + Chr(34) + CStr(reqTaskCount) + Chr(34)
xmlParam = xmlParam + " attachmentcount=" + Chr(34) + CStr(reqAttachmentCount) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " parenttitle=" + Chr(34) + CleanXML(reqParentTitle) + Chr(34)
xmlParam = xmlParam + " parentid=" + Chr(34) + CStr(reqParentID) + Chr(34)
xmlParam = xmlParam + " projectmemberid=" + Chr(34) + CStr(reqProjectMemberID) + Chr(34)
xmlParam = xmlParam + " varcost=" + Chr(34) + CStr(reqVarCost) + Chr(34)
xmlParam = xmlParam + " updatetaskid=" + Chr(34) + CStr(reqUpdateTaskID) + Chr(34)
xmlParam = xmlParam + " cleartask=" + Chr(34) + CStr(reqClearTask) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlProject
xmlTransaction = xmlTransaction +  xmlProjects
xmlTransaction = xmlTransaction +  xmlTasks
xmlTransaction = xmlTransaction +  xmlAttachments
xmlTransaction = xmlTransaction +  xmlTask
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Project[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Project[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "7503 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "7503 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "7503 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the menu Definitions
s = "<MENU name=""ProjectMenu"" type=""bar"" menuwidth=""125"">"
s=s+   "<ITEM label=""New"">"
s=s+      "<IMAGE name=""New.gif""/>"
s=s+      "<ITEM label=""NewTask"">"
s=s+         "<LINK name=""7402"" nodata=""true"">"
s=s+            "<PARAM name=""ProjectID"" value=""" & reqProjectID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & tmpMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""NewAttachment"">"
s=s+         "<LINK name=""8002"" nodata=""true"">"
s=s+            "<PARAM name=""ParentID"" value=""" & reqProjectID & """/>"
s=s+            "<PARAM name=""ParentType"" value=""" & 75 & """/>"
s=s+            "<PARAM name=""Mini"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         If (reqParentID = 0) Then
s=s+      "<ITEM label=""NewPhase"">"
s=s+         "<LINK name=""7502"" nodata=""true"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & tmpCompanyID & """/>"
s=s+            "<PARAM name=""ParentID"" value=""" & reqProjectID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & tmpMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
         If (reqParentID <> 0) Then
s=s+      "<ITEM label=""NewSubPhase"">"
s=s+         "<LINK name=""7502"" nodata=""true"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & tmpCompanyID & """/>"
s=s+            "<PARAM name=""ParentID"" value=""" & reqProjectID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & tmpMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Tools"">"
s=s+      "<IMAGE name=""Tools.gif""/>"
         If (tmpIsForum <> 0) Then
s=s+      "<ITEM label=""Forum"">"
s=s+         "<LINK name=""8411"" target=""blank"" nodata=""true"">"
s=s+            "<PARAM name=""ForumID"" value=""" & tmpForumID & """/>"
s=s+            "<PARAM name=""IsChat"" value=""" & tmpIsChat & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
         If (tmpIsChat <> 0) Then
s=s+      "<ITEM label=""ConferenceRoom"">"
s=s+         "<LINK name=""8420"" target=""blank"" nodata=""true"">"
s=s+            "<PARAM name=""ForumID"" value=""" & tmpForumID & """/>"
s=s+            "<PARAM name=""IsForum"" value=""" & tmpIsForum & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+      "<ITEM label=""Members"">"
s=s+         "<LINK name=""7611"" target=""blank"" nodata=""true"">"
s=s+            "<PARAM name=""ProjectID"" value=""" & reqProjectID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & tmpCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & tmpMemberID & """/>"
s=s+            "<PARAM name=""ParentID"" value=""" & reqParentID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Help"">"
s=s+         "<LINK name=""Page"" target=""help"" nodata=""true"">"
s=s+            "<PARAM name=""Page"" value=""HelpPCSUser""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Reports"">"
s=s+      "<IMAGE name=""Report.gif""/>"
s=s+      "<ITEM label=""WhatsNew"">"
s=s+         "<LINK name=""7524"" nodata=""true"" target=""WhatsNew"">"
s=s+            "<PARAM name=""ProjectID"" value=""" & reqProjectID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Tasks"">"
s=s+         "<LINK name=""7426"" nodata=""true"" target=""Tasks"">"
s=s+            "<PARAM name=""ProjectID"" value=""" & reqProjectID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Notes"">"
s=s+         "<LINK name=""7526"" target=""Notes"">"
s=s+            "<PARAM name=""ProjectID"" value=""" & reqProjectID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+"</MENU>"
xmlProjectMenu = s

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
xmlData = xmlData +  xmlProjectMenu
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "7503.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "7503 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "7503 Load file (oData) failed with error code " + CStr(oData.parseError)
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
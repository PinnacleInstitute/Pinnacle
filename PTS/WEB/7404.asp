<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionDelete = 4
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
Dim oTask, xmlTask
Dim oProject, xmlProject
Dim oProjectMembers, xmlProjectMembers
'-----declare page parameters
Dim reqTaskID
Dim reqProjectMemberID
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
   SetCache "7404URL", reqReturnURL
   SetCache "7404DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "7404")
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
reqTaskID =  Numeric(GetInput("TaskID", reqPageData))
reqProjectMemberID =  Numeric(GetInput("ProjectMemberID", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
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

Function AddNote(prmNotes)
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
         .OwnerType = 74
         .OwnerID = reqTaskID
         .IsLocked = 1
         .Notes = prmNotes
         NoteID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oNote = Nothing
End Function

Sub LoadTask()
   On Error Resume Next

   Set oTask = server.CreateObject("ptsTaskUser.CTask")
   If oTask Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsTaskUser.CTask"
   Else
      With oTask
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqTaskID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpProjectID = .ProjectID
         tmpMemberID = .MemberID
         xmlTask = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oTask = Nothing
   tmpMentoringID = GetCache("MENTORINGID")
   If (tmpMentoringID = "") Then
      tmpMentoringID = -1
   End If

   If (reqSysUserGroup = 41) And (CLng(tmpMemberID) <> reqSysMemberID) And (CLng(tmpMemberID) <> CLng(tmpMentoringID)) Then
      Set oProject = server.CreateObject("ptsProjectUser.CProject")
      If oProject Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProject"
      Else
         With oProject
            .SysCurrentLanguage = reqSysLanguage
            If (tmpMentoringID > 0) Then
               Result = CLng(.Access(CLng(tmpProjectID), CLng(tmpMentoringID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (Result = 0) Then
               Result = CLng(.Access(CLng(tmpProjectID), CLng(reqSysMemberID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (Result = 0) Then

               Response.Redirect "0101.asp" & "?ActionCode=" & 9
            End If
         End With
      End If
      Set oProject = Nothing
   End If

   Set oProjectMembers = server.CreateObject("ptsProjectMemberUser.CProjectMembers")
   If oProjectMembers Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectMemberUser.CProjectMembers"
   Else
      With oProjectMembers
         .SysCurrentLanguage = reqSysLanguage
         xmlProjectMembers = xmlProjectMembers + .EnumMember(tmpProjectID, tmpMemberID, , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProjectMembers = Nothing
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadTask

   Case CLng(cActionUpdate):
      tmpStatusChange = 0

      Set oTask = server.CreateObject("ptsTaskUser.CTask")
      If oTask Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsTaskUser.CTask"
      Else
         With oTask
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqTaskID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpProjectID = .ProjectID
            tmpEstStartDate = .EstStartDate
            tmpEstEndDate = .EstEndDate
            tmpEstCost = .EstCost
            tmpCost = .Cost
            tmpHrs = .Hrs
            tmpStatus = .Status

            .ParentID = Request.Form.Item("ParentID")
            .ProjectID = Request.Form.Item("ProjectID")
            .DependentID = Request.Form.Item("DependentID")
            .Status = Request.Form.Item("Status")
            .TaskName = Request.Form.Item("TaskName")
            .MemberID = Request.Form.Item("MemberID")
            .Seq = Request.Form.Item("Seq")
            .IsMilestone = Request.Form.Item("IsMilestone")
            .Description = Request.Form.Item("Description")
            .EstStartDate = Request.Form.Item("EstStartDate")
            .EstEndDate = Request.Form.Item("EstEndDate")
            .EstCost = Request.Form.Item("EstCost")
            .ActStartDate = Request.Form.Item("ActStartDate")
            .ActEndDate = Request.Form.Item("ActEndDate")
            .Cost = Request.Form.Item("Cost")
            .Hrs = Request.Form.Item("Hrs")
            
            If .Status < 3 Then
               .Status = 0
               If IsDate(.ActEndDate) Then
                  .Status = 2
               Else   
                  If IsDate(.ActStartDate) Then .Status = 1
               End If
            End If
            If tmpStatus <> .Status Then tmpStatusChange = 1
            .VarStartDate = ""
            .VarEndDate = ""
            If IsDate(.EstStartDate) AND IsDate(.ActStartDate) Then .VarStartDate = DATEDIFF("d", .EstStartDate, .ActStartDate)
            If IsDate(.EstEndDate) AND IsDate(.ActEndDate) Then .VarEndDate = DATEDIFF("d", .EstEndDate, .ActEndDate)

            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (xmlError = "") Then
               If (tmpEstStartDate <> "0") And (tmpEstStartDate <> .EstStartDate) Then
                  AddNote("Projected Start Date Changed from " + tmpEstStartDate + " to " + .EstStartDate)
               End If
               If (tmpEstEndDate <> "0") And (tmpEstEndDate <> .EstEndDate) Then
                  AddNote("Projected End Date Changed from " + tmpEstEndDate + " to " + .EstEndDate)
               End If
               If (tmpEstCost <> "$0.00") And (CCUR(tmpEstCost) <> CCUR(.EstCost)) Then
                  AddNote("Projected Cost Changed from " + tmpEstCost + " to " + .EstCost)
               End If
               If (CCUR(tmpCost) <> CCUR(.Cost)) Or (CCUR(tmpEstCost) <> CCUR(.EstCost)) Or (CCUR(tmpHrs) <> CCUR(.Hrs)) Then
                  Result = CLng(.ComputeTotalCost(CLng(reqTaskID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            If (xmlError <> "") Then
               LoadTask
            End If
         End With
      End If
      Set oTask = Nothing

      If (tmpStatusChange <> 0) Then
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
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("7404URL")
         reqReturnData = GetCache("7404DATA")
         SetCache "7404URL", ""
         SetCache "7404DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("7404URL")
      reqReturnData = GetCache("7404DATA")
      SetCache "7404URL", ""
      SetCache "7404DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oTask = server.CreateObject("ptsTaskUser.CTask")
      If oTask Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsTaskUser.CTask"
      Else
         With oTask
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqTaskID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpProjectID = .ProjectID
            tmpParentID = .ParentID
            .Delete CLng(reqTaskID), CLng(.ProjectID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (tmpParentID <> 0) Then
               Result = CLng(.ComputeTotalCost(tmpParentID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (xmlError <> "") Then
               LoadTask
            End If
         End With
      End If
      Set oTask = Nothing

      If (tmpParentID = 0) Then
         Set oProject = server.CreateObject("ptsProjectUser.CProject")
         If oProject Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProject"
         Else
            With oProject
               .SysCurrentLanguage = reqSysLanguage
               .Load tmpProjectID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               Result = CLng(.ComputeTotalCost(tmpProjectID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oProject = Nothing
      End If
      If (xmlError = "") Then

         If (tmpParentID = 0) Then
            Response.Redirect "7503.asp" & "?ProjectID=" & tmpProjectID & "&ReturnURL=" & reqPageURL
         End If

         If (tmpParentID <> 0) Then
            Response.Redirect "7403.asp" & "?TaskID=" & tmpParentID & "&ReturnURL=" & reqPageURL
         End If
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
xmlParam = xmlParam + " taskid=" + Chr(34) + CStr(reqTaskID) + Chr(34)
xmlParam = xmlParam + " projectmemberid=" + Chr(34) + CStr(reqProjectMemberID) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlNote
xmlTransaction = xmlTransaction +  xmlTask
xmlTransaction = xmlTransaction +  xmlProject
xmlTransaction = xmlTransaction +  xmlProjectMembers
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Task[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Task[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "7404 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "7404 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "7404 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "7404.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "7404 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "7404 Load file (oData) failed with error code " + CStr(oData.parseError)
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
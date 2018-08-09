<!--#include file="Include\System.asp"-->
<!--#include file="Include\InputOptions.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionCategory = 5
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
Dim oIssueCategorys, xmlIssueCategorys
Dim oIssue, xmlIssue
Dim oIssueCategory, xmlIssueCategory
'-----declare page parameters
Dim reqCompanyID
Dim reqUserName
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
   SetCache "9502URL", reqReturnURL
   SetCache "9502DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "9502")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqUserName =  GetInput("UserName", reqPageData)
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 52
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

Sub LoadList()
   On Error Resume Next

   Set oIssueCategorys = server.CreateObject("ptsIssueCategoryUser.CIssueCategorys")
   If oIssueCategorys Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsIssueCategoryUser.CIssueCategorys"
   Else
      With oIssueCategorys
         .SysCurrentLanguage = reqSysLanguage
         If (reqSysUserGroup = 99) Then
            xmlIssueCategorys = .EnumList(CLng(reqCompanyID), 1)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqSysUserGroup = 41) Then
            xmlIssueCategorys = .EnumList(CLng(reqCompanyID), 3)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
            xmlIssueCategorys = .EnumList(CLng(reqCompanyID), 4)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqSysUserGroup <= 23) Then
            xmlIssueCategorys = .EnumList(CLng(reqCompanyID), 5)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
      End With
   End If
   Set oIssueCategorys = Nothing
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oIssue = server.CreateObject("ptsIssueUser.CIssue")
      If oIssue Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsIssueUser.CIssue"
      Else
         With oIssue
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .IssueDate = Now
            .Status = 1
            .Priority = 2
            .SubmittedBy = Left(reqSysUserName,InStr(reqSysUserName," ")-1)
            reqUserName = Left(reqSysUserName,InStr(reqSysUserName," ")-1)
            xmlIssue = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oIssue = Nothing
      LoadList

   Case CLng(cActionCategory):
      tmpIssueCategoryID = Request.Form.Item("IssueCategoryID")

      Set oIssueCategory = server.CreateObject("ptsIssueCategoryUser.CIssueCategory")
      If oIssueCategory Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsIssueCategoryUser.CIssueCategory"
      Else
         With oIssueCategory
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpIssueCategoryID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpInputOptions = .InputOptions
         End With
      End If
      Set oIssueCategory = Nothing

      Set oIssue = server.CreateObject("ptsIssueUser.CIssue")
      If oIssue Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsIssueUser.CIssue"
      Else
         With oIssue
            .SysCurrentLanguage = reqSysLanguage

            .IssueDate = Request.Form.Item("IssueDate")
            .IssueCategoryID = Request.Form.Item("IssueCategoryID")
            .IssueName = Request.Form.Item("IssueName")
            .SubmittedBy = Request.Form.Item("SubmittedBy")
            .Priority = Request.Form.Item("Priority")
            .Description = Request.Form.Item("Description")
            .AssignedTo = Request.Form.Item("AssignedTo")
            .Status = Request.Form.Item("Status")
            .DueDate = Request.Form.Item("DueDate")
            .DoneDate = Request.Form.Item("DoneDate")
            .Notes = Request.Form.Item("Notes")
            .InputOptions = tmpInputOptions
            xmlIssue = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oIssue = Nothing
      LoadList

   Case CLng(cActionAdd):
      tmpIssueCategoryID = Request.Form.Item("IssueCategoryID")
      tmpAssignedTo = Request.Form.Item("AssignedTo")

      If (tmpIssueCategoryID <> 0) Then
         Set oIssueCategory = server.CreateObject("ptsIssueCategoryUser.CIssueCategory")
         If oIssueCategory Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsIssueCategoryUser.CIssueCategory"
         Else
            With oIssueCategory
               .SysCurrentLanguage = reqSysLanguage
               .Load tmpIssueCategoryID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpAssignedTo = .AssignedTo
               tmpInputOptions = .InputOptions
               tmpCC = .Email
            End With
         End If
         Set oIssueCategory = Nothing
      End If

      Set oIssue = server.CreateObject("ptsIssueUser.CIssue")
      If oIssue Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsIssueUser.CIssue"
      Else
         With oIssue
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .CompanyID = reqCompanyID
            .ChangeDate = Now

            .IssueDate = Request.Form.Item("IssueDate")
            .IssueCategoryID = Request.Form.Item("IssueCategoryID")
            .IssueName = Request.Form.Item("IssueName")
            .SubmittedBy = Request.Form.Item("SubmittedBy")
            .Priority = Request.Form.Item("Priority")
            .Description = Request.Form.Item("Description")
            .AssignedTo = Request.Form.Item("AssignedTo")
            .Status = Request.Form.Item("Status")
            .DueDate = Request.Form.Item("DueDate")
            .DoneDate = Request.Form.Item("DoneDate")
            .Notes = Request.Form.Item("Notes")
            
            If .AssignedTo = "" Then .AssignedTo = tmpAssignedTo
            If .Status = "" Then .Status = 0
            If .Status <= 1 and .AssignedTo <> "" Then .Status = 2
            If .Status >= 3 Then 
               .DoneDate = Date()
               If IsDate(.DueDate) Then .Variance = DATEDIFF("d", .DueDate, .DoneDate)
            End If

            .InputValues = DoInputOptions( tmpInputOptions, .InputValues, tmpPrice, 23)
            .IssueName = ValidXML(.IssueName)
            .Description = ValidXML(.Description)
            If (xmlError = "") Then
               IssueID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            
  'Get Info for email
  If xmlError = "" Then
  Select Case .Status
  Case 2: tmpSubject = "NEW"
  Case 3: tmpSubject = "INPROCESS"
  Case 4: tmpSubject = "RESOLVED"
  Case 5: tmpSubject = "POSTPONED"
  Case 6: tmpSubject = "CONFIRMED"
  Case 7: tmpSubject = "COMPLETED"
  End Select
  tmpSubject = tmpSubject + " ISSUE #" + CStr(IssueID) + " " + .IssueName
  If .Priority = 1 Then tmpSubject = tmpSubject + " (HIGH PRIORITY)"
  If .DueDate <> "0" Then tmpSubject = tmpSubject + " (DUE: " + .DueDate + ")"
            tmpBody = .Description

            'Email newly assigned employee
            If .Status = 2 AND .AssignedTo <> "" Then
               tmpToName = .AssignedTo
               tmpFromName = .SubmittedBy
            End If

            If .Status >= 3 Then 
               tmpToName = .SubmittedBy
               tmpFromName = .AssignedTo
               tmpBody = tmpBody + "<BR>--------------------------------------------------<BR>" + Replace(.Notes, Chr(13), "<BR>")
            End If
         End If

            If (xmlError <> "") Then
               xmlIssue = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oIssue = Nothing
      If (xmlError <> "") Then
         LoadList
      End If
      If (xmlError = "") And (tmpToName <> "") Then

         If (reqCompanyID = 0) Then
            Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
            If oBusiness Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
            Else
               With oBusiness
                  .SysCurrentLanguage = reqSysLanguage
                  .Load 1, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  tmpSender = .SystemEmail
                  tmpFrom = .SystemEmail
               End With
            End If
            Set oBusiness = Nothing
         End If

         If (reqCompanyID <> 0) Then
            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  .Load CLng(reqCompanyID), CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  tmpSender = .Email
                  tmpFrom = .Email
               End With
            End If
            Set oCompany = Nothing
         End If

         If (reqCompanyID = 0) Then
            Set oEmployee = server.CreateObject("ptsEmployeeUser.CEmployee")
            If oEmployee Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmployeeUser.CEmployee"
            Else
               With oEmployee
                  .SysCurrentLanguage = reqSysLanguage
                  tmpTo = .GetEmail(tmpToName)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oEmployee = Nothing
         End If

         If (reqCompanyID <> 0) Then
            Set oOrg = server.CreateObject("ptsOrgUser.COrg")
            If oOrg Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsOrgUser.COrg"
            Else
               With oOrg
                  .SysCurrentLanguage = reqSysLanguage
                  tmpTo = .GetEmail(CLng(reqCompanyID), tmpToName)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oOrg = Nothing
         End If
         
               If InStr(tmpTo, "@") > 0 Then
                 SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, tmpCC, "", tmpSubject, tmpBody
          End If

      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("9502URL")
         reqReturnData = GetCache("9502DATA")
         SetCache "9502URL", ""
         SetCache "9502DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("9502URL")
      reqReturnData = GetCache("9502DATA")
      SetCache "9502URL", ""
      SetCache "9502DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " username=" + Chr(34) + CleanXML(reqUserName) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlIssueCategorys
xmlTransaction = xmlTransaction +  xmlIssue
xmlTransaction = xmlTransaction +  xmlIssueCategory
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Issue[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Issue[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "9502 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "9502 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "9502 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "9502.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "9502 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "9502 Load file (oData) failed with error code " + CStr(oData.parseError)
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
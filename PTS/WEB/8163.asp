<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdateExit = 1
Const cActionUpdate = 7
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionMove = 5
Const cActionMoveGo = 6
Const cActionPresent = 9
Const cActionLead = 8
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
Dim oProspect, xmlProspect
Dim oMember, xmlMember
Dim oLeadCampaign, xmlLeadCampaign
'-----declare page parameters
Dim reqProspectID
Dim reqCompanyID
Dim reqMemberID
Dim reqGroupID
Dim reqMove
Dim reqIsMail
Dim reqLeadName
Dim reqPresentName
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
   SetCache "8163URL", reqReturnURL
   SetCache "8163DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "8163")
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
reqProspectID =  Numeric(GetInput("ProspectID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqMove =  Numeric(GetInput("Move", reqPageData))
reqIsMail =  Numeric(GetInput("IsMail", reqPageData))
reqLeadName =  GetInput("LeadName", reqPageData)
reqPresentName =  GetInput("PresentName", reqPageData)
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

Sub LoadProspect()
   On Error Resume Next

   Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
   If oProspect Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
   Else
      With oProspect
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProspectID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqMemberID = .MemberID
         tmpLeadCampaignID = .LeadCampaignID
         tmpPresentID = .PresentID
         If (InStr(.Email, "@") = 0) Then
            reqIsMail = 0
         End If
         If (InStr(.Email, "@") <> 0) Then
            reqIsMail = 1
         End If
         xmlProspect = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProspect = Nothing
   reqCompanyID = reqSysCompanyID

   If (reqCompanyID = 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCompanyID = .CompanyID
            reqGroupID = .GroupID
         End With
      End If
      Set oMember = Nothing
   End If

   If (tmpLeadCampaignID <> 0) And (InStr(reqSysUserOptions,"Z") <> 0) Or (reqSysUserGroup <= 23) Then
      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpLeadCampaignID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqLeadName = .LeadCampaignName
         End With
      End If
      Set oLeadCampaign = Nothing
   End If

   If (tmpPresentID <> 0) And (InStr(reqSysUserOptions,"z") <> 0) Or (reqSysUserGroup <= 23) Then
      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpPresentID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPresentName = .LeadCampaignName
         End With
      End If
      Set oLeadCampaign = Nothing
   End If
End Sub

Sub UpdateProspect()
   On Error Resume Next

   Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
   If oProspect Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
   Else
      With oProspect
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProspectID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqMemberID = .MemberID
         OldStatus = CLng(.Status)

         .Code = Request.Form.Item("Code")
         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .Status = Request.Form.Item("Status")
         .Priority = Request.Form.Item("Priority")
         .Email = Request.Form.Item("Email")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
         .TimeZone = Request.Form.Item("TimeZone")
         .BestTime = Request.Form.Item("BestTime")
         .NextDate = Request.Form.Item("NextDate")
         .NextTime = Request.Form.Item("NextTime")
         .Description = Request.Form.Item("Description")
         .Street = Request.Form.Item("Street")
         .Unit = Request.Form.Item("Unit")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .Country = Request.Form.Item("Country")
         .Source = Request.Form.Item("Source")
         .CreateDate = Request.Form.Item("CreateDate")
         .Representing = Request.Form.Item("Representing")
         .EmailStatus = Request.Form.Item("EmailStatus")
         .DistributorID = Request.Form.Item("DistributorID")
         .DistributeDate = Request.Form.Item("DistributeDate")
         NewStatus = CLng(.Status)
         .ProspectName = .NameFirst + " " + .NameLast
         If (reqMove <> 0) Then
            .Status = 1
         End If
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (reqSysUserGroup = 41) And (InStr(reqSysUserOptions,"l") <> 0) And (NewStatus < OldStatus) Then
            AutoAddNote = .NameFirst + " " + .NameLast
            AutoEvent = 0
            If (NewStatus = -6) Then
               AutoEvent = 1
            End If
            If (NewStatus = -7) Then
               AutoEvent = 2
            End If
            If (NewStatus = -8) Then
               AutoEvent = 3
            End If
            If (AutoEvent <> 0) Then

               Set oMetric = server.CreateObject("ptsMetricUser.CMetric")
               If oMetric Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetric"
               Else
                  With oMetric
                     .SysCurrentLanguage = reqSysLanguage
                     Result = CLng(.AutoAdd(CLng(reqMemberID), AutoEvent, AutoAddNote))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oMetric = Nothing
            End If
         End If
      End With
   End If
   Set oProspect = Nothing
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadProspect

   Case CLng(cActionUpdateExit):
      UpdateProspect
      If (xmlError <> "") Then
         LoadProspect
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("8163URL")
         reqReturnData = GetCache("8163DATA")
         SetCache "8163URL", ""
         SetCache "8163DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionUpdate):
      UpdateProspect
      LoadProspect

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("8163URL")
      reqReturnData = GetCache("8163DATA")
      SetCache "8163URL", ""
      SetCache "8163DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqProspectID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProspect = Nothing
      If (xmlError <> "") Then
         LoadProspect
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("8163URL")
         reqReturnData = GetCache("8163DATA")
         SetCache "8163URL", ""
         SetCache "8163DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionMove):
      reqMove = 1
      UpdateProspect

      If (xmlError = "") Then
         reqReturnURL = GetCache("8163URL")
         reqReturnData = GetCache("8163DATA")
         SetCache "8163URL", ""
         SetCache "8163DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionMoveGo):
      reqMove = 1
      UpdateProspect

      If (xmlError = "") Then
         Response.Redirect "8103.asp" & "?ProspectID=" & reqProspectID & "&ContentPage=" & 3 & "&Popup=" & 1
      End If

   Case CLng(cActionPresent):
      UpdateProspect
      tmpCompanyID = Request.Form.Item("CompanyID")
      tmpMemberID = Request.Form.Item("MemberID")

      Response.Redirect "8112.asp" & "?ProspectID=" & reqProspectID & "&CompanyID=" & tmpCompanyID & "&MemberID=" & tmpMemberID & "&Entity=" & 22 & "&ReturnURL=" & reqPageURL

   Case CLng(cActionLead):
      UpdateProspect
      tmpCompanyID = Request.Form.Item("CompanyID")
      tmpMemberID = Request.Form.Item("MemberID")

      Response.Redirect "8111.asp" & "?ProspectID=" & reqProspectID & "&CompanyID=" & tmpCompanyID & "&MemberID=" & tmpMemberID & "&Entity=" & 22 & "&ReturnURL=" & reqPageURL
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
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " move=" + Chr(34) + CStr(reqMove) + Chr(34)
xmlParam = xmlParam + " ismail=" + Chr(34) + CStr(reqIsMail) + Chr(34)
xmlParam = xmlParam + " leadname=" + Chr(34) + CleanXML(reqLeadName) + Chr(34)
xmlParam = xmlParam + " presentname=" + Chr(34) + CleanXML(reqPresentName) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Prospect[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Prospect[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "8163 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "8163 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "8163 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

s = "<TAB name=""ContactTab"">"
s=s+   "<ITEM label=""ViewAddress"" width=""100"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabAddress',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Description"" width=""150"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabDescription',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Notes"" width=""100"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabNotes',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Folders"" width=""100"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabFolders',1))""/>"
s=s+   "</ITEM>"
      If (reqIsMail <> 0) Then
s=s+   "<ITEM label=""Mail"" width=""100"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabMail',1))""/>"
s=s+   "</ITEM>"
      End If
s=s+"</TAB>"
xmlContactTab = s

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
xmlData = xmlData +  xmlContactTab
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "8163.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "8163 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "8163 Load file (oData) failed with error code " + CStr(oData.parseError)
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
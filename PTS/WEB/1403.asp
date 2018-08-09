<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionSettings = 5
Const cActionPromo = 6
Const cActionUploadImage = 7
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
Dim oLeadCampaign, xmlLeadCampaign
Dim oLeadPages, xmlLeadPages
Dim oFolders, xmlFolders
Dim oSalesCampaigns, xmlSalesCampaigns
Dim oProspectTypes, xmlProspectTypes
Dim oNewsLetters, xmlNewsLetters
'-----declare page parameters
Dim reqLeadCampaignID
Dim reqCompanyID
Dim reqGroupID
Dim reqParentType
Dim reqParentID
Dim reqURL
Dim reqImages
Dim reqUploadImageFile
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
   SetCache "1403URL", reqReturnURL
   SetCache "1403DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "1403")
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
reqLeadCampaignID =  Numeric(GetInput("LeadCampaignID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqParentType =  Numeric(GetInput("ParentType", reqPageData))
reqParentID =  Numeric(GetInput("ParentID", reqPageData))
reqURL =  GetInput("URL", reqPageData)
reqImages =  Numeric(GetInput("Images", reqPageData))
reqUploadImageFile =  GetInput("UploadImageFile", reqPageData)
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

Sub LoadLeadCampaign()
   On Error Resume Next

   Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
   If oLeadCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
   Else
      With oLeadCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqLeadCampaignID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         tmpSalesCampaignID = .SalesCampaignID
         tmpProspectTypeID = .ProspectTypeID
         tmpNewsLetterID = .NewsLetterID
         tmpFolderID = .FolderID
         
         reqURL = "http://" + reqSysServerName + reqSysServerPath + "Sections\Company\" + CSTR(reqCompanyID) + "\Lead\Lead"
         filename = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID) + "\Images[" + reqSysLanguage + "].htm"
         If FileExists(filename) Then reqImages = 1

         xmlLeadCampaign = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.GroupID <> 0) Then
            reqParentType = 04
            reqParentID = .GroupID
         End If
         If (.GroupID = 0) Then
            reqParentType = 38
            reqParentID = .CompanyID
         End If
      End With
   End If
   Set oLeadCampaign = Nothing

   Set oLeadPages = server.CreateObject("ptsLeadPageUser.CLeadPages")
   If oLeadPages Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPages"
   Else
      With oLeadPages
         .SysCurrentLanguage = reqSysLanguage
         .List CLng(reqLeadCampaignID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlLeadPages = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadPages = Nothing

   Set oFolders = server.CreateObject("ptsFolderUser.CFolders")
   If oFolders Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsFolderUser.CFolders"
   Else
      With oFolders
         .SysCurrentLanguage = reqSysLanguage
         xmlFolders = xmlFolders + .EnumFolderAll(CLng(reqCompanyID), CLng(reqGroupID), CLng(reqGroupID), 22, tmpFolderID, , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oFolders = Nothing

   Set oSalesCampaigns = server.CreateObject("ptsSalesCampaignUser.CSalesCampaigns")
   If oSalesCampaigns Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesCampaignUser.CSalesCampaigns"
   Else
      With oSalesCampaigns
         .SysCurrentLanguage = reqSysLanguage
         xmlSalesCampaigns = .EnumCompany(CLng(reqCompanyID), CLng(reqGroupID), tmpSalesCampaignID, , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSalesCampaigns = Nothing

   Set oProspectTypes = server.CreateObject("ptsProspectTypeUser.CProspectTypes")
   If oProspectTypes Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectTypeUser.CProspectTypes"
   Else
      With oProspectTypes
         .SysCurrentLanguage = reqSysLanguage
         xmlProspectTypes = .EnumCompany(CLng(reqCompanyID), tmpProspectTypeID, , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProspectTypes = Nothing

   Set oNewsLetters = server.CreateObject("ptsNewsLetterUser.CNewsLetters")
   If oNewsLetters Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsNewsLetterUser.CNewsLetters"
   Else
      With oNewsLetters
         .SysCurrentLanguage = reqSysLanguage
         xmlNewsLetters = .EnumCompany(CLng(reqCompanyID), tmpNewsLetterID, , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oNewsLetters = Nothing
End Sub

Sub UpdateLeadCampaign()
   On Error Resume Next

   Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
   If oLeadCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
   Else
      With oLeadCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqLeadCampaignID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .CompanyID = Request.Form.Item("CompanyID")
         .GroupID = Request.Form.Item("GroupID")
         .LeadCampaignName = Request.Form.Item("LeadCampaignName")
         .Status = Request.Form.Item("Status")
         .PageType = Request.Form.Item("PageType")
         .Seq = Request.Form.Item("Seq")
         .Image = Request.Form.Item("Image")
         .CSS = Request.Form.Item("CSS")
         .NoEdit = Request.Form.Item("NoEdit")
         .Page = Request.Form.Item("Page")
         .IsMember = Request.Form.Item("IsMember")
         .IsAffiliate = Request.Form.Item("IsAffiliate")
         .SalesCampaignID = Request.Form.Item("SalesCampaignID")
         .ProspectTypeID = Request.Form.Item("ProspectTypeID")
         .FolderID = Request.Form.Item("FolderID")
         .NewsLetterID = Request.Form.Item("NewsLetterID")
         .Entity = Request.Form.Item("Entity")
         .Objective = Request.Form.Item("Objective")
         .CycleID = Request.Form.Item("CycleID")
         .Cycle = Request.Form.Item("Cycle")
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadCampaign = Nothing
End Sub

If (reqUploadImageFile <> "") Then

   Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
   If oLeadCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
   Else
      With oLeadCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqLeadCampaignID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Image = reqUploadImageFile
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadCampaign = Nothing
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadLeadCampaign

   Case CLng(cActionUpdate):
      UpdateLeadCampaign
      If (xmlError <> "") Then
         LoadLeadCampaign
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("1403URL")
         reqReturnData = GetCache("1403DATA")
         SetCache "1403URL", ""
         SetCache "1403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      If (reqGroupID = 0) Then
         Response.Redirect "1401.asp" & "?CompanyID=" & reqCompanyID
      End If

      If (reqGroupID <> 0) Then
         reqReturnURL = GetCache("1403URL")
         reqReturnData = GetCache("1403DATA")
         SetCache "1403URL", ""
         SetCache "1403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionDelete):

      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqLeadCampaignID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oLeadCampaign = Nothing
      If (xmlError <> "") Then
         LoadLeadCampaign
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("1403URL")
         reqReturnData = GetCache("1403DATA")
         SetCache "1403URL", ""
         SetCache "1403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionSettings):
      UpdateLeadCampaign
      If (xmlError <> "") Then
         LoadLeadCampaign
      End If

      If (xmlError = "") Then
         Response.Redirect "1404.asp" & "?LeadCampaignID=" & reqLeadCampaignID & "&ReturnURL=" & reqPageURL
      End If

   Case CLng(cActionPromo):
      UpdateLeadCampaign
      If (xmlError <> "") Then
         LoadLeadCampaign
      End If

      If (xmlError = "") Then
         Response.Redirect "1405.asp" & "?CompanyID=" & reqCompanyID & "&LeadCampaignID=" & reqLeadCampaignID & "&ReturnURL=" & reqPageURL
      End If

   Case CLng(cActionUploadImage):
      UpdateLeadCampaign
      If (xmlError = "") Then
         SetCache "LEADCAMPAIGN", reqLeadCampaignID

         Response.Redirect "1422.asp" & "?ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
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
xmlParam = xmlParam + " leadcampaignid=" + Chr(34) + CStr(reqLeadCampaignID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " parenttype=" + Chr(34) + CStr(reqParentType) + Chr(34)
xmlParam = xmlParam + " parentid=" + Chr(34) + CStr(reqParentID) + Chr(34)
xmlParam = xmlParam + " url=" + Chr(34) + CleanXML(reqURL) + Chr(34)
xmlParam = xmlParam + " images=" + Chr(34) + CStr(reqImages) + Chr(34)
xmlParam = xmlParam + " uploadimagefile=" + Chr(34) + CleanXML(reqUploadImageFile) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction +  xmlLeadPages
xmlTransaction = xmlTransaction +  xmlFolders
xmlTransaction = xmlTransaction +  xmlSalesCampaigns
xmlTransaction = xmlTransaction +  xmlProspectTypes
xmlTransaction = xmlTransaction +  xmlNewsLetters
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\LeadCampaign[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\LeadCampaign[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "1403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "1403 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "1403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "1403.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "1403 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "1403 Load file (oData) failed with error code " + CStr(oData.parseError)
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
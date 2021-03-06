<!--#include file="Include\System.asp"-->
<!--#include file="Include\Resources.asp"-->
<!--#include file="Include\Comm.asp"-->
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
Dim oPages, xmlPages
Dim oLeadPage, xmlLeadPage
Dim oMember, xmlMember
Dim oHTMLFile, xmlHTMLFile
Dim oLeadCampaign, xmlLeadCampaign
Dim oCompany, xmlCompany
Dim oProspect, xmlProspect
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqLeadCampaignID
Dim reqLeadPageID
Dim reqAdded
Dim reqSubject
Dim reqMemberEmail
Dim reqTemplateID
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
   SetCache "m_8113URL", reqReturnURL
   SetCache "m_8113DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_8113")
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
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqLeadCampaignID =  Numeric(GetInput("LeadCampaignID", reqPageData))
reqLeadPageID =  Numeric(GetInput("LeadPageID", reqPageData))
reqAdded =  Numeric(GetInput("Added", reqPageData))
reqSubject =  GetInput("Subject", reqPageData)
reqMemberEmail =  GetInput("MemberEmail", reqPageData)
reqTemplateID =  Numeric(GetInput("TemplateID", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
m_CheckSecurity reqSysUserID, reqSysUserGroup, 1, 61, "MobileHome.asp"
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
   tmpGroupID = Numeric(GetCache("GROUPID"))
   If (reqSysUserGroup <> 41) Then
      tmpGroupID = reqMemberID
      GetResources tmpGroupID
   End If
   tmpGroupID1 = 0
   tmpGroupID2 = 0
   tmpGroupID3 = 0
   tmpResource = 10
   If (tmpGroupID <> 0) Then
      GetResource tmpResource, tmpGroupID1, tmpGroupID2, tmpGroupID3
   End If

   Set oPages = server.CreateObject("ptsPageUser.CPages")
   If oPages Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPages"
   Else
      With oPages
         .SysCurrentLanguage = reqSysLanguage
         xmlPages = .EnumPage(CLng(reqCompanyID), tmpGroupID, tmpGroupID1, tmpGroupID2, tmpGroupID3, 3)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPages = Nothing

   If (reqLeadCampaignID <> 0) Then
      Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
      If oLeadPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
      Else
         With oLeadPage
            .SysCurrentLanguage = reqSysLanguage
            .FetchEmail CLng(reqLeadCampaignID), reqSysLanguage
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqLeadPageID = .LeadPageID
            reqSubject = .LeadPageName
         End With
      End If
      Set oLeadPage = Nothing
   End If

   If (reqMemberID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqMemberEmail = .Email
            tmpSignature = .Signature
            tmpMFirstname = .NameFirst
            tmpMLastname = .NameLast
            tmpMEmail = .Email
            tmpMPhone = .Phone1
            tmpMID = .MemberID
            If (reqLeadCampaignID <> 0) Then
               Signature = .GetSignature(CLng(reqMemberID), 5, 0, reqSysLanguage)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (Signature <> "") Then
                  tmpSignature = Signature
               End If
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqLeadPageID <> 0) And (reqTemplateID = 0) Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = "Lead" & reqLeadPageID & ".htm"
            .Path = reqSysWebDirectory + "Sections\Company\" + CSTR(reqCompanyID) + "\Lead\"
            .Language = "en"
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Data = .Data + tmpBody
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing
   End If
   If (reqTemplateID <> 0) Then

      Set oPage = server.CreateObject("ptsPageUser.CPage")
      If oPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPage"
      Else
         With oPage
            .SysCurrentLanguage = reqSysLanguage
            .Load reqTemplateID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqSubject = .Subject
         End With
      End If
      Set oPage = Nothing

      If (reqTemplateID <> 0) Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = reqTemplateID & ".htm"
               .Path = reqSysWebDirectory + "Pages\"
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
   End If
   
         xmlHTMLFile = Replace( xmlHTMLFile, "{signature}", tmpSignature )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-firstname}", tmpMFirstname )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-lastname}", tmpMLastname )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-email}", tmpMEmail )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-phone}", tmpMPhone )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-id}", tmpMID )

End Sub

Sub AddProspect()
   On Error Resume Next
   If (reqLeadCampaignID = 0) Then
      DoError -2147220523, "", "Oops, Please select a Presentation to email to the new prospects."
   End If

   If (xmlError = "") And (reqLeadCampaignID <> 0) Then
      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqLeadCampaignID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpLeadCampaignName = .LeadCampaignName
            tmpNewsLetterID = .NewsLetterID
            tmpSalesCampaignID = .SalesCampaignID
            tmpProspectTypeID = .ProspectTypeID
         End With
      End If
      Set oLeadCampaign = Nothing
   End If

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqCompanyID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpSender = .Email
      End With
   End If
   Set oCompany = Nothing

   If (reqLeadCampaignID <> 0) Then
      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .CompanyID = reqCompanyID
            .MemberID = reqMemberID
            .Status = -1
            .CreateDate = reqSysDate
            .NewsLetterID = tmpNewsLetterID
            .SalesCampaignID = tmpSalesCampaignID
            .PresentID = reqLeadCampaignID
            .ProspectTypeID = tmpProspectTypeID
            .Description = Request.Form.Item("Description")
            
            reqAdded = 0
            tmpFrom = trim(Request.Form.Item("MemberEmail"))
            tmpMasterBody = Request.Form.Item("Data")
            email = trim(Request.Form.Item("Email"))
            If email <> "" And InStr(email, "@") <> 0 Then
               reqAdded = reqAdded + 1
               first = trim(Request.Form.Item("NameFirst"))
               last = trim(Request.Form.Item("NameLast"))
               phone = trim(Request.Form.Item("Phone1"))
               .ProspectName = first + " " + last
               .NameFirst = first
               .NameLast = last
               .Email = email
               .Phone1 = phone
               ProspectID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

               tmpSubject = Replace( reqSubject, "{firstname}", first )
               tmpSubject = Replace( tmpSubject, "{lastname}", last )

               tmpBody = Replace( tmpMasterBody, "{firstname}", first )
               tmpBody = Replace( tmpBody, "{lastname}", last )
               tmpBody = Replace( tmpBody, "{email}", email )
               tmpBody = Replace( tmpBody, "{phone}", phone )
               tmpBody = Replace( tmpBody, "{id}", ProspectID )
               reqLink = "http://" + reqSysServerName + reqSysServerPath + "pp.asp?p=" & reqLeadCampaignID & "&m=" & reqMemberID & "&r=" & ProspectID
               tmpBody = Replace( tmpBody, "{link}", reqLink )

               tmpTo = email
               SendEmail reqSysCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody

               Set oNote = server.CreateObject("ptsNoteUser.CNote")
               If oNote Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
               Else
                  With oNote
                     .SysCurrentLanguage = reqSysLanguage
                     .Load 0, CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     .Notes = "EMAILED Presentation, " + tmpLeadCampaignName + ", to new contact"
                     .AuthUserID = 1
                     .NoteDate = Now
                     .OwnerType = 22
                     .OwnerID = ProspectID
                     NoteID = CLng(.Add(CLng(reqSysUserID)))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oNote = Nothing
            End If

         End With
      End If
      Set oProspect = Nothing
   End If
End Sub

If (reqCompanyID = 0) Then
   reqCompanyID = reqSysCompanyID
End If
If (reqSysUserGroup > 23) And (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadList

   Case CLng(cActionAdd):
      AddProspect
      If (xmlError <> "") Then
         LoadList
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("m_8113URL")
         reqReturnData = GetCache("m_8113DATA")
         SetCache "m_8113URL", ""
         SetCache "m_8113DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("m_8113URL")
      reqReturnData = GetCache("m_8113DATA")
      SetCache "m_8113URL", ""
      SetCache "m_8113DATA", ""
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
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " leadcampaignid=" + Chr(34) + CStr(reqLeadCampaignID) + Chr(34)
xmlParam = xmlParam + " leadpageid=" + Chr(34) + CStr(reqLeadPageID) + Chr(34)
xmlParam = xmlParam + " added=" + Chr(34) + CStr(reqAdded) + Chr(34)
xmlParam = xmlParam + " subject=" + Chr(34) + CleanXML(reqSubject) + Chr(34)
xmlParam = xmlParam + " memberemail=" + Chr(34) + CleanXML(reqMemberEmail) + Chr(34)
xmlParam = xmlParam + " templateid=" + Chr(34) + CStr(reqTemplateID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlPages
xmlTransaction = xmlTransaction +  xmlLeadPage
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\m_8113[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\m_8113[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_8113 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_8113 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_8113 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "m_8113.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_8113 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_8113 Load file (oData) failed with error code " + CStr(oData.parseError)
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
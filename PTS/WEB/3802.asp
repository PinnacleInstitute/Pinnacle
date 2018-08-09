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
Dim oCompany, xmlCompany
'-----declare page parameters
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
   SetCache "3802URL", reqReturnURL
   SetCache "3802DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "3802")
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
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 1
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

Sub LoadCompany()
   On Error Resume Next

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .CompanyName = Request.Form.Item("CompanyName")
         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .Email = Request.Form.Item("Email")
         .Status = Request.Form.Item("Status")
         .CompanyType = Request.Form.Item("CompanyType")
         .EnrollDate = Request.Form.Item("EnrollDate")
         .Street = Request.Form.Item("Street")
         .Unit = Request.Form.Item("Unit")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .Country = Request.Form.Item("Country")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
         .Fax = Request.Form.Item("Fax")
         xmlCompanyID = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCompany = Nothing
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Status = 1
            .Country = "USA"
            .EnrollDate = reqSysDate
            xmlCompany = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCompany = Nothing

   Case CLng(cActionAdd):
      tmpNewLogon = Request.Form.Item("NewLogon")
      tmpNewPassword = Request.Form.Item("NewPassword")
      If (xmlError = "") And (Len(tmpNewLogon) > 0) And (Len(tmpNewLogon) < 3) Then
         DoError 10101, "", "OOops, Your Logon Name must be at least three characters/numbers long."
      End If
      If (xmlError = "") And (Len(tmpNewPassword) > 0) And (Len(tmpNewPassword) < 3) Then
         DoError 10102, "", "Oops, Your Password must be at least three characters/numbers long."
      End If
      If (xmlError = "") And (Len(tmpNewLogon) > 0) Then

         Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
         If oAuthUser Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
         Else
            With oAuthUser
               .SysCurrentLanguage = reqSysLanguage
               IsAvailable = CLng(.IsLogon(tmpNewLogon))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oAuthUser = Nothing
         If (IsAvailable = 0) Then
            DoError -2147220513, "", "Oops, The Logon is not available.  Please select another."
         End If
      End If
      If (xmlError <> "") Then
         LoadCompany
      End If
      If (xmlError = "") Then
         tmpCompanyName = ""
         tmpNameLast = ""
         tmpNameFirst = ""
         tmpStreet = ""
         tmpUnit = ""
         tmpCity = ""
         tmpState = ""
         tmpZip = ""
         tmpCountry = ""
         tmpEmail = ""
         tmpPhone1 = ""
         tmpPhone2 = ""
         tmpMemberID = 0

         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

               .CompanyName = Request.Form.Item("CompanyName")
               .NameFirst = Request.Form.Item("NameFirst")
               .NameLast = Request.Form.Item("NameLast")
               .Email = Request.Form.Item("Email")
               .Status = Request.Form.Item("Status")
               .CompanyType = Request.Form.Item("CompanyType")
               .EnrollDate = Request.Form.Item("EnrollDate")
               .Street = Request.Form.Item("Street")
               .Unit = Request.Form.Item("Unit")
               .City = Request.Form.Item("City")
               .State = Request.Form.Item("State")
               .Zip = Request.Form.Item("Zip")
               .Country = Request.Form.Item("Country")
               .Phone1 = Request.Form.Item("Phone1")
               .Phone2 = Request.Form.Item("Phone2")
               .Fax = Request.Form.Item("Fax")
               .MemberID = reqMemberID
               .CompanyID = 1
               
               If .CompanyName = "" Then .CompanyName = .NameLast + ", " + .NameFirst
               If .Status = "0" Then .Status = 1

               .Validate 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (xmlError = "") Then
                  tmpCompanyID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (xmlError <> "") Then
                  xmlCompany = .XML(2)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (xmlError = "") Then
                  .Load tmpCompanyID, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (xmlError = "") Then
                  tmpCompanyName = .CompanyName
                  tmpStatus = .Status
                  tmpNameLast = .NameLast
                  tmpNameFirst = .NameFirst
                  tmpEmail = .Email
               End If
            End With
         End If
         Set oCompany = Nothing

         If (xmlError = "") Then
            Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
            If oCoption Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
            Else
               With oCoption
                  .SysCurrentLanguage = reqSysLanguage
                  .Load 0, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .CompanyID = tmpCompanyID
                  .Price = 30
                  .Retail = 0
                  .Billing = 3
                  .CommRate = 0
                  .IsSignIn = 1
                  .IsJoinNow = 1
                  .IsNewEmail = 1
                  .BusPrice = 90
                  .BusRetail = 0
                  .BusAcctPrice = 30
                  .BusAcctRetail = 0
                  .BusAccts = 3
                  .IsBusAcct = 0
                  .IsFree = 0
                  .FreeOptions = ""
                  .PaymentOptions = "AB2"
                  .Options = "DGIPRSUVgmopwx"
                  .COptionID = 1
                  .Validate 
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  If (xmlError = "") Then
                     tmpCoptionID = CLng(.Add(CLng(reqSysUserID)))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
               End With
            End If
            Set oCoption = Nothing
         End If

         If (xmlError = "") Then
            Set oOrg = server.CreateObject("ptsOrgUser.COrg")
            If oOrg Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsOrgUser.COrg"
            Else
               With oOrg
                  .SysCurrentLanguage = reqSysLanguage
                  .Load 0, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .ParentID = 0
                  .OrgName = tmpCompanyName
                  .MemberID = 0
                  .CompanyID = tmpCompanyID
                  .Status = tmpStatus
                  .NameLast = tmpNameLast
                  .NameFirst = tmpNameFirst
                  .Email = tmpEmail
                  .NewLogon = tmpNewLogon
                  .NewPassword = tmpNewPassword
                  .IsPublic = 1
                  .IsChat = 1
                  .IsForum = 1
                  .IsSuggestion = 1
                  .IsFavorite = 0
                  .IsCatalog = 1
                  .UserGroup = 51
                  .UserStatus = 1
                  If (xmlError = "") Then
                     tmpOrgID = CLng(.Add(CLng(reqSysUserID)))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (xmlError <> "") Then
                     xmlOrg = .XML(2)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  tmpAuthUser = .AuthUserID
                  If (xmlError = "") Then
                     .Load tmpOrgID, CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     .Level = 1
                     .Hierarchy = tmpOrgID & "/"
                     .Save CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     If (xmlError <> "") Then
                        xmlOrg = .XML(2)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     End If
                  End If
               End With
            End If
            Set oOrg = Nothing
         End If
      End If
      
   If (xmlError = "") Then
   Set oFileSys = server.CreateObject("Scripting.FileSystemObject")
   oFileSys.CreateFolder reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID)
   oFileSys.CreateFolder reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\Lead"
   oFileSys.CreateFolder reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\Mail"
   oFileSys.CreateFolder reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\Msg"
   oFileSys.CreateFolder reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\Newsletter"
   oFileSys.CreateFolder reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID)
   '         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\header[en].gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\header[en].gif"
   '         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\certificateheader.gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\certificateheader.gif"
   '         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\navbarimage.gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\navbarimage.gif"
   '         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\tbimage.gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\tbimage.gif"
   Set oFileSys = Nothing
   End If


      If (xmlError = "") Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = "Member.htm"
               .Path = reqSysWebDirectory + "Sections\Company\"
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
               .Save 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Filename = "NewMember.htm"
               .Path = reqSysWebDirectory + "Sections\Company\"
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
               .Save 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Filename = "MemberNews.htm"
               .Path = reqSysWebDirectory + "Sections\Company\"
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
               .Save 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oHTMLFile = Nothing
      End If

      If (xmlError = "") Then
         Set oPageSection = server.CreateObject("ptsPageSectionUser.CPageSection")
         If oPageSection Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageSectionUser.CPageSection"
         Else
            With oPageSection
               .SysCurrentLanguage = reqSysLanguage
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .CompanyID = tmpCompanyID
               .Language = reqSysLanguage
               .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
               .PageSectionName = "Member"
               .Filename = "Member.htm"
               .Width = 600
               PageSectionID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .PageSectionName = "New Member Email"
               .Filename = "NewMember.htm"
               .Width = 750
               PageSectionID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .PageSectionName = "Member News"
               .Filename = "MemberNews.htm"
               .Width = 750
               PageSectionID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oPageSection = Nothing
      End If
      If (xmlError = "") Then
         If (tmpAuthUser > 0) Then

            Response.Redirect "0105.asp" & "?AuthUserID=" & tmpAuthUser & "&MailReturnURL=" & "3801.asp?CompanyID=" & tmpCompanyID
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("3802URL")
      reqReturnData = GetCache("3802DATA")
      SetCache "3802URL", ""
      SetCache "3802DATA", ""
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
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Company[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Company[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "3802 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "3802 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "3802 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "3802.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "3802 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "3802 Load file (oData) failed with error code " + CStr(oData.parseError)
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
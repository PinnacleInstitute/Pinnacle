<!--#include file="Include\System.asp"-->
<!--#include file="Include\Email.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\GeoCode.asp"-->
<!--#include file="Include\MobileBrowser.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionRefer = 1
Const cActionAdd = 2
Const cActionCancel = 3
Const cActionNotRefer = 4
Const cActionStartStart = 5
Const cActionNewAuto = 6
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
Dim oMerchant, xmlMerchant
Dim oConsumer, xmlConsumer
Dim oMember, xmlMember
Dim oCountrys, xmlCountrys
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqM
Dim reqA
Dim reqS
Dim reqAffiliateID
Dim reqCompanyID
Dim reqReferM
Dim reqReferA
Dim reqReferredBy
Dim reqLogonMerchant
Dim reqLogonConsumer
Dim reqLogonMember
Dim reqDone
Dim reqIsMobilePromo
Dim reqIsShopperOrder
Dim reqRet
Dim reqAdvanced
Dim reqAuto
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
   SetCache "NewShopperURL", reqReturnURL
   SetCache "NewShopperDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "newshopper")
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
reqM =  Numeric(GetInput("M", reqPageData))
reqA =  Numeric(GetInput("A", reqPageData))
reqS =  Numeric(GetInput("S", reqPageData))
reqAffiliateID =  Numeric(GetInput("AffiliateID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqReferM =  Numeric(GetInput("ReferM", reqPageData))
reqReferA =  Numeric(GetInput("ReferA", reqPageData))
reqReferredBy =  GetInput("ReferredBy", reqPageData)
reqLogonMerchant =  GetInput("LogonMerchant", reqPageData)
reqLogonConsumer =  GetInput("LogonConsumer", reqPageData)
reqLogonMember =  GetInput("LogonMember", reqPageData)
reqDone =  Numeric(GetInput("Done", reqPageData))
reqIsMobilePromo =  Numeric(GetInput("IsMobilePromo", reqPageData))
reqIsShopperOrder =  Numeric(GetInput("IsShopperOrder", reqPageData))
reqRet =  Numeric(GetInput("Ret", reqPageData))
reqAdvanced =  Numeric(GetInput("Advanced", reqPageData))
reqAuto =  Numeric(GetInput("Auto", reqPageData))
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

Sub SendWelcomeEmail()
   On Error Resume Next

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
   tmpEmail = Request.Form.Item("Email")
   tmpTo = Request.Form.Item("Email2")
   tmpPhone = Request.Form.Item("Phone")
   tmpPswd = Request.Form.Item("Password")
   
          If InStr(tmpTo, "@") > 0 Then
          If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
          tmpSubject = "Nexxus Rewards"
          tmpBody = "Welcome to www.NexxusRewards.com! Login with your phone number: " + tmpPhone + " or your email: " + tmpEmail + " and your password: " + tmpPswd
          SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, "", tmpEmail, tmpSubject, tmpBody
          End If
        
End Sub

Sub GetReferredBy()
   On Error Resume Next

   If (reqM <> 0) Then
      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            .Load reqM, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = .MerchantName
            
              If InStr(.Options, "E") > 0 Then reqIsShopperOrder = 1
            
         End With
      End If
      Set oMerchant = Nothing
   End If

   If (reqS <> 0) Then
      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            .Load reqS, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = .NameFirst + " " + .NameLast
            reqReferM = .MerchantID
            reqReferA = .MemberID
         End With
      End If
      Set oConsumer = Nothing
   End If

   If (reqA <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqA, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = .NameFirst + " " + .NameLast
         End With
      End If
      Set oMember = Nothing
   End If
   reqReferredBy = Trim(reqReferredBy)
End Sub

Sub GetReferLogon()
   On Error Resume Next
   reqReferredBy = ""

   If (reqLogonMerchant <> "") Then
      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            reqLogonConsumer = ""
            reqLogonMember = ""
            Result = CLng(.Logon2(reqLogonMerchant))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result > 0) Then
               reqM = Result
               .Load reqM, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqReferredBy = .MerchantName
               
                If InStr(.Options, "E") > 0 Then reqIsShopperOrder = 1
              
            End If
            If (Result = -1000002) Then
               DoError 10129, "", "Oops, The Email could not be found."
            End If
            If (Result = -1000003) Then
               DoError 10135, "", "Oops, The Account Number could not be found."
            End If
         End With
      End If
      Set oMerchant = Nothing
   End If

   If (reqLogonConsumer <> "") Then
      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            reqLogonMerchant = ""
            reqLogonMember = ""
            Result = CLng(.Logon2(reqLogonConsumer))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result > 0) Then
               reqS = Result
               .Load reqS, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqReferredBy = .NameFirst + " " + .NameLast
               reqReferM = .MerchantID
               reqReferA = .MemberID
            End If
            If (Result = -1000002) Then
               DoError 10129, "", "Oops, The Email could not be found."
            End If
            If (Result = -1000003) Then
               DoError 10134, "", "Oops, The Phone Number could not be found."
            End If
         End With
      End If
      Set oConsumer = Nothing
   End If

   If (reqLogonMember <> "") Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            reqLogonMerchant = ""
            reqLogonConsumer = ""
            .FetchLogon reqLogonMember
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.MemberID <> 0) Then
               reqA = .MemberID
               .Load reqA, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqReferredBy = .NameFirst + " " + .NameLast
            End If
            If (.MemberID = 0) Then
               DoError 10137, "", "Oops, The Username could not be found."
            End If
         End With
      End If
      Set oMember = Nothing
   End If
End Sub

Sub LoadList()
   On Error Resume Next

   Set oCountrys = server.CreateObject("ptsCountryUser.CCountrys")
   If oCountrys Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountrys"
   Else
      With oCountrys
         .SysCurrentLanguage = reqSysLanguage
         xmlCountrys = xmlCountrys + .EnumCompany(CLng(reqCompanyID), , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCountrys = Nothing
End Sub

Sub NewConsumer()
   On Error Resume Next
   LoadList

   Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
   If oConsumer Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
   Else
      With oConsumer
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CountryID = 224
         xmlConsumer = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oConsumer = Nothing
End Sub

Sub AddConsumer()
   On Error Resume Next
   reqM = Request.Form.Item("M")
   reqA = Request.Form.Item("A")
   reqS = Request.Form.Item("S")
   reqReferM = Request.Form.Item("ReferM")
   reqReferA = Request.Form.Item("ReferA")

   Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
   If oConsumer Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
   Else
      With oConsumer
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .EnrollDate = Now
         .ReferID = reqS
         .AffiliateID = reqAffiliateID
         .Status = 2
         .Messages = 1
         If (reqS <> 0) Then
            .MerchantID = reqReferM
            .MemberID = reqReferA
         End If
         If (reqS = 0) Then
            .MerchantID = reqM
            .MemberID = reqA
         End If

         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .Email = Request.Form.Item("Email")
         .Phone = Request.Form.Item("Phone")
         .Password = Request.Form.Item("Password")
         .Provider = Request.Form.Item("Provider")
         .Email2 = Request.Form.Item("Email2")
         .Street1 = Request.Form.Item("Street1")
         .Street2 = Request.Form.Item("Street2")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .CountryID = Request.Form.Item("CountryID")
         .City2 = Request.Form.Item("City2")
         .State2 = Request.Form.Item("State2")
         .Zip2 = Request.Form.Item("Zip2")
         .CountryID2 = .CountryID
         
                  If ValidEmail( .Email ) = 0 Then DoError 10122, "", "Oops, Invalid Email Address."
                  If ValidEmail( .Email2 ) = 0 Then DoError 10122, "", "Oops, Invalid Email Address."
               
         If (xmlError = "") Then
            .FetchEmail .Email
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (CLng(.ConsumerID) <> 0) Then
               DoError 10123, "", "Oops, This email address is already assigned to someone else."
            End If
         End If
         If (xmlError = "") Then
            .FetchPhone .Phone
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (CLng(.ConsumerID) <> 0) Then
               DoError 10136, "", "Oops, This phone number is already assigned to someone else. Try adding your country code as a prefix."
            End If
         End If
         If (xmlError = "") Then
            If (LEN(.Password) < 6) Then
               DoError 10124, "", "Oops, Please enter at least 6 characters for the Password."
            End If
         End If
         If (xmlError = "") And (reqAdvanced = 0) Then
            
              Result = GM_GetZip(.Zip, tmpCity, tmpState)
              .City = tmpCity
              .State = tmpState
            
         End If
         If (xmlError = "") Then
            ConsumerID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") Then
            SendWelcomeEmail
            Result = .Custom(ConsumerID, 99, 0, 0, "")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError <> "") Then
            xmlConsumer = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            LoadList
         End If
      End With
   End If
   Set oConsumer = Nothing

   If (xmlError = "") And (reqAffiliateID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqAffiliateID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .SponsorID = ConsumerID
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMember = Nothing
   End If
End Sub

tmpMobile = IsMobileBrowser()
If (tmpMobile <> 0) Then

   Response.Redirect "m_NewShopper.asp" & "?M=" & reqM & "&A=" & reqA & "&S=" & reqS
End If
reqIsMobilePromo = 1
If (reqCompanyID = 0) Then
   reqCompanyID = 21
End If
If (reqA = 0) And (reqAffiliateID <> 0) Then
   reqA = reqAffiliateID
End If
If (reqM = 0) And (reqA = 0) And (reqS = 0) Then
   reqM = Numeric(GetCache("M"))
   reqA = Numeric(GetCache("A"))
   reqS = Numeric(GetCache("S"))
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqM <> 0) Or (reqS <> 0) Or (reqA <> 0) Then
         GetReferredBy
      End If
      If (reqAuto = 0) And (reqReferredBy <> "") Then
         NewConsumer
      End If

   Case CLng(cActionRefer):
      GetReferLogon
      If (reqReferredBy <> "") Then
         NewConsumer
      End If

   Case CLng(cActionAdd):
      AddConsumer
      If (xmlError = "") Then
         reqDone = 1
      End If
      If (xmlError <> "") And (reqAuto <> 0) Then
         reqAuto = 2
      End If

      If (xmlError = "") Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = "Welcome1.htm"
               .Path = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID)
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

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("NewShopperURL")
      reqReturnData = GetCache("NewShopperDATA")
      SetCache "NewShopperURL", ""
      SetCache "NewShopperDATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionNotRefer):
      reqReferredBy = ""
      reqReferM = 0
      reqReferA = 0
      reqM = 0
      reqS = 0
      reqA = 0

   Case CLng(cActionStartStart):
      reqAuto = 2
      NewConsumer

   Case CLng(cActionNewAuto):
      reqAuto = 1
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
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqA) + Chr(34)
xmlParam = xmlParam + " s=" + Chr(34) + CStr(reqS) + Chr(34)
xmlParam = xmlParam + " affiliateid=" + Chr(34) + CStr(reqAffiliateID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " referm=" + Chr(34) + CStr(reqReferM) + Chr(34)
xmlParam = xmlParam + " refera=" + Chr(34) + CStr(reqReferA) + Chr(34)
xmlParam = xmlParam + " referredby=" + Chr(34) + CleanXML(reqReferredBy) + Chr(34)
xmlParam = xmlParam + " logonmerchant=" + Chr(34) + CleanXML(reqLogonMerchant) + Chr(34)
xmlParam = xmlParam + " logonconsumer=" + Chr(34) + CleanXML(reqLogonConsumer) + Chr(34)
xmlParam = xmlParam + " logonmember=" + Chr(34) + CleanXML(reqLogonMember) + Chr(34)
xmlParam = xmlParam + " done=" + Chr(34) + CStr(reqDone) + Chr(34)
xmlParam = xmlParam + " ismobilepromo=" + Chr(34) + CStr(reqIsMobilePromo) + Chr(34)
xmlParam = xmlParam + " isshopperorder=" + Chr(34) + CStr(reqIsShopperOrder) + Chr(34)
xmlParam = xmlParam + " ret=" + Chr(34) + CStr(reqRet) + Chr(34)
xmlParam = xmlParam + " advanced=" + Chr(34) + CStr(reqAdvanced) + Chr(34)
xmlParam = xmlParam + " auto=" + Chr(34) + CStr(reqAuto) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlMerchant
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Consumer[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Consumer[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "NewShopper Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "NewShopper Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "NewShopper Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "NewShopper.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "NewShopper Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "NewShopper Load file (oData) failed with error code " + CStr(oData.parseError)
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
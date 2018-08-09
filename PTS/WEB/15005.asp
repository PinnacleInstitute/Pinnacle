<!--#include file="Include\System.asp"-->
<!--#include file="Include\Company.asp"-->
<!--#include file="Include\Google2FA.asp"-->
<!--#include file="Include\LimitedAccess.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\MobileBrowser.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionLogon = 1
Const cActionLogonMerchant = 2
Const cActionLogonConsumer = 3
Const cActionForgotPassword = 4
Const cActionForgotPasswordMerchant = 5
Const cActionForgotPasswordConsumer = 6
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
'-----declare page parameters
Dim reqC
Dim reqLogon
Dim reqPassword
Dim reqRemember
Dim reqLogonMerchant
Dim reqPasswordMerchant
Dim reqRememberMerchant
Dim reqLogonConsumer
Dim reqPasswordConsumer
Dim reqRememberConsumer
Dim reqUserKey
Dim reqSecurityCode
Dim reqUserAction
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
   SetCache "15005URL", reqReturnURL
   SetCache "15005DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "15005")
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
reqC =  Numeric(GetInput("C", reqPageData))
reqLogon =  GetInput("Logon", reqPageData)
reqPassword =  GetInput("Password", reqPageData)
reqRemember =  Numeric(GetInput("Remember", reqPageData))
reqLogonMerchant =  GetInput("LogonMerchant", reqPageData)
reqPasswordMerchant =  GetInput("PasswordMerchant", reqPageData)
reqRememberMerchant =  Numeric(GetInput("RememberMerchant", reqPageData))
reqLogonConsumer =  GetInput("LogonConsumer", reqPageData)
reqPasswordConsumer =  GetInput("PasswordConsumer", reqPageData)
reqRememberConsumer =  Numeric(GetInput("RememberConsumer", reqPageData))
reqUserKey =  GetInput("UserKey", reqPageData)
reqSecurityCode =  GetInput("SecurityCode", reqPageData)
reqUserAction =  Numeric(GetInput("UserAction", reqPageData))
If (reqC = 0) Then
   reqC = 21
End If
If (reqUserAction <> 0) Then
   reqActionCode = reqUserAction
End If
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

Function SendPassword( bvMerchantID, bvConsumerID )
   On Error Resume Next

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         .Load reqC, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpSender = .Email
         tmpFrom = .Email
         tmpSubject = "Forgot Nexxus Rewards Password"
      End With
   End If
   Set oCompany = Nothing

   If (bvMerchantID <> 0) Then
      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            .Load bvMerchantID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpTo = .Email
            tmpBody = "Merchant: " + .MerchantName + "<BR>" 
            tmpBody = tmpBody + "Merchant #: " + CStr(.MerchantID) + "<BR>" 
            tmpBody = tmpBody + "Email: " + .Email + "<BR>" 
            tmpBody = tmpBody + "Admin Password: " + .Password + "<BR>" 
            tmpBody = tmpBody + "Staff Password: " + .Password2 
         End With
      End If
      Set oMerchant = Nothing
   End If

   If (bvConsumerID <> 0) Then
      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            .Load bvConsumerID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpTo = .Email
            tmpBody = "Shopper: " + .NameFirst + " " + .NameLast + "<BR>" 
            tmpBody = tmpBody + "Phone: " + .Phone + "<BR>" 
            tmpBody = tmpBody + "Email: " + .Email + "<BR>" 
            tmpBody = tmpBody + "Password: " + .Password 
         End With
      End If
      Set oConsumer = Nothing
   End If
   
          If InStr(tmpTo, "@") > 0 Then
            If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
            SendEmail reqC, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
          End If
        
End Function

tmpMobile = IsMobileBrowser()
If (tmpMobile <> 0) Then

   Response.Redirect "m_15005.asp"
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      SetCache "MERCHANT", ""
      SetCache "CONSUMER", ""
      GetCompany(reqC)
      reqLogon = GetCookie("LGN")
      reqPassword = GetCookie("PWD")
      If (reqLogon <> "") Then
         reqRemember = 1
      End If
      reqLogonMerchant = GetCookie("LGN2")
      reqPasswordMerchant = GetCookie("PWD2")
      If (reqLogonMerchant <> "") Then
         reqRememberMerchant = 1
      End If
      reqLogonConsumer = GetCookie("LGN3")
      reqPasswordConsumer = GetCookie("PWD3")
      If (reqLogonConsumer <> "") Then
         reqRememberConsumer = 1
      End If

   Case CLng(cActionLogon):
      If (reqRemember = "1") Then
         SetCookie "LGN", reqLogon
         SetCookie "PWD", reqPassword
      End If
      If (reqRemember = "") Then
         SetCookie "LGN", ""
         SetCookie "PWD", ""
      End If

      Response.Redirect "0101.asp" & "?Lgn=" & reqLogon & "&Pwd=" & reqPassword & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData

   Case CLng(cActionLogonMerchant):
      If (reqRememberMerchant = "1") Then
         SetCookie "LGN2", reqLogonMerchant
         SetCookie "PWD2", reqPasswordMerchant
      End If
      If (reqRememberMerchant = "") Then
         SetCookie "LGN2", ""
         SetCookie "PWD2", ""
      End If

      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            Result = CLng(.Logon(reqLogonMerchant, reqPasswordMerchant))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result = -1000002) Then
               DoError 10129, "", "Oops, The Email Address could not be found."
            End If
            If (Result = -1000003) Then
               DoError 10135, "", "Oops, The Account Number could not be found."
            End If
            If (Result = -1000004) Then
               DoError 10130, "", "Oops, Your Password is incorrect."
            End If
            If (xmlError = "") Then
               .Load Result, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               IsDemo = 0
               If (.Status = 6) Then
                  IsDemo = 1
               End If
               IsOrg = .IsOrg
               StaffAccess = 0
               If (reqPasswordMerchant = .Password2) Then
                  StaffAccess = 1
               End If
               If (IsDemo = 0) And (.Access <> "") Then
                  tmpAccess = LimitedAccess( .Access )
                  If (tmpAccess <> 1) Then
                     DoError -2147220514, "", "Oops, Your access to the system has been limited - Access Denied."
                  End If
               End If
               If (xmlError = "") Then
                  SetCache "MERCHANT", Result
                  reqUserKey = .UserKey
                  SetCache "MERCHACCT", 1
                  If (reqPasswordMerchant = .Password3) Then
                     SetCache "MERCHACCT", 3
                     reqUserKey = .UserKey3
                  End If
                  If (reqPasswordMerchant = .Password4) Then
                     SetCache "MERCHACCT", 4
                     reqUserKey = .UserKey4
                  End If
                  If (StaffAccess <> 0) Then
                     reqUserKey = ""
                  End If
                  If (reqUserKey <> "") Then
                     reqUserAction = reqActionCode
                  End If
                  .VisitDate = Now
                  .Save 1
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End With
      End If
      Set oMerchant = Nothing
      If (xmlError = "") Then
         If (IsDemo = 0) And (reqSecurityCode <> "") Then
            
              If Verify2FAUser( reqUserKey, reqSecurityCode ) Then
              reqUserKey = ""
              Else
              reqSecurityCode = ""
              DoError 10138, "", "Oops, Invalid Security Code"
              End If
            
         End If
         If (IsDemo <> 0) Then
            reqUserKey = ""
         End If
      End If
      If (xmlError = "") And (reqUserKey = "") Then
         If (IsOrg = 0) Then

            If (StaffAccess = 0) Then
               Response.Redirect "15000.asp" & "?MerchantID=" & Result & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
            End If

            If (StaffAccess <> 0) Then
               Response.Redirect "15212.asp" & "?MerchantID=" & Result & "&Popup=" & 2 & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
            End If
         End If
         If (IsOrg <> 0) Then

            Response.Redirect "15030.asp" & "?MerchantID=" & Result & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
         End If
      End If

   Case CLng(cActionLogonConsumer):
      If (reqRememberConsumer = "1") Then
         SetCookie "LGN3", reqLogonConsumer
         SetCookie "PWD3", reqPasswordConsumer
      End If
      If (reqRememberConsumer = "") Then
         SetCookie "LGN3", ""
         SetCookie "PWD3", ""
      End If

      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            Result = CLng(.Logon(reqLogonConsumer, reqPasswordConsumer))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result = -1000002) Then
               DoError 10129, "", "Oops, The Email Address could not be found."
            End If
            If (Result = -1000003) Then
               DoError 10134, "", "Oops, The Phone Number could not be found."
            End If
            If (Result = -1000004) Then
               DoError 10130, "", "Oops, Your Password is incorrect."
            End If
            If (Result = -1000005) Then
               DoError 10156, "", "Oops, The Shopper Account is Inactive. Contact support@NexxusRewards.com"
            End If
            If (xmlError = "") Then
               SetCache "CONSUMER", Result
               .Load Result, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqUserKey = .UserKey
               .VisitDate = Now
               If (reqUserKey <> "") Then
                  reqUserAction = reqActionCode
               End If
               .Save 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oConsumer = Nothing
      If (xmlError = "") And (reqSecurityCode <> "") Then
         
            If Verify2FAUser( reqUserKey, reqSecurityCode ) Then
            reqUserKey = ""
            Else
            reqSecurityCode = ""
            DoError 10138, "", "Oops, Invalid Security Code"
            End If
          
      End If
      If (xmlError = "") And (reqUserKey = "") Then

         Response.Redirect "15100.asp" & "?ConsumerID=" & Result & "&ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
      End If

   Case CLng(cActionForgotPassword):

      Response.Redirect "0102.asp" & "?ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData

   Case CLng(cActionForgotPasswordMerchant):
      tmpMerchantID = 0

      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            Result = CLng(.Logon2(reqLogonMerchant))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result > 0) Then
               tmpMerchantID = Result
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
      If (tmpMerchantID <> 0) Then
         SendPassword tmpMerchantID, 0
      End If

   Case CLng(cActionForgotPasswordConsumer):
      tmpConsumerID = 0

      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            Result = CLng(.Logon2(reqLogonConsumer))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result > 0) Then
               tmpConsumerID = Result
            End If
            If (Result = -1000002) Then
               DoError 10129, "", "Oops, The Email could not be found."
            End If
            If (Result = -1000003) Then
               DoError 10135, "", "Oops, The Phone Number could not be found."
            End If
         End With
      End If
      Set oConsumer = Nothing
      If (tmpConsumerID <> 0) Then
         SendPassword 0, tmpConsumerID
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
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " logon=" + Chr(34) + CleanXML(reqLogon) + Chr(34)
xmlParam = xmlParam + " password=" + Chr(34) + CleanXML(reqPassword) + Chr(34)
xmlParam = xmlParam + " remember=" + Chr(34) + CStr(reqRemember) + Chr(34)
xmlParam = xmlParam + " logonmerchant=" + Chr(34) + CleanXML(reqLogonMerchant) + Chr(34)
xmlParam = xmlParam + " passwordmerchant=" + Chr(34) + CleanXML(reqPasswordMerchant) + Chr(34)
xmlParam = xmlParam + " remembermerchant=" + Chr(34) + CStr(reqRememberMerchant) + Chr(34)
xmlParam = xmlParam + " logonconsumer=" + Chr(34) + CleanXML(reqLogonConsumer) + Chr(34)
xmlParam = xmlParam + " passwordconsumer=" + Chr(34) + CleanXML(reqPasswordConsumer) + Chr(34)
xmlParam = xmlParam + " rememberconsumer=" + Chr(34) + CStr(reqRememberConsumer) + Chr(34)
xmlParam = xmlParam + " userkey=" + Chr(34) + CleanXML(reqUserKey) + Chr(34)
xmlParam = xmlParam + " securitycode=" + Chr(34) + CleanXML(reqSecurityCode) + Chr(34)
xmlParam = xmlParam + " useraction=" + Chr(34) + CStr(reqUserAction) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlMerchant
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\15005[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\15005[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "15005 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "15005 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "15005 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "15005.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "15005 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "15005 Load file (oData) failed with error code " + CStr(oData.parseError)
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
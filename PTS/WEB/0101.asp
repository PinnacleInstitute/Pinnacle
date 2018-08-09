<!--#include file="Include\System.asp"-->
<!--#include file="Include\LimitedAccess.asp"-->
<!--#include file="Include\MemberOptions.asp"-->
<!--#include file="Include\CompanyHeader.asp"-->
<!--#include file="Include\Company.asp"-->
<!--#include file="Include\Encript.asp"-->
<!--#include file="Include\Resources.asp"-->
<!--#include file="Include\Authy.asp"-->
<!--#include file="Include\Google2FA.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\IP.asp"-->
<!--#include file="Include\MobileBrowser.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionSignIn = 1
Const cActionSignOut = 9
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
Dim oHTMLFile, xmlHTMLFile
Dim oMember, xmlMember
Dim oAuthUser, xmlAuthUser
Dim oBusiness, xmlBusiness
'-----declare page parameters
Dim reqLgn
Dim reqPwd
Dim reqC
Dim reqR
Dim reqE
Dim reqA
Dim reqG
Dim reqContactInfo
Dim reqRemember
Dim reqPage
Dim reqCompanyID
Dim reqAuthyID
Dim reqUserKey
Dim reqSecurityCode
Dim reqIsOverride2FA
Dim reqAccessStatus
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
   SetCache "0101URL", reqReturnURL
   SetCache "0101DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0101")
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
reqLgn =  GetInput("Lgn", reqPageData)
reqPwd =  GetInput("Pwd", reqPageData)
reqC =  Numeric(GetInput("C", reqPageData))
reqR =  GetInput("R", reqPageData)
reqE =  GetInput("E", reqPageData)
reqA =  Numeric(GetInput("A", reqPageData))
reqG =  Numeric(GetInput("G", reqPageData))
reqContactInfo =  Numeric(GetInput("ContactInfo", reqPageData))
reqRemember =  Numeric(GetInput("Remember", reqPageData))
reqPage =  Replace(GetInput("Page", reqPageData), "&", "%26")
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqAuthyID =  Numeric(GetInput("AuthyID", reqPageData))
reqUserKey =  GetInput("UserKey", reqPageData)
reqSecurityCode =  GetInput("SecurityCode", reqPageData)
reqIsOverride2FA =  Numeric(GetInput("IsOverride2FA", reqPageData))
reqAccessStatus =  Numeric(GetInput("AccessStatus", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

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

Function AccessNotice( lgn, email )
   On Error Resume Next
   If (reqSysCompanyID = 0) Then
      reqSysCompanyID = 21
   End If

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "access.htm"
         .Path = reqSysWebDirectory + "Sections\Company/" + CStr(reqSysCompanyID)
         .Language = reqSysLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpBody = .Data
      End With
   End If
   Set oHTMLFile = Nothing
   
              If reqAccessStatus = 0 Then tmp2FA = "Disabled"
              If reqAccessStatus = 1 Then tmp2FA = "Enabled"
              If reqAccessStatus = 2 Then tmp2FA = "Override"
              UserName = GetCache("USERNAME")
              IP = Request.ServerVariables("REMOTE_ADDR")
              Browser = Request.ServerVariables("HTTP_USER_AGENT")
              tmpLocation = GetIPCity( IP )
              tmpTime = Now()

              tmpBody = Replace( tmpBody, "{username}", lgn + " - " + UserName )
              tmpBody = Replace( tmpBody, "{time}", tmpTime )
              tmpBody = Replace( tmpBody, "{ip}", IP + " - " + tmpLocation )
              tmpBody = Replace( tmpBody, "{browser}", Browser )
              tmpBody = Replace( tmpBody, "{2fa}", tmp2FA )

              tmpTo = email
              tmpFrom = "app-events@pinnaclep.com"
              If reqSysCompanyID = 17 Then
              tmpFrom = "support@gcrmarketing.com"
              tmpSubject = "GCR - Successful login notification " + CStr(tmpTime)
              End If
              If reqSysCompanyID = 21 Then
              tmpFrom = "support@nexxusuniversity.com"
              tmpSubject = "Nexxus - Successful login notification " + CStr(tmpTime)
              End If
              tmpSender = tmpFrom
              SendEmail company, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
            
End Function

Sub NotifySystem()
   On Error Resume Next
   
          tmpTo = "app-events@pinnaclep.com"
          tmpSender = tmpTo
          tmpFrom = tmpTo
          tmpBody = ""
          IP = Request.ServerVariables("REMOTE_ADDR")
          tmpLocation = GetIPCity( IP )
          If reqSysUserGroup = 1 Then tmpSubject = "LOGIN SYSADMIN: "
          If reqSysUserGroup >= 21 And reqSysUserGroup <= 23 Then tmpSubject = "LOGIN EMPLOYEE: "
          If reqSysUserGroup >= 51 And reqSysUserGroup <= 52 Then tmpSubject = "LOGIN ADMIN: "
          tmpSubject = tmpSubject + " " + CStr(reqSysUserID) + " - " + reqSysUserName + " - " + CSTR(reqSysCompanyID) + " - " + IP + " - " + tmpLocation
'          SendEmail reqSysCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
          'HACKER TEST
          Target = "85.253.66.46,90.191.167.100,88.196.236.75,121.54.58.242,121.54.58.246,119.81.230.137,119.81.230.132"
          If InStr( Target, IP ) > 0 Then
          tmpTo = "bobwood56@gmail.com"
          tmpSubject = "HACKER ALERT: " + tmpSubject
          SendEmail reqSysCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
          End If
        
End Sub

Function LogLogin(msg,lgn)
   On Error Resume Next
   
          UserID = Numeric(GetCache("USERID"))
          MemberID = Numeric(GetCache("MEMBERID"))
          CompanyID = Numeric(GetCache("COMPANYID"))
          UserName = GetCache("USERNAME")
          good = ""
          If msg = "GOOD" Then good = " - " + CStr(UserID) + "/" + CStr(MemberID) + " - " + UserName
          str = lgn + " - " + CStr(CompanyID)
          LogFile "Login", msg + ": " + str + good
        
End Function

Sub ClearUser()
   On Error Resume Next
   SetCache "USERID", 99
   SetCache "USERGROUP", 99
   SetCache "USERSTATUS", 1
   SetCache "USERNAME", ""
   SetCache "TRAINERID", 0
   SetCache "EMPLOYEEID", 0
   SetCache "ORGID", 0
   SetCache "AFFILIATEID", 0
   SetCache "MEMBERID", 0
   SetCache "SIGNINURL", ""
   SetCache "SECURITYLEVEL", 0
   SetCache "OPTIONS", ""
   SetCache "MENUBARSTATE", ""
End Sub

Function SignIn(lgn,pwd)
   On Error Resume Next
   tmpAuthUserID = 1
   If (reqA <> 0) Then
      tmpAuthUserID = reqA
   End If

   If (reqC <> 0) And (reqR <> "") Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .FetchRef reqC, reqR
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpAuthUserID = .AuthUserID
         End With
      End If
      Set oMember = Nothing
   End If

   Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
   If oAuthUser Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
   Else
      With oAuthUser
         .SysCurrentLanguage = reqSysLanguage
         SetCache "SECURITYLEVEL", 0
         .AuthUserID = tmpAuthUserID
         .Logon = lgn
         .Password = pwd
         xmlAuthUser = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (tmpAuthUserID = 1) Then
            .SignIn 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (tmpAuthUserID <> 1) Then
            .Load 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (.AuthUserID = 0) Then
            DoError -2147220504, "", "Oops, Either your logon ID or password is incorrect."
            LogLogin "BAD", lgn
            ClearUser
         End If
         If (.UserStatus = 2) Then
            DoError -2147220505, "", "Oops, The logon ID you entered has been disabled."
            LogLogin "DISABLED", lgn 
            ClearUser
         End If
         If (xmlError = "") Then
            SetCache "UC", .UserCode
            tmpLoginLogged = 0
            reqAuthyID = .UserType
            reqUserKey = .UserKey
            If (reqUserKey <> "") Then
               reqAuthyID = 0
            End If
            SetCache "O2FA", 0
            If (.UserGroup = 41) And (reqIsOverride2FA <> 0) Then
               SetCache "O2FA", 1
               reqAuthyID = 0
               reqUserKey = ""
               reqSecurityCode = ""
               reqAccessStatus = 2
            End If
         End If
         If (xmlError = "") And (reqSecurityCode <> "") Then
            If (reqAuthyID <> 0) Then
               
                Verify = VerifyAuthyUser( reqAuthyID, reqSecurityCode )
                If Verify = "1" Then
                reqAuthyID = 0
                reqAccessStatus = 1
                tmpLoginLogged = 1
                LogLogin "GOOD2FA-A", lgn
                Else
                reqSecurityCode = ""
                LogLogin "BAD2FA-A", lgn
                DoError 10138, "", "Oops, Invalid Security Code"
                End If
              
            End If
            If (reqUserKey <> "") Then
               
                If Verify2FAUser( reqUserKey, reqSecurityCode ) Then
                reqUserKey = ""
                reqAccessStatus = 1
                tmpLoginLogged = 1
                LogLogin "GOOD2FA-G", lgn
                Else
                reqSecurityCode = ""
                LogLogin "BAD2FA-G", lgn
                DoError 10138, "", "Oops, Invalid Security Code"
                End If
              
            End If
         End If
         If (xmlError = "") And (reqAuthyID = 0) And (reqUserKey = "") Then
            reqSysUserID = .AuthUserID
            SetCache "USERID", reqSysUserID
            reqSysUserGroup = .UserGroup
            SetCache "USERGROUP", reqSysUserGroup
            reqSysUserStatus = .UserStatus
            SetCache "USERSTATUS", reqSysUserStatus
            reqSysUserName = .AuthUserName
            SetCache "USERNAME", reqSysUserName
            reqSysTrainerID = .TrainerID
            SetCache "TRAINERID", reqSysTrainerID
            reqSysEmployeeID = .EmployeeID
            SetCache "EMPLOYEEID", reqSysEmployeeID
            reqSysMemberID = .MemberID
            SetCache "MEMBERID", reqSysMemberID
            reqSysOrgID = .OrgID
            SetCache "ORGID", reqSysOrgID
            reqSysAffiliateID = .AffiliateID
            SetCache "AFFILIATEID", reqSysAffiliateID
            SetCache "AE", reqSysUserGroup
            UserEmail = .Email
            If (tmpLoginLogged = 0) Then
               LogLogin "GOOD", lgn 
            End If
            If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 24) Then
               NotifySystem
               SetCache "EMEMBERID", Encript(CStr(reqSysMemberID))
               reqSysCompanyID = 0
               SetCache "COMPANYID", reqSysCompanyID
               reqSysNavBarImage = ""
               SetCache "NAVBARIMAGE", reqSysNavBarImage

               Set oEmployee = server.CreateObject("ptsEmployeeUser.CEmployee")
               If oEmployee Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmployeeUser.CEmployee"
               Else
                  With oEmployee
                     .SysCurrentLanguage = reqSysLanguage
                     .Load CLng(reqSysEmployeeID), CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     reqSysMemberID = .MemberID
                     SetCache "MEMBERID", reqSysMemberID
                  End With
               End If
               Set oEmployee = Nothing

               Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
               If oBusiness Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
               Else
                  With oBusiness
                     .SysCurrentLanguage = reqSysLanguage
                     .Load 1, CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     If (reqSysUserGroup = 1) Then
                        reqSysUserOptions = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890@#%()|\_+=./,[]{}"
                     End If
                     If (reqSysUserGroup = 21) Then
                        reqSysUserOptions = .Options1
                     End If
                     If (reqSysUserGroup = 22) Then
                        reqSysUserOptions = .Options2
                     End If
                     If (reqSysUserGroup = 23) Then
                        reqSysUserOptions = .Options3
                     End If
                     If (reqSysUserGroup = 24) Then
                        reqSysUserOptions = .Options4
                     End If
                     SetCache "USEROPTIONS", reqSysUserOptions
                  End With
               End If
               Set oBusiness = Nothing
               AccessNotice lgn, UserEmail 

               If (reqSysUserGroup = 24) Then
                  Response.Redirect "0099.asp"
               End If

               If (reqSysUserGroup <= 23) Then
                     tmpRedirect = "http://" + reqSysServerName + reqSysServerPath
                  Response.Redirect tmpRedirect + "EmployeeHome.asp"
               End If
            End If
            If (reqSysUserGroup = 31) Then
               SetCache "MENUBARSTATE", "0"

               Response.Redirect "0305.asp"
            End If
            If (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
               NotifySystem

               Set oOrg = server.CreateObject("ptsOrgUser.COrg")
               If oOrg Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsOrgUser.COrg"
               Else
                  With oOrg
                     .SysCurrentLanguage = reqSysLanguage
                     .Load CLng(reqSysOrgID), CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     If (.CompanyID <> CSTR(reqSysCompanyID)) Then
                        AbortUser()
                     End If
                     reqSysCompanyID = .CompanyID
                     tmpSecure = .Secure
                     tmpIP = .Description
                     SetCache "COMPANYID", reqSysCompanyID
                     SetCache "SECURITYLEVEL", .Secure
                     SetCache "MEMBERID", .MemberID
                     If (.Status = 4) Then
                        DoError 10106, "", "Oops, Your System is not available."
                        ClearUser
                     End If
                     UserIP = Request.ServerVariables("REMOTE_ADDR")
                     SetCache "IPC", Mid(UserIP,5,1)
                     If (tmpIP <> "") Then
                        
                    pos = InStr(tmpIP, ";")
                    If pos = 0 Then length = Len(tmpIP) Else length = pos - 1
                    subIP = Left(UserIP,length)
                    If InStr( tmpIP, subIP) = 0 Then AbortUser()
                  
                     End If
                  End With
               End If
               Set oOrg = Nothing

               If (xmlError = "") Then
                  Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
                  If oCoption Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
                  Else
                     With oCoption
                        .SysCurrentLanguage = reqSysLanguage
                        .FetchCompany CLng(reqSysCompanyID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        .Load .CoptionID, CLng(reqSysUserID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        If (reqSysUserGroup = 51) Then
                           SetCache "USEROPTIONS", .Options4
                        End If
                        If (reqSysUserGroup = 52) Then
                           If (tmpSecure = 0) Or (tmpSecure = 1) Then
                              SetCache "USEROPTIONS", .Options5
                           End If
                           If (tmpSecure = 2) Then
                              SetCache "USEROPTIONS", .Options6
                           End If
                           If (tmpSecure = 3) Then
                              SetCache "USEROPTIONS", .Options7
                           End If
                           If (tmpSecure = 4) Then
                              SetCache "USEROPTIONS", .Options8
                           End If
                        End If
                     End With
                  End If
                  Set oCoption = Nothing
               End If
               If (reqSysCompanyID = 17) Or (reqSysCompanyID = 21) Then
                  AccessNotice lgn, UserEmail 
               End If

               If (xmlError = "") Then
                     tmpRedirect = "http://" + reqSysServerName + reqSysServerPath
                  Response.Redirect tmpRedirect + "AdminHome.asp" & "?CompanyID=" & reqSysCompanyID
               End If
            End If
            If (reqSysUserGroup = 61) Then
               SetCache "MENUBARSTATE", "0"

               Set oAffiliate = server.CreateObject("ptsAffiliateUser.CAffiliate")
               If oAffiliate Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsAffiliateUser.CAffiliate"
               Else
                  With oAffiliate
                     .SysCurrentLanguage = reqSysLanguage
                     .Load CLng(reqSysAffiliateID), CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oAffiliate = Nothing

               If (xmlError = "") Then
                  Response.Redirect "0604.asp" & "?AffiliateID=" & reqSysAffiliateID
               End If
            End If
            If (reqSysUserGroup = 41) Then
               tmpAccess = 1
               tmpCompanyStatus = 0

               Set oMember = server.CreateObject("ptsMemberUser.CMember")
               If oMember Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
               Else
                  With oMember
                     .SysCurrentLanguage = reqSysLanguage
                     .Load CLng(reqSysMemberID), CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     MemberCompanyID = CLng(.CompanyID)
                     If (reqSysCompanyID <> 0) And (MemberCompanyID <> reqSysCompanyID) Then
                        DoError -2147217874, "", "Oops, Logon Name is registered to another company."
                        reqContactInfo = 1
                        ClearUser
                     End If
                     MemberOptions = .Options
                     SetCache "OPTIONS2", .Options2
                     MemberOptions2 = .Options2
                     tmpGroupID = .GroupID
                     tmpBilling = .Billing
                     tmpBillingID = .BillingID
                     tmpStatus = .Status
                     If (.Status = 3) Then
                        .Level = 0
                     End If
                     tmpLevel = .Level
                     If (tmpGroupID <> 0) Then
                        GetResources tmpGroupID
                     End If
                     SetCache "SECURITYLEVEL", .Secure
                     SetCache "VISITDATE", .VisitDate
                     reqSysUserMode = .Status
                     If (.IsMaster <> 0) Then
                        reqSysUserMode = 10
                     End If
                     SetCache "USERMODE", reqSysUserMode
                     tmpAccessLimit = .AccessLimit
                     If (tmpStatus = 4) Then
                        tmpMemberID = reqSysMemberID
                        ClearUser

                           tmpRedirect = "http://" + reqSysServerName + reqSysServerPath
                        Response.Redirect tmpRedirect + "0436d.asp" & "?MemberID=" & tmpMemberID
                     End If
                     If (tmpStatus < 1) Or (tmpStatus > 3) Then
                        DoError -2147220517, "", "Oops, Please contact Customer Support to access the system."
                        reqContactInfo = 1
                        ClearUser
                     End If
                     If (xmlError = "") Then
                        reqSysCompanyID = .CompanyID
                        SetCache "COMPANYID", reqSysCompanyID
                     End If
                  End With
               End If
               Set oMember = Nothing
               If (tmpGroupID = 0) Then
                  SetCompanyHeader reqSysCompanyID, reqSysLanguage
               End If
               If (tmpGroupID <> 0) Then
                  SetCompanyGrpHeader reqSysCompanyID, tmpGroupID, reqSysLanguage
               End If

               If (xmlError = "") Then
                  Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
                  If oCompany Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
                  Else
                     With oCompany
                        .SysCurrentLanguage = reqSysLanguage
                        .Load CLng(reqSysCompanyID), CLng(reqSysUserID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        tmpCompanyStatus = .Status
                        If (.Status <> 2) And (.Status <> 3) Then
                           DoError 10106, "", "Oops, Your System is not available."
                           ClearUser
                        End If
                     End With
                  End If
                  Set oCompany = Nothing
               End If

               If (xmlError = "") Then
                  Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
                  If oCoption Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
                  Else
                     With oCoption
                        .SysCurrentLanguage = reqSysLanguage
                        .FetchCompany CLng(reqSysCompanyID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        .Load .CoptionID, CLng(reqSysUserID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        
                    aGA = Split(.GAAcct, ",")
                    If UBOUND(aGA) = 1 Then
                    tmpID = aGA(0)
                    tmpDomain = aGA(1)
                    If tmpID <> "" And tmpDomain <> "" Then
                    SetCache "GA_ACCTID", tmpID
                    SetCache "GA_DOMAIN", tmpDomain
                    End If
                    End If
                  
                        SetCache "IDENTIFY", .Identify
                        SetCache "NAVBARIMAGE", reqSysNavBarImage
                        tmpIPLimit = .IPLimit
                        If (tmpIPLimit = 0) Then
                           tmpIPLimit = 6
                        End If
                        If (tmpLevel = 0) Then
                           reqSysUserOptions = .FreeOptions
                        End If
                        If (tmpLevel = 1) Then
                           reqSysUserOptions = .Options
                        End If
                        If (tmpLevel = 2) Then
                           reqSysUserOptions = .Options2
                        End If
                        If (tmpLevel = 3) Then
                           reqSysUserOptions = .Options3
                        End If
                        reqSysUserOptions = GetUserOptions(reqSysUserOptions, MemberOptions)
                        SetCache "USEROPTIONS", reqSysUserOptions
                     End With
                  End If
                  Set oCoption = Nothing
               End If

               If (xmlError = "") And (tmpGroupID <> 0) Then
                  Set oMoption = server.CreateObject("ptsMoptionUser.CMoption")
                  If oMoption Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsMoptionUser.CMoption"
                  Else
                     With oMoption
                        .SysCurrentLanguage = reqSysLanguage
                        .FetchMember tmpGroupID
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        If (.MoptionID <> 0) Then
                           .Load .MoptionID, CLng(reqSysUserID)
                           If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                           If (tmpLevel = 0) And (.Options0 <> "") Then
                              reqSysUserOptions = .Options0
                           End If
                           If (tmpLevel = 1) And (.Options1 <> "") Then
                              reqSysUserOptions = .Options1
                           End If
                           If (tmpLevel = 2) And (.Options2 <> "") Then
                              reqSysUserOptions = .Options2
                           End If
                           If (tmpLevel = 3) And (.Options3 <> "") Then
                              reqSysUserOptions = .Options3
                           End If
                           reqSysUserOptions = GetUserOptions(reqSysUserOptions, MemberOptions)
                           SetCache "USEROPTIONS", reqSysUserOptions
                        End If
                     End With
                  End If
                  Set oMoption = Nothing
               End If
               If (xmlError = "") Then
                  
                  IPLevel = 3
                  If Left(tmpAccessLimit, 4) = "IPL:" Then
                  If IsNumeric(Mid(tmpAccessLimit, 5, 1)) Then
                  x = Mid(tmpAccessLimit, 5, 1)
                  If x >= 1 And x <= 4 Then IPLevel = x
                  End If
                  End If
                  UserIP = Request.ServerVariables("REMOTE_ADDR")
                  If IPLevel = 4 Then
                  tmpIP = UserIP
                  Else
                  x = 0
                  For z = 1 To IPLevel
                  x = InStr(x + 1, UserIP, ".")
                  Next
                  If x > 0 Then tmpIP = Left(UserIP, x)
                  End If
                

                  If (tmpAccessLimit <> "NONE") And (tmpCompanyStatus <> 3) Then
                     Set oAuthLog = server.CreateObject("ptsAuthLogUser.CAuthLog")
                     If oAuthLog Is Nothing Then
                        DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthLogUser.CAuthLog"
                     Else
                        With oAuthLog
                           .SysCurrentLanguage = reqSysLanguage
                           result = CLng(.LogAuthUser(CLng(reqSysUserID), tmpIP, tmpIPLimit))
                           If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                           If (result = -1) Then
                              DoError -2147220515, "", "Oops, Your access to the system has been disallowed - IP Address Denied.{" + UserIP + "}"
                              ClearUser
                           End If
                           If (result > 1) Then
                              DoError -2147220516, "", "Oops, Your access to the system has been disallowed - Too Many IP Addresses.{" + UserIP + "}[" + CStr(result) + "]"
                              ClearUser
                           End If
                        End With
                     End If
                     Set oAuthLog = Nothing
                  End If
                  If (xmlError = "") And (tmpAccessLimit <> "NONE") And (tmpCompanyStatus <> 3) Then
                     tmpAccess = LimitedAccess( tmpAccessLimit )
                     If (tmpAccess <> 1) Then
                        DoError -2147220514, "", "Oops, Your access to the system has been limited - Access Denied."
                        ClearUser
                     End If
                  End If
                  If (xmlError = "") Then

                     If (tmpStatus = 1) Or (tmpStatus = 2) Or (tmpStatus = 3) Or (tmpStatus = 5) Then
                        Set oMember = server.CreateObject("ptsMemberUser.CMember")
                        If oMember Is Nothing Then
                           DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
                        Else
                           With oMember
                              .SysCurrentLanguage = reqSysLanguage
                              .Load CLng(reqSysMemberID), CLng(reqSysUserID)
                              If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                              .VisitDate = Now
                              .Save CLng(reqSysUserID)
                              If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                           End With
                        End If
                        Set oMember = Nothing
                     End If
                     SetMemberOptions reqSysMemberID, reqSysCompanyID, reqSysLanguage
                     If (tmpAccess = 1) Then
                        
                      tmpIP = Request.ServerVariables("REMOTE_ADDR")
                    
                        Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
                        If oHTTP Is Nothing Then
                           DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
                        Else
                           tmpServer = "http://" + reqSysServerName + reqSysServerPath
                           oHTTP.open "GET", tmpServer + "0418.asp" & "?MemberID=" & reqSysMemberID & "&Notify=" & 7 & "&IP=" & tmpIP
                           oHTTP.send
                        End If
                        Set oHTTP = Nothing
                        If (reqPage <> "") Then
                           
                        reqPage = Replace( reqPage, "{id}", CStr(reqSysMemberID))
                        reqPage = Replace( reqPage, "%26", "&")
                        Response.Redirect reqPage
                      
                        End If
                        If (reqSysCompanyID = 17) Or (reqSysCompanyID = 21) Then
                           AccessNotice lgn, UserEmail 
                        End If

                        If (reqSysCompanyID = 12) Then
                              tmpRedirect = "http://" + reqSysServerName + reqSysServerPath
                           Response.Redirect tmpRedirect + "13210.asp"
                        End If
                        If (reqSysCompanyID >= 7) Then
                           tmpMobile = IsMobileBrowser()

                           If (tmpMobile = 0) Then
                                 tmpRedirect = "http://" + reqSysServerName + reqSysServerPath
                              Response.Redirect tmpRedirect + "MemberHome.asp"
                           End If

                           If (tmpMobile <> 0) Then
                                 tmpRedirect = "http://" + reqSysServerName + reqSysServerPath
                              Response.Redirect tmpRedirect + "m_MemberHome.asp"
                           End If
                        End If

                           tmpRedirect = "http://" + reqSysServerName + reqSysServerPath
                        Response.Redirect tmpRedirect + "0404.asp"
                     End If
                  End If
               End If
            End If
         End If
      End With
   End If
   Set oAuthUser = Nothing

   If (reqContactInfo = 1) Then
      Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
      If oBusiness Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
      Else
         With oBusiness
            .SysCurrentLanguage = reqSysLanguage
            .Load 1, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlBusiness = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBusiness = Nothing
   End If
End Function

If (reqG = 0) Then
   reqG = Numeric(GetCache("G"))
End If
If (reqE <> "") Then
   
          reqR = Decript(reqE)
        
End If
If (reqCompanyID = 0) And (reqC <> 0) Then
   reqCompanyID = reqC
End If
If (reqCompanyID <> 0) And (reqSysCompanyID = 0) Then
   GetCompany(reqCompanyID)
   If (reqG <> 0) Then
      SetCompanyGrpHeader reqCompanyID, reqG, reqSysLanguage
   End If
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqLgn <> "") Or (reqR <> "") Then
         SignIn reqLgn, reqPwd
      End If
      reqLgn = GetCookie("LGN")
      reqPwd = GetCookie("PWD")
      If (reqLgn <> "") Then
         reqRemember = 1
      End If

      Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
      If oAuthUser Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
      Else
         With oAuthUser
            .SysCurrentLanguage = reqSysLanguage
            .AuthUserID = 1
            .Logon = reqLgn
            .Password = reqPwd
            reqSysUserID = 99
            reqSysUserGroup = 99
            reqSysUserStatus = 1
            xmlAuthUser = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAuthUser = Nothing

   Case CLng(cActionSignIn):
      tmpLgn = Request.Form.Item("Logon")
      tmpPwd = Request.Form.Item("Password")
      tmpRemember = Request.Form.Item("Remember")
      If (tmpRemember = "1") Then
         SetCookie "LGN", tmpLgn
         SetCookie "PWD", tmpPwd
      End If
      If (tmpRemember = "") Then
         SetCookie "LGN", ""
         SetCookie "PWD", ""
      End If
      SignIn tmpLgn, tmpPwd

   Case CLng(cActionSignOut):
      ClearUser

      If (xmlError = "") Then
         Response.Redirect "0000.asp" & "?ReturnURL=" & reqPageURL & "&ReturnData=" & reqPageData
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
xmlParam = xmlParam + " lgn=" + Chr(34) + CleanXML(reqLgn) + Chr(34)
xmlParam = xmlParam + " pwd=" + Chr(34) + CleanXML(reqPwd) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " r=" + Chr(34) + CleanXML(reqR) + Chr(34)
xmlParam = xmlParam + " e=" + Chr(34) + CleanXML(reqE) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqA) + Chr(34)
xmlParam = xmlParam + " g=" + Chr(34) + CStr(reqG) + Chr(34)
xmlParam = xmlParam + " contactinfo=" + Chr(34) + CStr(reqContactInfo) + Chr(34)
xmlParam = xmlParam + " remember=" + Chr(34) + CStr(reqRemember) + Chr(34)
xmlParam = xmlParam + " page=" + Chr(34) + CleanXML(reqPage) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " authyid=" + Chr(34) + CStr(reqAuthyID) + Chr(34)
xmlParam = xmlParam + " userkey=" + Chr(34) + CleanXML(reqUserKey) + Chr(34)
xmlParam = xmlParam + " securitycode=" + Chr(34) + CleanXML(reqSecurityCode) + Chr(34)
xmlParam = xmlParam + " isoverride2fa=" + Chr(34) + CStr(reqIsOverride2FA) + Chr(34)
xmlParam = xmlParam + " accessstatus=" + Chr(34) + CStr(reqAccessStatus) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlAuthUser
xmlTransaction = xmlTransaction +  xmlBusiness
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\AuthUser[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\AuthUser[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0101 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0101 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0101 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0101.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0101 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0101 Load file (oData) failed with error code " + CStr(oData.parseError)
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
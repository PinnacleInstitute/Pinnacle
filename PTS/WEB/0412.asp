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
Dim oCoption, xmlCoption
Dim oMember, xmlMember
Dim oAddress, xmlAddress
Dim oCountrys, xmlCountrys
'-----declare page parameters
Dim reqCompanyID
Dim reqMasterID
Dim reqMembership
Dim reqStatus
Dim reqLevel
Dim reqGroupID
Dim reqRefer
Dim reqRefName
Dim reqMemberID
Dim reqBilling
Dim reqIsReferral
Dim reqPrice
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
   SetCache "0412URL", reqReturnURL
   SetCache "0412DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0412")
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
reqMasterID =  Numeric(GetInput("MasterID", reqPageData))
reqMembership =  Numeric(GetInput("Membership", reqPageData))
reqStatus =  Numeric(GetInput("Status", reqPageData))
reqLevel =  Numeric(GetInput("Level", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqRefer =  GetInput("Refer", reqPageData)
reqRefName =  GetInput("RefName", reqPageData)
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqBilling =  Numeric(GetInput("Billing", reqPageData))
reqIsReferral =  Numeric(GetInput("IsReferral", reqPageData))
reqPrice =  GetInput("Price", reqPageData)
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

Sub LoadCompanyOptions()
   On Error Resume Next

   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany CLng(reqCompanyID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqIsReferral = .IsDiscount
         If (reqLevel = 0) Then
            reqSysUserOptions = .FreeOptions
         End If
         If (reqLevel = 1) Then
            reqSysUserOptions = .Options
         End If
         If (reqLevel = 2) Then
            reqSysUserOptions = .Options2
         End If
         If (reqLevel = 3) Then
            reqSysUserOptions = .Options3
         End If
      End With
   End If
   Set oCoption = Nothing
End Sub

Sub NewMember()
   On Error Resume Next

   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany CLng(reqCompanyID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (reqLevel = 0) Then
            reqSysUserOptions = .FreeOptions
         End If
         If (reqLevel = 1) Then
            reqSysUserOptions = .Options
         End If
         If (reqLevel = 2) Then
            reqSysUserOptions = .Options2
         End If
         If (reqLevel = 3) Then
            reqSysUserOptions = .Options3
         End If
         tmpBilling = .Billing
         If (reqLevel = 0) Or (reqLevel = 1) Then
            tmpPrice = .Price
            tmpRetail = .Retail
         End If
         If (reqLevel = 2) Then
            tmpPrice = .Price2
            tmpRetail = .Retail2
         End If
         If (reqLevel = 3) Then
            tmpPrice = .Price3
            tmpRetail = .Retail3
         End If
         tmpInitPrice = .InitPrice
         tmpDiscount = .Discount
         tmpIsDiscount = .IsDiscount
         tmpBusPrice = .BusPrice
         tmpBusRetail = .BusRetail
         tmpBusAccts = .BusAccts
         tmpBusAcctPrice = .BusAcctPrice
         tmpBusAcctRetail = .BusAcctRetail
         tmpIsBusAcct = .IsBusAcct
         tmpPromoID = .PromoCode
         tmpAccessLimit = .AccessLimit
         tmpQuizLimit = .QuizLimit
         tmpMemberLimit = .MemberLimit
         tmpTrialDays = .TrialDays
         tmpIsTrialPayment = .IsTrialPayment
         reqRefName = .RefName
      End With
   End If
   Set oCoption = Nothing

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .EnrollDate = Now
         .PaidDate = FormatDateTime(.EnrollDate,2)
         .CompanyID = reqCompanyID
         .Billing = tmpBilling
         .Level = reqLevel
         .InitPrice = tmpInitPrice
         .Price = tmpPrice
         .Retail = tmpRetail
         .Discount = tmpDiscount
         .IsDiscount = tmpIsDiscount
         .PromoID = tmpPromoID
         .AccessLimit = tmpAccessLimit
         .QuizLimit = tmpQuizLimit
         If (reqStatus = 2) Then
            .TrialDays = tmpTrialDays
            .PaidDate = DATEADD("d", tmpTrialDays, reqSysDate)
         End If
         .UserStatus = 1
         .UserGroup = 41
         .GroupID = reqGroupID
         .Referral = reqRefer
         .Timezone = -6
         If (reqMembership = 1) Then
            If (reqMasterID <> 0) Then
               .MasterID = reqMasterID
               .Price = tmpBusAcctPrice
               .Retail = tmpBusAcctRetail
               .Billing = 4
            End If
         End If
         If (reqMembership = 2) Then
            .Price = tmpBusPrice
            .Retail = tmpBusRetail
            .BusAccts = tmpBusAccts
            .BusAcctPrice = tmpBusAcctPrice
            .BusAcctRetail = tmpBusAcctRetail
            .Billing = 3
            .IsMaster = 1
         End If
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
   If oAddress Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
   Else
      With oAddress
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CountryID = 224
         xmlAddress = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAddress = Nothing
   LoadCountry
End Sub

Sub LoadCountry()
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

Sub ValidLogon()
   On Error Resume Next
   tmpNewLogon = Request.Form.Item("NewLogon")
   tmpNewPassword = Request.Form.Item("NewPassword")
   If (xmlError = "") And (Len(tmpNewLogon) > 0) And (Len(tmpNewLogon) < 3) Then
      DoError 10101, "", "Oops, Your Logon Name must be at least three characters/numbers long."
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
         DoError -2147220513, "", "Oops, The Logon is not available.  Please select another or contact Member Support for assistance."
      End If
   End If
End Sub

Sub ValidEmail()
   On Error Resume Next
   tmpEmail = Request.Form.Item("Email")

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         MemberID = CLng(.ExistEmail(CLng(reqCompanyID), tmpEmail))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (MemberID <> 0) Then

            Response.Redirect "0406.asp" & "?CompanyID=" & reqCompanyID & "&MemberID=" & MemberID & "&Email=" & tmpEmail
         End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub ValidAddress()
   On Error Resume Next
   tmpStreet1 = Request.Form.Item("Street1")

   If (tmpStreet1 <> "") Then
      Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
      If oAddress Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
      Else
         With oAddress
            .SysCurrentLanguage = reqSysLanguage
            .OwnerType = 04
            .OwnerID = -1
            .AddressType = 2

            .Street1 = Request.Form.Item("Street1")
            .Street2 = Request.Form.Item("Street2")
            .City = Request.Form.Item("City")
            .State = Request.Form.Item("State")
            .Zip = Request.Form.Item("Zip")
            .CountryID = Request.Form.Item("CountryID")
            .Validate 1, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAddress = Nothing
   End If
End Sub

Sub AddMember()
   On Error Resume Next

   If (xmlError = "") Then
      Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
      If oAddress Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
      Else
         With oAddress
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .OwnerType = 04
            .OwnerID = reqMemberID
            .AddressType = 2

            .Street1 = Request.Form.Item("Street1")
            .Street2 = Request.Form.Item("Street2")
            .City = Request.Form.Item("City")
            .State = Request.Form.Item("State")
            .Zip = Request.Form.Item("Zip")
            .CountryID = Request.Form.Item("CountryID")
            If (xmlError <> "") Then
               xmlAddress = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oAddress = Nothing
   End If
   tmpReferralID = Numeric(GetCache("A"))

   If (tmpReferralID <> 0) And (reqGroupID = 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpReferralID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqGroupID = .GroupID
         End With
      End If
      Set oMember = Nothing
   End If

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .Email = Request.Form.Item("Email")
         .CompanyName = Request.Form.Item("CompanyName")
         .Reference = Request.Form.Item("Reference")
         .Referral = Request.Form.Item("Referral")
         .NewLogon = Request.Form.Item("NewLogon")
         .NewPassword = Request.Form.Item("NewPassword")
         .Secure = Request.Form.Item("Secure")
         .Options = Request.Form.Item("Options")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
         .Fax = Request.Form.Item("Fax")
         .Timezone = Request.Form.Item("Timezone")
         .EnrollDate = Request.Form.Item("EnrollDate")
         .Status = Request.Form.Item("Status")
         .TrialDays = Request.Form.Item("TrialDays")
         .Price = Request.Form.Item("Price")
         .InitPrice = Request.Form.Item("InitPrice")
         .Retail = Request.Form.Item("Retail")
         .IsDiscount = Request.Form.Item("IsDiscount")
         .Discount = Request.Form.Item("Discount")
         .BusAccts = Request.Form.Item("BusAccts")
         .BusAcctPrice = Request.Form.Item("BusAcctPrice")
         .BusAcctRetail = Request.Form.Item("BusAcctRetail")
         .IsMaster = Request.Form.Item("IsMaster")
         .IsCompany = Request.Form.Item("IsCompany")
         .Billing = Request.Form.Item("Billing")
         .PromoID = Request.Form.Item("PromoID")
         .CompanyID = Request.Form.Item("CompanyID")
         .ReferralID = Request.Form.Item("ReferralID")
         .SponsorID = Request.Form.Item("SponsorID")
         .AccessLimit = Request.Form.Item("AccessLimit")
         .QuizLimit = Request.Form.Item("QuizLimit")
         .PromoID = Request.Form.Item("PromoID")
         .Billing = Request.Form.Item("Billing")
         .UserGroup = Request.Form.Item("UserGroup")
         .UserStatus = Request.Form.Item("UserStatus")
         tmpPrice =  CCUR(.Price) + CCUR(.InitPrice) 
         .GroupID = reqGroupID
         .Icons = Request.Form.Item("Icons")
         .CompanyID = reqCompanyID
         .MasterID = reqMasterID
         If (reqStatus <> 3) Then
            reqBilling = .Billing
         End If
         If (reqStatus = 3) Then
            reqBilling = 0
         End If
         If (reqStatus = 2) Then
            .PaidDate = DATEADD("d", .TrialDays, reqSysDate)
         End If
         .Level = reqLevel
         
         If .CompanyName <> "" Then .IsCompany = "1"
         If .CompanyName = "" Then .CompanyName = .NameLast + ", " + .NameFirst

         .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
         .NotifyMentor = "ABCDEFG"
         If (tmpReferralID <> 0) Then
            .ReferralID = tmpReferralID
            .MentorID = tmpReferralID
            .SponsorID = tmpReferralID
         End If
         reqMemberID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (.Title <> 0) Then

            Set oMemberTitle = server.CreateObject("ptsMemberTitleUser.CMemberTitle")
            If oMemberTitle Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberTitleUser.CMemberTitle"
            Else
               With oMemberTitle
                  .SysCurrentLanguage = reqSysLanguage
                  .MemberID = reqMemberID
                  .TitleDate = Now
                  .Title = oMember.Title
                  .Add CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oMemberTitle = Nothing
         End If
         If (.IsMaster = 1) Then
            .MasterID = reqMemberID
            If (xmlError = "") Then
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
      End With
   End If
   Set oMember = Nothing

   If (xmlError = "") Then
      Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
      If oAddress Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
      Else
         With oAddress
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .OwnerType = 04
            .OwnerID = reqMemberID
            .AddressType = 2

            .Street1 = Request.Form.Item("Street1")
            .Street2 = Request.Form.Item("Street2")
            .City = Request.Form.Item("City")
            .State = Request.Form.Item("State")
            .Zip = Request.Form.Item("Zip")
            .CountryID = Request.Form.Item("CountryID")
            If (.Street1 <> "") Then
               tmpAddressID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oAddress = Nothing
   End If
End Sub

Sub LoadMember()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .Email = Request.Form.Item("Email")
         .CompanyName = Request.Form.Item("CompanyName")
         .Reference = Request.Form.Item("Reference")
         .Referral = Request.Form.Item("Referral")
         .NewLogon = Request.Form.Item("NewLogon")
         .NewPassword = Request.Form.Item("NewPassword")
         .Secure = Request.Form.Item("Secure")
         .Options = Request.Form.Item("Options")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
         .Fax = Request.Form.Item("Fax")
         .Timezone = Request.Form.Item("Timezone")
         .EnrollDate = Request.Form.Item("EnrollDate")
         .Status = Request.Form.Item("Status")
         .TrialDays = Request.Form.Item("TrialDays")
         .Price = Request.Form.Item("Price")
         .InitPrice = Request.Form.Item("InitPrice")
         .Retail = Request.Form.Item("Retail")
         .IsDiscount = Request.Form.Item("IsDiscount")
         .Discount = Request.Form.Item("Discount")
         .BusAccts = Request.Form.Item("BusAccts")
         .BusAcctPrice = Request.Form.Item("BusAcctPrice")
         .BusAcctRetail = Request.Form.Item("BusAcctRetail")
         .IsMaster = Request.Form.Item("IsMaster")
         .IsCompany = Request.Form.Item("IsCompany")
         .Billing = Request.Form.Item("Billing")
         .PromoID = Request.Form.Item("PromoID")
         .CompanyID = Request.Form.Item("CompanyID")
         .ReferralID = Request.Form.Item("ReferralID")
         .SponsorID = Request.Form.Item("SponsorID")
         .AccessLimit = Request.Form.Item("AccessLimit")
         .QuizLimit = Request.Form.Item("QuizLimit")
         .PromoID = Request.Form.Item("PromoID")
         .Billing = Request.Form.Item("Billing")
         .UserGroup = Request.Form.Item("UserGroup")
         .UserStatus = Request.Form.Item("UserStatus")
         .Icons = Request.Form.Item("Icons")
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
   If oAddress Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
   Else
      With oAddress
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .Street1 = Request.Form.Item("Street1")
         .Street2 = Request.Form.Item("Street2")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .CountryID = Request.Form.Item("CountryID")
         xmlAddress = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAddress = Nothing
   LoadCountry
End Sub

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If
tmpPrice = 0
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      NewMember

   Case CLng(cActionAdd):
      LoadCompanyOptions
      If (InStr(reqSysUserOptions,"k") = 0) Then
         ValidEmail
      End If
      If (xmlError = "") Then
         ValidLogon
      End If
      If (xmlError = "") Then
         ValidAddress
      End If
      If (xmlError = "") Then
         Addmember
      End If
      If (xmlError <> "") Then
         LoadMember
      End If
      If (xmlError = "") Then

         If (reqBilling = 3) And (tmpPrice <> 0) Then
            If reqSysServerName <> "localhost" Then
               tmpRedirect = "https://" + reqSysServerName + reqSysServerPath
            End If
            Response.Redirect tmpRedirect + "2902.asp" & "?MemberID=" & reqMemberID & "&NextURL=" & "0413.asp?Enroll=1" & "%26MemberID=" & reqMemberID & "%26Membership=" & reqMembership & "%26Status=" & reqStatus
         End If

         If (reqBilling <> 3) Or (tmpPrice = 0) Then
            Response.Redirect "0413.asp" & "?Enroll=" & 1 & "&MemberID=" & reqMemberID & "&MemberShip=" & reqMembership & "&Status=" & reqStatus & "&Txn=" & 1
         End If
      End If

   Case CLng(cActionCancel):

      Response.Redirect "0000.asp"
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
xmlParam = xmlParam + " masterid=" + Chr(34) + CStr(reqMasterID) + Chr(34)
xmlParam = xmlParam + " membership=" + Chr(34) + CStr(reqMembership) + Chr(34)
xmlParam = xmlParam + " status=" + Chr(34) + CStr(reqStatus) + Chr(34)
xmlParam = xmlParam + " level=" + Chr(34) + CStr(reqLevel) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " refer=" + Chr(34) + CleanXML(reqRefer) + Chr(34)
xmlParam = xmlParam + " refname=" + Chr(34) + CleanXML(reqRefName) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " billing=" + Chr(34) + CStr(reqBilling) + Chr(34)
xmlParam = xmlParam + " isreferral=" + Chr(34) + CStr(reqIsReferral) + Chr(34)
xmlParam = xmlParam + " price=" + Chr(34) + CStr(reqPrice) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlAddress
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Member[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Member[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0412 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0412 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0412 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0412.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0412 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0412 Load file (oData) failed with error code " + CStr(oData.parseError)
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
<!--#include file="Include\System.asp"-->
<!--#include file="Include\Email.asp"-->
<!--#include file="Include\Billing.asp"-->
<!--#include file="Include\Payment.asp"-->
<!--#include file="Include\Wallet.asp"-->
<!--#include file="Include\iPayout.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\CommissionEmail.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionSubmit = 1
Const cActionProcess = 2
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
Dim oCoption, xmlCoption
Dim oCountrys, xmlCountrys
Dim oHTMLFile, xmlHTMLFile
Dim oMember, xmlMember
Dim oAddress, xmlAddress
Dim oPayment, xmlPayment
Dim oCountry, xmlCountry
Dim oBilling, xmlBilling
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqNewMemberID
Dim reqBillingID
Dim reqPayID
Dim reqGroupID
Dim reqReferID
Dim reqIsAgree
Dim reqIsAgree2
Dim reqPayType
Dim reqReferredBy
Dim reqTitle
Dim reqMembership
Dim reqMship
Dim reqOrderOption
Dim reqRetail
Dim reqPaymentOptions
Dim reqOption
Dim reqBilling
Dim reqBillDay
Dim reqReference
Dim reqOptFld1
Dim reqNoBill
Dim reqNoBanner
Dim reqNoPayment
Dim reqNoRefer
Dim reqNoValidate
Dim reqTextEmail
Dim reqNoPayout
Dim reqGetMemberID
Dim reqBillOneTime
Dim reqAutoShipMonths
Dim reqRegisterWallet
Dim reqM
Dim reqS
Dim reqC
Dim reqS3
Dim reqPos
Dim reqPlacement
Dim reqStreet1b
Dim reqStreet2b
Dim reqCityb
Dim reqStateb
Dim reqZipb
Dim reqCountryIDb
Dim reqCountryID
Dim reqCountryName
Dim reqCountryNameb
Dim reqTokenType
Dim reqTokenOwner
Dim reqToken
Dim reqPayDesc
Dim reqMode
Dim reqBadPayment
Dim reqCashPayment
Dim reqWallet
Dim reqNotifyCompany
Dim reqIsCaptcha
Dim reqCaptcha
Dim req2KUserID
Dim reqPXSponsorID
Dim reqxID
Dim reqxSponsorID
Dim reqFirstName
Dim reqLastName
Dim reqUserName
Dim reqEmailAddress
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
   SetCache "RegisterURL", reqReturnURL
   SetCache "RegisterDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "register")
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
reqNewMemberID =  Numeric(GetInput("NewMemberID", reqPageData))
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqPayID =  Numeric(GetInput("PayID", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqReferID =  Numeric(GetInput("ReferID", reqPageData))
reqIsAgree =  Numeric(GetInput("IsAgree", reqPageData))
reqIsAgree2 =  Numeric(GetInput("IsAgree2", reqPageData))
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqReferredBy =  GetInput("ReferredBy", reqPageData)
reqTitle =  Numeric(GetInput("Title", reqPageData))
reqMembership =  Numeric(GetInput("Membership", reqPageData))
reqMship =  Numeric(GetInput("Mship", reqPageData))
reqOrderOption =  Numeric(GetInput("OrderOption", reqPageData))
reqRetail =  Numeric(GetInput("Retail", reqPageData))
reqPaymentOptions =  GetInput("PaymentOptions", reqPageData)
reqOption =  Numeric(GetInput("Option", reqPageData))
reqBilling =  Numeric(GetInput("Billing", reqPageData))
reqBillDay =  Numeric(GetInput("BillDay", reqPageData))
reqReference =  GetInput("Reference", reqPageData)
reqOptFld1 =  GetInput("OptFld1", reqPageData)
reqNoBill =  Numeric(GetInput("NoBill", reqPageData))
reqNoBanner =  Numeric(GetInput("NoBanner", reqPageData))
reqNoPayment =  Numeric(GetInput("NoPayment", reqPageData))
reqNoRefer =  Numeric(GetInput("NoRefer", reqPageData))
reqNoValidate =  Numeric(GetInput("NoValidate", reqPageData))
reqTextEmail =  Numeric(GetInput("TextEmail", reqPageData))
reqNoPayout =  Numeric(GetInput("NoPayout", reqPageData))
reqGetMemberID =  Numeric(GetInput("GetMemberID", reqPageData))
reqBillOneTime =  Numeric(GetInput("BillOneTime", reqPageData))
reqAutoShipMonths =  Numeric(GetInput("AutoShipMonths", reqPageData))
reqRegisterWallet =  Numeric(GetInput("RegisterWallet", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqS =  Numeric(GetInput("S", reqPageData))
reqC =  Numeric(GetInput("C", reqPageData))
reqS3 =  Numeric(GetInput("S3", reqPageData))
reqPos =  Numeric(GetInput("Pos", reqPageData))
reqPlacement =  GetInput("Placement", reqPageData)
reqStreet1b =  GetInput("Street1b", reqPageData)
reqStreet2b =  GetInput("Street2b", reqPageData)
reqCityb =  GetInput("Cityb", reqPageData)
reqStateb =  GetInput("Stateb", reqPageData)
reqZipb =  GetInput("Zipb", reqPageData)
reqCountryIDb =  GetInput("CountryIDb", reqPageData)
reqCountryID =  GetInput("CountryID", reqPageData)
reqCountryName =  GetInput("CountryName", reqPageData)
reqCountryNameb =  GetInput("CountryNameb", reqPageData)
reqTokenType =  Numeric(GetInput("TokenType", reqPageData))
reqTokenOwner =  Numeric(GetInput("TokenOwner", reqPageData))
reqToken =  Numeric(GetInput("Token", reqPageData))
reqPayDesc =  GetInput("PayDesc", reqPageData)
reqMode =  Numeric(GetInput("Mode", reqPageData))
reqBadPayment =  Numeric(GetInput("BadPayment", reqPageData))
reqCashPayment =  Numeric(GetInput("CashPayment", reqPageData))
reqWallet =  GetInput("Wallet", reqPageData)
reqNotifyCompany =  GetInput("NotifyCompany", reqPageData)
reqIsCaptcha =  Numeric(GetInput("IsCaptcha", reqPageData))
reqCaptcha =  GetInput("Captcha", reqPageData)
req2KUserID =  GetInput("2KUserID", reqPageData)
reqPXSponsorID =  GetInput("PXSponsorID", reqPageData)
reqxID =  GetInput("xID", reqPageData)
reqxSponsorID =  GetInput("xSponsorID", reqPageData)
reqFirstName =  GetInput("FirstName", reqPageData)
reqLastName =  GetInput("LastName", reqPageData)
reqUserName =  GetInput("UserName", reqPageData)
reqEmailAddress =  GetInput("EmailAddress", reqPageData)
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
         .FetchCompany reqCompanyID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqSysUserOptions = .Options
      End With
   End If
   Set oCoption = Nothing
End Sub

Sub LoadCountrys()
   On Error Resume Next

   Set oCountrys = server.CreateObject("ptsCountryUser.CCountrys")
   If oCountrys Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountrys"
   Else
      With oCountrys
         .SysCurrentLanguage = reqSysLanguage
         xmlCountrys = .EnumCompany(reqCompanyID, , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCountrys = Nothing
End Sub

Sub LoadPaymentOptions()
   On Error Resume Next

   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany reqCompanyID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqPaymentOptions = .PaymentOptions
      End With
   End If
   Set oCoption = Nothing
End Sub

Sub LoadAgree()
   On Error Resume Next

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Enroll.htm"
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

   If (reqReferID = 0) And (reqxSponsorID <> "") Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .FetchRef reqCompanyID, reqxSponsorID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferID = .MemberID
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqReferID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqReferID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.IsCompany = 0) Then
               reqReferredBy = .NameFirst + " " + .NameLast
            End If
            If (.IsCompany <> 0) Then
               reqReferredBy = .CompanyName
            End If
            
                  If InStr( ValidMemberStatus, .Status ) = 0 Then
                  Response.Write "The Member that referred you here is Inactive! (" + reqReferredBy + " #" + CStr(reqM) + ")"
                  Response.End
                  End If
               
            If (reqS3 <> 0) Then
               .Load reqS3, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqPlacement = TRIM(.NameFirst + " " + .NameLast)
               If (reqPos = 0) Then
                  reqPlacement = reqPlacement + " (Left Side)"
               End If
               If (reqPos <> 0) Then
                  reqPlacement = reqPlacement + " (Right Side)"
               End If
            End If
         End With
      End If
      Set oMember = Nothing
   End If
End Sub

Sub ValidLogon()
   On Error Resume Next
   tmpNewLogon = Request.Form.Item("NewLogon")
   tmpNewPassword = Request.Form.Item("NewPassword")
   If (xmlError = "") And (Len(tmpNewLogon) < 6) Then
      DoError 10101, "", "Oops, Your Logon Name must be at least six characters/numbers long."
   End If
   If (xmlError = "") And (Len(tmpNewPassword) < 6) Then
      DoError 10102, "", "Oops, Your Password must be at least six characters/numbers long."
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
         DoError -2147220513, "", "Oops, The Logon/Website Name is not available.  Please select another or contact Member Support for assistance."
      End If
   End If
End Sub

Sub ValidAddress()
   On Error Resume Next

   If (xmlError = "") Then
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

Sub ValidPhone()
   On Error Resume Next
   tmpPhone = Request.Form.Item("Phone1")
   If (tmpPhone = "") Then
      DoError 10006, "", "Oops, Phone Number is Required."
   End If
End Sub

Sub ValidBilling()
   On Error Resume Next
   tmpPayType = Request.Form.Item("PayType")
   tmpCardNumber = Request.Form.Item("CardNumber")
   tmpCheckRoute = Request.Form.Item("CheckRoute")

   If (tmpPayType = 5) Then
      Set oPayment = server.CreateObject("wtPayment.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtPayment.CPayment"
      Else
         With oPayment
            result = CLng(.ValidCheckRoute(tmpCheckRoute))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (result = 0) Then
               DoError 10007, "", "Oops, Invalid Check Routing Number."
            End If
         End With
      End If
      Set oPayment = Nothing
   End If

   If (tmpPayType <= 4) Then
      Set oPayment = server.CreateObject("wtPayment.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtPayment.CPayment"
      Else
         With oPayment
            result = CLng(.ValidCardNumber(tmpCardNumber))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (result < 0) Then
               DoError 10008, "", "Oops, Invalid Length of Credit Card Number."
            End If
            If (result = 0) Then
               DoError 10009, "", "Oops, Invalid Credit Card Number."
            End If
            If (result >= 1) And (result <= 4) And (CLng(result) <> CLng(tmpPayType)) Then
               tmpPayType = CLng(result)
               reqPayType = CLng(result)
            End If
            If (result > 4) Then
               DoError 10012, "", "Oops, Invalid Credit Card Type."
            End If
         End With
      End If
      Set oPayment = Nothing
   End If
   If (xmlError = "") And (tmpPayType <= 4) Then
      tmpCardMo = Request.Form.Item("CardMo")
      tmpCardYr = Request.Form.Item("CardYr")
      tmpCardDate = tmpCardMo + "/1/" + tmpCardYr
      tmpCardDate = DATEADD("m", 1, tmpCardDate)
      If (CDate(tmpCardDate) < CDate(reqSysDate)) Then
         DoError 10013, "", "Oops, Credit Card date has expired."
      End If
   End If
   tmpCountryID = Request.Form.Item("CountryIDb")
   tmpCountryCode = ""

   If (tmpCountryID <> 0) Then
      Set oCountry = server.CreateObject("ptsCountryUser.CCountry")
      If oCountry Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountry"
      Else
         With oCountry
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpCountryID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCountryCode = .Code
         End With
      End If
      Set oCountry = Nothing
   End If

   If (xmlError = "") Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load reqBillingID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (tmpPayType <= 4) Then
               .PayType = 1
               .CardType = tmpPayType
               .CardNumber = Request.Form.Item("CardNumber")
               .CardMo = Request.Form.Item("CardMo")
               .CardYr = Request.Form.Item("CardYr")
               .CardName = Request.Form.Item("CardName")
               .CardCode = Request.Form.Item("CardCode")
               .Zip = Request.Form.Item("CardZip")
            End If
            If (tmpPayType = 5) Then
               .PayType = 2
               .CheckBank = Request.Form.Item("CheckBank")
               .CheckRoute = Request.Form.Item("CheckRoute")
               .CheckAccount = Request.Form.Item("CheckAccount")
               .CheckAcctType = Request.Form.Item("CheckAcctType")
               .CheckName = Request.Form.Item("CheckName")
            End If
            If (tmpPayType = 7) Then
               .PayType = 3
            End If
            If (tmpPayType >= 11) Then
               .PayType = 4
               .CardType = tmpPayType
               .CardName = Request.Form.Item("Wallet")
            End If
            If (xmlError = "") Then
               .Validate 1, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (xmlError = "") Then
               tmpNameFirst = Request.Form.Item("NameFirst")
               tmpNameLast = Request.Form.Item("NameLast")
               .BillingName = tmpNameFirst + " " + tmpNameLast
               .Street1 = Request.Form.Item("Street1b")
               .Street2 = Request.Form.Item("Street2b")
               .City = Request.Form.Item("Cityb")
               .State = Request.Form.Item("Stateb")
               .Zip = Request.Form.Item("Zipb")
               .CountryID = Request.Form.Item("CountryIDb")
               If (xmlError = "") And (reqBillingID <> 0) Then
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (xmlError = "") And (reqBillingID = 0) Then
                  reqBillingID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               .CountryCode = tmpCountryCode
               If (xmlError = "") Then
                  If (reqCompanyID = 21) Then
                     .Token = SetVault( reqCompanyID, reqBillingID )
                  End If
                  reqPayDesc = BillingPayment( oBilling )
               End If
            End If
         End With
      End If
      Set oBilling = Nothing
   End If
End Sub

Sub AddMember()
   On Error Resume Next

   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany reqCompanyID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpPrice1 = .Price
         tmpPrice2 = .Price2
         tmpPrice3 = .Price3
         reqSysUserOptions = .Options
         tmpSendEmail = .IsNewEmail
         tmpCardProcessor = .MerchantCardType
         tmpCardAcct = .MerchantCardAcct
         tmpCheckProcessor = .MerchantCheckType
         tmpCheckAcct = .MerchantCheckAcct
         tmpWalletType = .WalletType
         tmpWalletAcct = .WalletAcct
         EmailBonuses = InStr(.Shopping, "N")
      End With
   End If
   Set oCoption = Nothing

   If (reqNoPayout = 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load reqPayID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (reqCompanyID = 21) Then
               .CommType = 4
               .CardType = 14
               .CardName = "Not Used"
            End If
            tmpNameFirst = Request.Form.Item("NameFirst")
            tmpNameLast = Request.Form.Item("NameLast")
            .BillingName = tmpNameFirst + " " + tmpNameLast
            .Street1 = Request.Form.Item("Street1")
            .Street2 = Request.Form.Item("Street2")
            .City = Request.Form.Item("City")
            .State = Request.Form.Item("State")
            .Zip = Request.Form.Item("Zip")
            .CountryID = Request.Form.Item("CountryID")
            If (reqPayID <> 0) Then
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqPayID = 0) Then
               reqPayID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oBilling = Nothing
   End If

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqReferID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqGroupID = .GroupID
         ReferEmail = .Email2
         If (InStr(ReferEmail, "@") = 0) Then
            ReferEmail = .Email
         End If
      End With
   End If
   Set oMember = Nothing

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         .Load reqCompanyID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         CompanyEmail = .Email
         If (reqNotifyCompany <> "") Then
            reqNotifyCompany = .Email
         End If
      End With
   End If
   Set oCompany = Nothing

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqNewMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .CompanyName = Request.Form.Item("CompanyName")
         .Email = Request.Form.Item("Email")
         .Email2 = Request.Form.Item("Email2")
         .Phone1 = Request.Form.Item("Phone1")
         .NewLogon = Request.Form.Item("NewLogon")
         .NewPassword = Request.Form.Item("NewPassword")
         .AccessLimit = "NONE"
         .Price = tmpPrice
         BillingPrice = .Price
         If (reqBillDay = 0) Then
            .PaidDate = reqSysDate
         End If
         If (reqBillDay <> 0) Then
            
                     mo = DATEPART( "m", DATE())
                     yr = DATEPART( "yyyy", DATE())
                     If reqBillDay = 1 Then
                        tmpDate = CSTR(mo) + "/1/" + CSTR(yr)
                        .PaidDate = DateAdd( "m", 1, tmpDate )
                     Else
                        .PaidDate = CSTR(mo) + "/" + CSTR(reqBillDay) + "/" + CSTR(yr)
                     End If
                  
         End If
         .Status = 0
         Purpose = "Enrollment"
         If (reqCompanyID = 21) Then
            .Level = 1
            .Qualify = 2
            .Title = 2
            .Options2 = ""
            Purpose = ""
            .Price = 0
            .InitPrice = 0
            BillingPrice = 0
            If (reqMembership = 1) Then
               .Options2 = "101"
               Purpose = "101"
               .Price = 10
               .InitPrice = 10
               BillingPrice = 11
               If (reqPayType = 14) Or (reqPayType = 16) Then
                  BillingPrice = 10
               End If
            End If
            If (reqMembership = 2) Then
               .Options2 = "102"
               Purpose = "102"
               .Price = 25
               .InitPrice = 25
               BillingPrice = 27
               If (reqPayType = 14) Or (reqPayType = 16) Then
                  BillingPrice = 25
               End If
            End If
            If (reqMembership = 3) Then
               .Options2 = "103"
               Purpose = "103"
               .Price = 50
               .InitPrice = 50
               BillingPrice = 53
               If (reqPayType = 14) Or (reqPayType = 16) Then
                  BillingPrice = 50
               End If
            End If
            If (reqMembership = 4) Then
               .Options2 = "106"
               Purpose = "106"
               .Price = 10
               .InitPrice = 10
               BillingPrice = 11
               If (reqPayType = 14) Or (reqPayType = 16) Then
                  BillingPrice = 10
               End If
            End If
            If (reqMembership = 5) Then
               .Options2 = "107"
               Purpose = "107"
               .Price = 25
               .InitPrice = 25
               BillingPrice = 27
               If (reqPayType = 14) Or (reqPayType = 16) Then
                  BillingPrice = 25
               End If
            End If
            If (reqMembership = 6) Then
               .Options2 = "108"
               Purpose = "108"
               .Price = 50
               .InitPrice = 50
               BillingPrice = 53
               If (reqPayType = 14) Or (reqPayType = 16) Then
                  BillingPrice = 50
               End If
            End If
         End If
         If (reqNewMemberID <> 0) Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqNewMemberID = 0) Then
            .CompanyID = reqCompanyID
            .EnrollDate = Now
            .UserStatus = 1
            .UserGroup = 41
            If (reqBilling <> 0) Then
               .Billing = reqBilling
            End If
            If (reqBilling = 0) Then
               .Billing = 3
               If (reqNoBill <> 0) Then
                  .Billing = 1
               End If
            End If
            .BillingID = reqBillingID
            .PayID = reqPayID
            .GroupID = reqGroupID
            If (.CompanyName = "") Then
               .CompanyName = .NameLast + ", " + .NameFirst
            End If
            .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
            .NotifyMentor = "ABCDEFGHI"
            If (reqxID <> "") Then
               .Reference = reqxID
            End If
            .ReferralID = reqReferID
            .MentorID = reqReferID
            If (reqS3 <> 0) Then
               .Sponsor3ID = reqS3
               .Pos = reqPos
            End If
            reqNewMemberID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") And (reqBillingID <> 0) And (BillingPrice <> 0) And (reqNoBill = 0) Then
            PostProcess = 0
            PaymentID = 0
            
              tmpProcessor = 0
              tmpAcct = ""
              Select Case reqPayType
                Case 1, 2, 3, 4   'Process Credit Cards
                  tmpProcessor = tmpCardProcessor
                  tmpAcct = tmpCardAcct
                Case 5 'Process Electronic Checks
                  tmpProcessor = tmpCheckProcessor
                  tmpAcct = tmpCheckAcct
                Case 11, 12, 13 'Process Wallets
                  tmpProcessor = GetWalletProcessor( tmpWalletType, tmpWalletAcct, reqPayType, tmpAcct )
              End Select
              tmpPayType = reqPayType
              'Billing Nexxus Coin (16) = Payment Nexxus Coin (21)
              If tmpPayType = 16 Then tmpPayType = 21
            
            Result = GetPayment( reqCompanyID, reqNewMemberID, 0, reqPayType, reqPayDesc, BillingPrice, Purpose, tmpProcessor, tmpAcct, PostProcess, EmailBonuses )
            If (IsNumeric(Result) = 0) Then
               DoError 0, "", Result
            End If
            If (IsNumeric(Result) <> 0) Then
               PaymentID = CLng(Result)
               If (reqBillOneTime <> 1) Then
                  If (reqAutoShipMonths = 0) Then
                     .PaidDate = DATEADD("m", 1, .PaidDate)
                  End If
                  If (reqAutoShipMonths <> 0) Then
                     .PaidDate = DATEADD("m", reqAutoShipMonths, .PaidDate)
                  End If
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End If
         If (xmlError = "") And (tmpSendEmail <> 0) Then
            
                     Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
                     If oHTTP Is Nothing Then
                     Response.Write "Error #" & Err.number & " - " + Err.description
                     Else
                     oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0105.asp?AuthUserID=" & .AuthUserID
                     oHTTP.send
                     End If
                     Set oHTTP = Nothing
                  
         End If
         If (xmlError = "") Then
            If (ReferEmail <> "") Then
               tmpNameFirst = Request.Form.Item("NameFirst")
               tmpNameLast = Request.Form.Item("NameLast")
               tmpEmail = Request.Form.Item("Email")
               
                       tmpSubject = "NEW REFERRED MEMBER: " + tmpNameFirst + " " + tmpNameLast + " - " + tmpEmail
                       tmpBody = ""
                       SendEmail reqCompanyID, CompanyEmail, CompanyEmail, ReferEmail, "", "", tmpSubject, tmpBody
                    
            End If
            If (reqCompanyID = 21) And (reqxID <> "") Then
               
                       Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
                       If oHTTP Is Nothing Then
                          Response.Write "Error #" & Err.number & " - " + Err.description
                       Else
                          oHTTP.open "GET", "HTTPS://www.2konnect.net/service/nexxus.aspx?PartnerID=N37934SX87L7TSC7&KUserID=" + reqxID + "&PXUserID=" + CSTR(reqNewMemberID)
                  oHTTP.send
                       End If
                       Set oHTTP = Nothing
                    
            End If
            If (reqNotifyCompany <> "") Then
               tmpNameFirst = Request.Form.Item("NameFirst")
               tmpNameLast = Request.Form.Item("NameLast")
               tmpEmail = Request.Form.Item("Email")
               tmpPhone1 = Request.Form.Item("Phone1")
               tmpStreet1 = Request.Form.Item("Street1")
               tmpStreet2 = Request.Form.Item("Street2")
               tmpCity = Request.Form.Item("City")
               tmpState = Request.Form.Item("State")
               tmpZip = Request.Form.Item("Zip")
               
                       tmpSubject = "NEW MEMBER: " + tmpNameFirst + " " + tmpNameLast
                       tmpBody = tmpNameFirst + " " + tmpNameLast + "<BR>"
                       tmpBody = tmpBody + "Email: " + tmpEmail + "<BR>"
                       tmpBody = tmpBody + "Phone: " + tmpPhone1 + "<BR>"
                       tmpBody = tmpBody + tmpStreet1 + " " + tmpStreet2 + "<BR>"
                       tmpBody = tmpBody + tmpCity + ", " + tmpState + " " + tmpZip + "<BR>"
                       SendEmail reqCompanyID, reqNotifyCompany, reqNotifyCompany, reqNotifyCompany, "", "", tmpSubject, tmpBody
                    
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
            .OwnerID = reqNewMemberID
            .AddressType = 2
            .IsActive = 1

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

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            Count = CLng(.Custom(reqCompanyID, 100, 0, reqNewMemberID, 0))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCompany = Nothing
      If (reqBillingID <> 0) And (BillingPrice <> 0) And (reqNoBill = 0) Then

         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(reqCompanyID, 99, 0, PaymentID, 0))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCompany = Nothing
         If (EmailBonuses <> 0) Then
            CommissionEmail reqCompanyID, PaymentID, 0, 0, tmpTotal
         End If
      End If
   End If
   If (xmlError <> "") And (reqNewMemberID <> 0) Then
      LogMemberNote reqNewMemberID, "ENROLL ERROR: " + err.description + xmlError
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
         .Load reqNewMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .CompanyName = Request.Form.Item("CompanyName")
         .Email = Request.Form.Item("Email")
         .Email2 = Request.Form.Item("Email2")
         .Phone1 = Request.Form.Item("Phone1")
         .NewLogon = Request.Form.Item("NewLogon")
         .NewPassword = Request.Form.Item("NewPassword")
         If (.NameFirst = "") Then
            .NameFirst = reqFirstName
         End If
         If (.NameLast = "") Then
            .NameLast = reqLastName
         End If
         If (.Email = "") Then
            .Email = reqEmailAddress
         End If
         If (.NewLogon = "") Then
            .NewLogon = reqUserName
         End If
         xmlMember = .XML()
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
         If (Len(.CountryID) = 0) Then
            .CountryID = 224
         End If
         xmlAddress = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAddress = Nothing

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .PayType = Request.Form.Item("PayType")
         If (.PayType = "") Or (.PayType = "0") Then
            .PayType = reqPayType
         End If

         .CardNumber = Request.Form.Item("CardNumber")
         .CardMo = Request.Form.Item("CardMo")
         .CardYr = Request.Form.Item("CardYr")
         .CardName = Request.Form.Item("CardName")
         .CardCode = Request.Form.Item("CardCode")
         .CheckBank = Request.Form.Item("CheckBank")
         .CheckRoute = Request.Form.Item("CheckRoute")
         .CheckAccount = Request.Form.Item("CheckAccount")
         .CheckAcctType = Request.Form.Item("CheckAcctType")
         .CheckName = Request.Form.Item("CheckName")
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

Sub LoadLists()
   On Error Resume Next
   LoadAgree
   LoadCountrys
   LoadPaymentOptions

   If (xmlError = "") Then
      Set oCountry = server.CreateObject("ptsCountryUser.CCountry")
      If oCountry Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountry"
      Else
         With oCountry
            .SysCurrentLanguage = reqSysLanguage
            .Load reqCountryID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCountryName = .CountryName
            reqCountryNameb = .CountryName
            If (reqCountryID <> reqCountryIDb) Then
               .Load reqCountryIDb, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqCountryNameb = .CountryName
            End If
         End With
      End If
      Set oCountry = Nothing
   End If
End Sub

Sub DuplicateEmail()
   On Error Resume Next
   tmpEmail = Request.Form.Item("Email")

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         MemberID = CLng(.ExistEmail(reqCompanyID, tmpEmail))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (MemberID <> 0) Then
            DoError 10123, "", "Oops, This email address is already assigned to someone else."
         End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub ValidateContact()
   On Error Resume Next
   If (xmlError = "") Then
      LoadCompanyOptions
   End If
   tmpNameFirst = Request.Form.Item("NameFirst")
   tmpNameLast = Request.Form.Item("NameLast")
   tmpCountryID = Request.Form.Item("CountryID")
   tmpCompanyName = Request.Form.Item("CompanyName")
   If (xmlError = "") And (tmpNameFirst = "") Then
      DoError 10125, "", "Oops, Please enter a First Name."
   End If
   If (xmlError = "") And (tmpNameLast = "") Then
      DoError 10126, "", "Oops, Please enter a Last Name."
   End If
   If (xmlError = "") Then
      tmpEmail = Request.Form.Item("Email")
      
                  If ValidEmail( tmpEmail ) = 0 Then DoError 10122, "", "Oops, Invalid Email Address."
               
   End If
   If (xmlError = "") And (InStr(reqSysUserOptions,"k") = 0) Then
      DuplicateEmail
   End If
   If (xmlError = "") Then
      tmpPassword = Request.Form.Item("NewPassword")
      If (LEN(tmpPassword) < 6) Then
         DoError 10124, "", "Oops, Please enter at least 6 characters for the Password."
      End If
   End If
   If (xmlError = "") Then
      ValidAddress
   End If
   If (xmlError = "") Then
      ValidPhone
   End If
   If (xmlError = "") Then
      ValidLogon
   End If
End Sub

Sub ValidateMembership()
   On Error Resume Next
End Sub

Sub ValidatePayment()
   On Error Resume Next
   If (reqNoBill = 0) And (reqNoPayment = 0) Then
      tmpCardNumber = Request.Form.Item("CardNumber")
      tmpCardNumber = lcase(tmpCardNumber)
      If (reqIsAgree2 = 0) Then
         DoError 10128, "", "Oops, You must agree to the payment terms."
      End If
      If (xmlError = "") Then
         ValidBilling
      End If
   End If
End Sub

Sub ValidateConfirm()
   On Error Resume Next
   If (reqIsCaptcha <> 0) Then
      TestCaptcha = Request.Form.Item("Captcha")
      
                  If IsEmpty(Session("ASPCAPTCHA")) or Trim(Session("ASPCAPTCHA")) = "" Then
                     DoError 0, "", "Oops, Your time has expired! Please reenter."
                  else
                     ' Uppercase fix for turkish charset
                     TestCaptcha = Replace(TestCaptcha, "i", "I", 1, -1, 1)
                     TestCaptcha = Replace(TestCaptcha, "I", "I", 1, -1, 1)
                     TestCaptcha = Replace(TestCaptcha, "i", "I", 1, -1, 1)
                     TestCaptcha = UCase(TestCaptcha)

                     If StrComp(TestCaptcha, Trim(Session("ASPCAPTCHA")), 1) <> 0 Then
                        DoError 0, "", "Oops, You entered the wrong security answer! Please reenter."
                        reqCaptcha = ""
                     End If
                     ' IMPORTANT: Must remove session value for security after the CAPTCHA test
                     Session("ASPCAPTCHA") = vbNullString
                     Session.Contents.Remove("ASPCAPTCHA")
                  End If
               
   End If
End Sub

If (reqC = 0) Then
   reqC = 21
End If
If (reqC <> 0) Then
   reqCompanyID = reqC
End If
If (reqC <> 0) Then
   reqCompanyID = reqC
End If
reqSysCompanyID = reqCompanyID
SetCache "COMPANYID", reqSysCompanyID
If (reqTitle = 0) Then
   reqTitle = 1
End If
If (reqM = 0) And (reqPXSponsorID = "") Then
   reqM = Numeric(GetCache("A"))
End If
If (reqM = 0) And (reqMemberID <> 0) Then
   reqM = reqMemberID
End If
If (req2KUserID <> "") Then
   reqxID = req2KUserID
End If
If (reqPXSponsorID <> "") Then
   reqM = reqPXSponsorID
End If
If (reqMship <> 0) And (reqMembership = 0) Then
   reqMembership = reqMship
End If
reqMemberID = reqM
If (reqReferID = 0) Then
   reqReferID = reqM
End If
If (reqS = 0) Then
   reqS = reqM
End If
If (reqCountryIDb = 0) Then
   reqCountryIDb = 224
End If
If (reqNoRefer <> 0) Then
   reqReferredBy = "No Referrer"
End If
ValidMemberStatus = "1234"
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
   reqCashPayment = 1
End If
If (reqS3 <> 0) Then

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         Result = CLng(.Custom(reqCompanyID, 206, 0, reqS3, reqM))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCompany = Nothing
   If (Result <> reqM) Then
      
                  Response.write "Invalid Enroller for this Binary Placement."
                  Response.end
               
   End If
End If
If (reqCompanyID = 21) Then
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqPayType = 0) Then
         reqPayType = 1
      End If
      If (reqCompanyID = 21) Then
         If (reqMembership = 0) And (reqPXSponsorID = "") Then
            reqMembership = 3
         End If
      End If
      If (reqCompanyID <> 21) Then
         If (reqMembership = 0) And (reqPXSponsorID = "") Then
            reqMembership = 1
         End If
      End If
      LoadMember
      LoadLists
      If (reqReferredBy <> "") Then
         reqMode = 1
      End If

   Case CLng(cActionSubmit):
      If (reqIsAgree = 0) Then
         DoError 10103, "", "Oops, You must agree to the terms and conditions."
      End If
      If (xmlError = "") Then
         ValidateContact
      End If
      If (xmlError = "") Then
         ValidateMembership
      End If
      If (xmlError = "") Then
         ValidatePayment
      End If
      If (xmlError = "") Then
         ValidateConfirm
      End If
      If (xmlError = "") Then
         reqMode = 5
      End If
      LoadMember
      If (xmlError <> "") Then
         LoadLists
      End If

   Case CLng(cActionProcess):
      If (xmlError = "") Then
         Addmember
      End If
      If (xmlError <> "") Then
         reqMode = 1
         LoadMember
         LoadLists
      End If
      If (xmlError = "") Then
         reqMode = 6
         tmpLogon = Request.Form.Item("NewLogon")
         tmpPassword = Request.Form.Item("NewPassword")

         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = "Welcome.htm"
               .Path = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID)
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlHTMLFile = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
              xmlHTMLFile = Replace( xmlHTMLFile, "{id}", CStr(reqNewMemberID) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{lgn}", tmpLogon )
              xmlHTMLFile = Replace( xmlHTMLFile, "{pwd}", tmpPassword )
            
            End With
         End If
         Set oHTMLFile = Nothing
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
xmlParam = xmlParam + " newmemberid=" + Chr(34) + CStr(reqNewMemberID) + Chr(34)
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " payid=" + Chr(34) + CStr(reqPayID) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " referid=" + Chr(34) + CStr(reqReferID) + Chr(34)
xmlParam = xmlParam + " isagree=" + Chr(34) + CStr(reqIsAgree) + Chr(34)
xmlParam = xmlParam + " isagree2=" + Chr(34) + CStr(reqIsAgree2) + Chr(34)
xmlParam = xmlParam + " paytype=" + Chr(34) + CStr(reqPayType) + Chr(34)
xmlParam = xmlParam + " referredby=" + Chr(34) + CleanXML(reqReferredBy) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CStr(reqTitle) + Chr(34)
xmlParam = xmlParam + " membership=" + Chr(34) + CStr(reqMembership) + Chr(34)
xmlParam = xmlParam + " mship=" + Chr(34) + CStr(reqMship) + Chr(34)
xmlParam = xmlParam + " orderoption=" + Chr(34) + CStr(reqOrderOption) + Chr(34)
xmlParam = xmlParam + " retail=" + Chr(34) + CStr(reqRetail) + Chr(34)
xmlParam = xmlParam + " paymentoptions=" + Chr(34) + CleanXML(reqPaymentOptions) + Chr(34)
xmlParam = xmlParam + " option=" + Chr(34) + CStr(reqOption) + Chr(34)
xmlParam = xmlParam + " billing=" + Chr(34) + CStr(reqBilling) + Chr(34)
xmlParam = xmlParam + " billday=" + Chr(34) + CStr(reqBillDay) + Chr(34)
xmlParam = xmlParam + " reference=" + Chr(34) + CleanXML(reqReference) + Chr(34)
xmlParam = xmlParam + " optfld1=" + Chr(34) + CleanXML(reqOptFld1) + Chr(34)
xmlParam = xmlParam + " nobill=" + Chr(34) + CStr(reqNoBill) + Chr(34)
xmlParam = xmlParam + " nobanner=" + Chr(34) + CStr(reqNoBanner) + Chr(34)
xmlParam = xmlParam + " nopayment=" + Chr(34) + CStr(reqNoPayment) + Chr(34)
xmlParam = xmlParam + " norefer=" + Chr(34) + CStr(reqNoRefer) + Chr(34)
xmlParam = xmlParam + " novalidate=" + Chr(34) + CStr(reqNoValidate) + Chr(34)
xmlParam = xmlParam + " textemail=" + Chr(34) + CStr(reqTextEmail) + Chr(34)
xmlParam = xmlParam + " nopayout=" + Chr(34) + CStr(reqNoPayout) + Chr(34)
xmlParam = xmlParam + " getmemberid=" + Chr(34) + CStr(reqGetMemberID) + Chr(34)
xmlParam = xmlParam + " billonetime=" + Chr(34) + CStr(reqBillOneTime) + Chr(34)
xmlParam = xmlParam + " autoshipmonths=" + Chr(34) + CStr(reqAutoShipMonths) + Chr(34)
xmlParam = xmlParam + " registerwallet=" + Chr(34) + CStr(reqRegisterWallet) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " s=" + Chr(34) + CStr(reqS) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " s3=" + Chr(34) + CStr(reqS3) + Chr(34)
xmlParam = xmlParam + " pos=" + Chr(34) + CStr(reqPos) + Chr(34)
xmlParam = xmlParam + " placement=" + Chr(34) + CleanXML(reqPlacement) + Chr(34)
xmlParam = xmlParam + " street1b=" + Chr(34) + CleanXML(reqStreet1b) + Chr(34)
xmlParam = xmlParam + " street2b=" + Chr(34) + CleanXML(reqStreet2b) + Chr(34)
xmlParam = xmlParam + " cityb=" + Chr(34) + CleanXML(reqCityb) + Chr(34)
xmlParam = xmlParam + " stateb=" + Chr(34) + CleanXML(reqStateb) + Chr(34)
xmlParam = xmlParam + " zipb=" + Chr(34) + CleanXML(reqZipb) + Chr(34)
xmlParam = xmlParam + " countryidb=" + Chr(34) + CleanXML(reqCountryIDb) + Chr(34)
xmlParam = xmlParam + " countryid=" + Chr(34) + CleanXML(reqCountryID) + Chr(34)
xmlParam = xmlParam + " countryname=" + Chr(34) + CleanXML(reqCountryName) + Chr(34)
xmlParam = xmlParam + " countrynameb=" + Chr(34) + CleanXML(reqCountryNameb) + Chr(34)
xmlParam = xmlParam + " tokentype=" + Chr(34) + CStr(reqTokenType) + Chr(34)
xmlParam = xmlParam + " tokenowner=" + Chr(34) + CStr(reqTokenOwner) + Chr(34)
xmlParam = xmlParam + " token=" + Chr(34) + CStr(reqToken) + Chr(34)
xmlParam = xmlParam + " paydesc=" + Chr(34) + CleanXML(reqPayDesc) + Chr(34)
xmlParam = xmlParam + " mode=" + Chr(34) + CStr(reqMode) + Chr(34)
xmlParam = xmlParam + " badpayment=" + Chr(34) + CStr(reqBadPayment) + Chr(34)
xmlParam = xmlParam + " cashpayment=" + Chr(34) + CStr(reqCashPayment) + Chr(34)
xmlParam = xmlParam + " wallet=" + Chr(34) + CleanXML(reqWallet) + Chr(34)
xmlParam = xmlParam + " notifycompany=" + Chr(34) + CleanXML(reqNotifyCompany) + Chr(34)
xmlParam = xmlParam + " iscaptcha=" + Chr(34) + CStr(reqIsCaptcha) + Chr(34)
xmlParam = xmlParam + " captcha=" + Chr(34) + CleanXML(reqCaptcha) + Chr(34)
xmlParam = xmlParam + " pxsponsorid=" + Chr(34) + CleanXML(reqPXSponsorID) + Chr(34)
xmlParam = xmlParam + " xid=" + Chr(34) + CleanXML(reqxID) + Chr(34)
xmlParam = xmlParam + " xsponsorid=" + Chr(34) + CleanXML(reqxSponsorID) + Chr(34)
xmlParam = xmlParam + " firstname=" + Chr(34) + CleanXML(reqFirstName) + Chr(34)
xmlParam = xmlParam + " lastname=" + Chr(34) + CleanXML(reqLastName) + Chr(34)
xmlParam = xmlParam + " username=" + Chr(34) + CleanXML(reqUserName) + Chr(34)
xmlParam = xmlParam + " emailaddress=" + Chr(34) + CleanXML(reqEmailAddress) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlAddress
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlCountry
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Register[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Register[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "Register Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "Register Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "Register Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "Register.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "Register Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "Register Load file (oData) failed with error code " + CStr(oData.parseError)
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
<!--#include file="Include\System.asp"-->
<!--#include file="Include\Billing.asp"-->
<!--#include file="Include\Payment.asp"-->
<!--#include file="Include\Email.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\CommissionEmail.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 2
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
Dim oBilling, xmlBilling
Dim oMember, xmlMember
Dim oCountrys, xmlCountrys
Dim oHTMLFile, xmlHTMLFile
Dim oAddress, xmlAddress
Dim oPayment, xmlPayment
Dim oCountry, xmlCountry
Dim oCoption, xmlCoption
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqBillingID
Dim reqMembership
Dim reqOrderOption
Dim reqIsAgree2
Dim reqPayType
Dim reqAmount
Dim reqBillingPrice
Dim reqCountryID
Dim reqNoBill
Dim reqResult
Dim reqStreet1b
Dim reqStreet2b
Dim reqCityb
Dim reqStateb
Dim reqZipb
Dim reqCountryIDb
Dim reqProcessor
Dim reqMemberToken
Dim reqToken
Dim reqPayDesc
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
   SetCache "13301URL", reqReturnURL
   SetCache "13301DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "13301")
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
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqMembership =  Numeric(GetInput("Membership", reqPageData))
reqOrderOption =  Numeric(GetInput("OrderOption", reqPageData))
reqIsAgree2 =  Numeric(GetInput("IsAgree2", reqPageData))
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqAmount =  Numeric(GetInput("Amount", reqPageData))
reqBillingPrice =  Numeric(GetInput("BillingPrice", reqPageData))
reqCountryID =  Numeric(GetInput("CountryID", reqPageData))
reqNoBill =  Numeric(GetInput("NoBill", reqPageData))
reqResult =  Numeric(GetInput("Result", reqPageData))
reqStreet1b =  GetInput("Street1b", reqPageData)
reqStreet2b =  GetInput("Street2b", reqPageData)
reqCityb =  GetInput("Cityb", reqPageData)
reqStateb =  GetInput("Stateb", reqPageData)
reqZipb =  GetInput("Zipb", reqPageData)
reqCountryIDb =  GetInput("CountryIDb", reqPageData)
reqProcessor =  Numeric(GetInput("Processor", reqPageData))
reqMemberToken =  Numeric(GetInput("MemberToken", reqPageData))
reqToken =  Numeric(GetInput("Token", reqPageData))
reqPayDesc =  GetInput("PayDesc", reqPageData)
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

Sub NewBilling()
   On Error Resume Next
   reqPayType = 1
   LoadLists

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CheckAcctType = 1
         reqCountryIDb = 224
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

Sub LoadBilling()
   On Error Resume Next
   LoadLists

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CheckAcctType = 1

         .CardNumber = Request.Form.Item("CardNumber")
         .CardMo = Request.Form.Item("CardMo")
         .CardYr = Request.Form.Item("CardYr")
         .CardName = Request.Form.Item("CardName")
         .CardCode = Request.Form.Item("CardCode")
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

Sub LoadLists()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqBillingID = .BillingID
         .CompanyName = ""
         reqMembership = .Title + 1
         If (reqMembership > 4) Then
            reqMembership = 0
         End If
         reqOrderOption = 1
         If (InStr(.Options2, "104") <> 0) Then
            reqOrderOption = 1
         End If
         If (InStr(.Options2, "105") <> 0) Then
            reqOrderOption = 2
         End If
         If (InStr(.Options2, "106") <> 0) Then
            reqOrderOption = 3
         End If
         If (InStr(.Options2, "107") <> 0) Then
            reqOrderOption = 4
         End If
         If (InStr(.Options2, "108") <> 0) Then
            reqOrderOption = 5
         End If
         If (InStr(.Options2, "109") <> 0) Then
            reqOrderOption = 6
         End If
         If (InStr(.Options2, "111") <> 0) Then
            reqOrderOption = 7
         End If
         If (InStr(.Options2, "224") <> 0) Then
            reqOrderOption = 21
         End If
         If (InStr(.Options2, "225") <> 0) Then
            reqOrderOption = 22
         End If
         If (InStr(.Options2, "226") <> 0) Then
            reqOrderOption = 23
         End If
         If (InStr(.Options2, "227") <> 0) Then
            reqOrderOption = 24
         End If
         If (InStr(.Options2, "228") <> 0) Then
            reqOrderOption = 25
         End If
         If (InStr(.Options2, "229") <> 0) Then
            reqOrderOption = 26
         End If
         If (InStr(.Options2, "221") <> 0) Then
            reqOrderOption = 27
         End If
         If (InStr(.Options2, "334") <> 0) Then
            reqOrderOption = 31
         End If
         If (InStr(.Options2, "335") <> 0) Then
            reqOrderOption = 32
         End If
         If (InStr(.Options2, "336") <> 0) Then
            reqOrderOption = 33
         End If
         If (InStr(.Options2, "337") <> 0) Then
            reqOrderOption = 34
         End If
         If (InStr(.Options2, "338") <> 0) Then
            reqOrderOption = 35
         End If
         If (InStr(.Options2, "339") <> 0) Then
            reqOrderOption = 36
         End If
         If (InStr(.Options2, "331") <> 0) Then
            reqOrderOption = 37
         End If
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   If (reqBillingID <> 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load reqBillingID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPayType = .PayType
            reqPayDesc = BillingPayment( oBilling )
         End With
      End If
      Set oBilling = Nothing
   End If

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

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Upgrade.htm"
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

   Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
   If oAddress Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
   Else
      With oAddress
         .SysCurrentLanguage = reqSysLanguage
         .FetchOwner 04, reqMemberID, 2
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCountryID = .CountryID
      End With
   End If
   Set oAddress = Nothing
End Sub

Sub ValidBilling()
   On Error Resume Next
   tmpPayType = Request.Form.Item("PayType")
   tmpCardNumber = Request.Form.Item("CardNumber")

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

   If (xmlError = "") And (tmpCountryID <> 0) Then
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

   If (xmlError = "") And (tmpPayType <= 7) Then
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
                  reqPayDesc = BillingPayment( oBilling )
               End If
            End If
         End With
      End If
      Set oBilling = Nothing
   End If
End Sub

reqCompanyID = 13
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      NewBilling

   Case CLng(cActionUpdate):
      If (reqBillingID = 0) Then
         If (xmlError = "") And (reqIsAgree2 = 0) And (reqMembership <> 0) Then
            DoError 10128, "", "Oops, You must agree to recurring billing."
         End If
         tmpUpdateBilling = 0
         If (xmlError = "") Then
            ValidBilling
         End If
         If (reqBillingID <> 0) Then
            tmpUpdateBilling = 1
         End If
      End If

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
            tmpCardProcessor = .MerchantCardType
            tmpCardAcct = .MerchantCardAcct
            tmpCheckProcessor = .MerchantCheckType
            tmpCheckAcct = .MerchantCheckAcct
            ShipOption = .Shopping
            EmailBonuses = InStr(ShipOption, "N")
         End With
      End If
      Set oCoption = Nothing

      If (xmlError = "") Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqMemberID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpReferralID = .ReferralID
               tmpName = .NameFirst + " " + .NameLast + " (#" + .MemberID + ")"
               If (tmpUpdateBilling <> 0) Then
                  .BillingID = reqBillingID
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               oldPrice = .Price
               oldOptions2 = .Options2
               oldTitle = .Title
               oldMembership = .Title + 1
               reqMembership = Request.Form.Item("Membership")
               reqBillingPrice = 0
               tmpUpdate = 0
               tmpUpdatePaidDate = 0
               If (reqOrderOption = 1) Then
                  tmpCode = "104"
                  .Price = 46.95
                  If (reqCountryID <> 224) Then
                     .Price = 52.95
                  End If
               End If
               If (reqOrderOption = 2) Then
                  tmpCode = "105"
                  .Price = 47.95
                  If (reqCountryID <> 224) Then
                     .Price = 53.95
                  End If
               End If
               If (reqOrderOption = 3) Then
                  tmpCode = "106"
                  .Price = 47.95
                  If (reqCountryID <> 224) Then
                     .Price = 53.95
                  End If
               End If
               If (reqOrderOption = 4) Then
                  tmpCode = "107"
                  .Price = 48.95
                  If (reqCountryID <> 224) Then
                     .Price = 54.95
                  End If
               End If
               If (reqOrderOption = 5) Then
                  tmpCode = "108"
                  .Price = 48.95
                  If (reqCountryID <> 224) Then
                     .Price = 54.95
                  End If
               End If
               If (reqOrderOption = 6) Then
                  tmpCode = "109"
                  .Price = 48.95
                  If (reqCountryID <> 224) Then
                     .Price = 54.95
                  End If
               End If
               If (reqOrderOption = 7) Then
                  tmpCode = "111"
                  .Price = 66.95
                  If (reqCountryID <> 224) Then
                     .Price = 75.95
                  End If
               End If
               If (reqOrderOption = 21) Then
                  tmpCode = "224"
                  .Price = 91.95
                  If (tmpCountryID <> 224) Then
                     .Price = 104.95
                  End If
               End If
               If (reqOrderOption = 22) Then
                  tmpCode = "225"
                  .Price = 93.95
                  If (tmpCountryID <> 224) Then
                     .Price = 106.95
                  End If
               End If
               If (reqOrderOption = 23) Then
                  tmpCode = "226"
                  .Price = 93.95
                  If (tmpCountryID <> 224) Then
                     .Price = 106.95
                  End If
               End If
               If (reqOrderOption = 24) Then
                  tmpCode = "227"
                  .Price = 95.95
                  If (tmpCountryID <> 224) Then
                     .Price = 108.95
                  End If
               End If
               If (reqOrderOption = 25) Then
                  tmpCode = "228"
                  .Price = 95.95
                  If (tmpCountryID <> 224) Then
                     .Price = 108.95
                  End If
               End If
               If (reqOrderOption = 26) Then
                  tmpCode = "229"
                  .Price = 95.95
                  If (tmpCountryID <> 224) Then
                     .Price = 108.95
                  End If
               End If
               If (reqOrderOption = 27) Then
                  tmpCode = "221"
                  .Price = 131.95
                  If (tmpCountryID <> 224) Then
                     .Price = 144.95
                  End If
               End If
               If (reqOrderOption = 31) Then
                  tmpCode = "334"
                  .Price = 135.95
                  If (tmpCountryID <> 224) Then
                     .Price = 148.95
                  End If
               End If
               If (reqOrderOption = 32) Then
                  tmpCode = "335"
                  .Price = 138.95
                  If (tmpCountryID <> 224) Then
                     .Price = 151.95
                  End If
               End If
               If (reqOrderOption = 33) Then
                  tmpCode = "336"
                  .Price = 138.95
                  If (tmpCountryID <> 224) Then
                     .Price = 151.95
                  End If
               End If
               If (reqOrderOption = 34) Then
                  tmpCode = "337"
                  .Price = 141.95
                  If (tmpCountryID <> 224) Then
                     .Price = 154.95
                  End If
               End If
               If (reqOrderOption = 35) Then
                  tmpCode = "338"
                  .Price = 141.95
                  If (tmpCountryID <> 224) Then
                     .Price = 154.95
                  End If
               End If
               If (reqOrderOption = 36) Then
                  tmpCode = "339"
                  .Price = 141.95
                  If (tmpCountryID <> 224) Then
                     .Price = 154.95
                  End If
               End If
               If (reqOrderOption = 37) Then
                  tmpCode = "331"
                  .Price = 197.95
                  If (tmpCountryID <> 224) Then
                     .Price = 210.95
                  End If
               End If
               If (reqMembership = 0) Then
                  .Options2 = Replace(.Options2, "104", "")
                  .Options2 = Replace(.Options2, "105", "")
                  .Options2 = Replace(.Options2, "106", "")
                  .Options2 = Replace(.Options2, "107", "")
                  .Options2 = Replace(.Options2, "108", "")
                  .Options2 = Replace(.Options2, "109", "")
                  .Options2 = Replace(.Options2, "111", "")
                  .Options2 = Replace(.Options2, "224", "")
                  .Options2 = Replace(.Options2, "225", "")
                  .Options2 = Replace(.Options2, "226", "")
                  .Options2 = Replace(.Options2, "227", "")
                  .Options2 = Replace(.Options2, "228", "")
                  .Options2 = Replace(.Options2, "229", "")
                  .Options2 = Replace(.Options2, "221", "")
                  .Options2 = Replace(.Options2, "334", "")
                  .Options2 = Replace(.Options2, "335", "")
                  .Options2 = Replace(.Options2, "336", "")
                  .Options2 = Replace(.Options2, "337", "")
                  .Options2 = Replace(.Options2, "338", "")
                  .Options2 = Replace(.Options2, "339", "")
                  .Options2 = Replace(.Options2, "331", "")
                  .Options2 = .Options2 + "," + tmpCode 
                  tmpUpdate = 1
               End If
               If (oldTitle = 0) Then
                  If (reqMembership = 1) Then
                     .Title = 1
                     .Options2 = tmpCode
                     .InitPrice = 0
                     reqBillingPrice = .Price
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  If (reqMembership = 2) Then
                     .Title = 2
                     .Options2 = "101," + tmpCode
                     .InitPrice = 206.90
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 212.90
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  If (reqMembership = 3) Then
                     .Title = 3
                     .Options2 = "102," + tmpCode
                     .InitPrice = 206.90
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 212.90
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  If (reqMembership = 4) Then
                     .Title = 4
                     .Options2 = "103," + tmpCode
                     .InitPrice = 357.40
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 366.90
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  Purpose = .Options2
               End If
               If (oldTitle = 1) Then
                  If (reqMembership = 2) Then
                     .Title = 2
                     .Options2 = "121," + tmpCode
                     .InitPrice = 185.95
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 191.95
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  If (reqMembership = 3) Then
                     .Title = 3
                     .Options2 = "122," + tmpCode
                     .InitPrice = 235.95
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 241.95
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  If (reqMembership = 4) Then
                     .Title = 4
                     .Options2 = "123," + tmpCode
                     .InitPrice = 335.95
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 341.95
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  Purpose = .Options2
               End If
               If (oldTitle = 2) Then
                  If (reqMembership = 3) Then
                     .Title = 3
                     .Options2 = "124," + tmpCode
                     .InitPrice = 76.95
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 82.95
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  If (reqMembership = 4) Then
                     .Title = 4
                     .Options2 = "125," + tmpCode
                     .InitPrice = 176.95
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 182.95
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  Purpose = .Options2
               End If
               If (oldTitle = 3) Then
                  If (reqMembership = 4) Then
                     .Title = 4
                     .Options2 = "126," + tmpCode
                     .InitPrice = 126.95
                     If (tmpCountryID <> 224) Then
                        .InitPrice = 132.95
                     End If
                     reqBillingPrice = .InitPrice
                     tmpUpdate = 1
                     tmpUpdatePaidDate = 1
                  End If
                  Purpose = .Options2
               End If
               newTitle = .Title
               If (.Qualify <> 3) Then
                  .Qualify = 2
                  If (.Level = 0) Then
                     .Qualify = 1
                  End If
               End If
               If (tmpUpdate <> 0) Then
                  If (xmlError = "") And (reqBillingPrice <> 0) And (reqNoBill = 0) Then
                     PostProcess = 1
                     
                        tmpProcessor = ""
                        tmpAcct = ""
                        Select Case reqPayType
                        Case 1, 2, 3, 4   'Process Credit Cards
                        tmpProcessor = tmpCardProcessor
                        tmpAcct = tmpCardAcct
                        Case 5 'Process Electronic Checks
                        tmpProcessor = tmpCheckProcessor
                        tmpAcct = tmpCheckAcct
                        End Select
                     
                     Result = SubmitPayment( reqCompanyID, reqMemberID, reqPayType, reqPayDesc, reqBillingPrice, Purpose, PostProcess )
                     If (IsNumeric(Result) = 0) Then
                        DoError 0, "", Result
                     End If
                     If (IsNumeric(Result) <> 0) Then
                        If (tmpUpdatePaidDate <> 0) Then
                           .PaidDate = DATEADD("m", 1, .PaidDate)
                           .Save CLng(reqSysUserID)
                           If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        End If
                     End If
                  End If
                  If (xmlError = "") Then
                     .Save CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (xmlError = "") Then
                     LogMemberNote reqMemberID, "MEMBERSHIP CHANGE: (" + oldOptions2 + ") to (" + .Options2 + ")"
                  End If
                  If (reqBillingPrice <> 0) Then
                     reqBillingPrice = FormatCurrency( reqBillingPrice, 2 )
                  End If
               End If
            End With
         End If
         Set oMember = Nothing
      End If
      If (xmlError = "") And (newTitle <> oldTitle) Then

         Set oMemberTitle = server.CreateObject("ptsMemberTitleUser.CMemberTitle")
         If oMemberTitle Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberTitleUser.CMemberTitle"
         Else
            With oMemberTitle
               .SysCurrentLanguage = reqSysLanguage
               .MemberID = reqMemberID
               .TitleDate = Now
               .Title = newTitle
               .IsEarned = 1
               .Add CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oMemberTitle = Nothing

         If (tmpReferralID <> 0) Then
            Set oMember = server.CreateObject("ptsMemberUser.CMember")
            If oMember Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
            Else
               With oMember
                  .SysCurrentLanguage = reqSysLanguage
                  .Load tmpReferralID, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  tmpTo = .Email
                  
                     tmpSender = "support@gft-global.com"
                     tmpFrom = "support@gft-global.com"
                     Select Case newTitle
                     Case 1
                     tmpSubject = tmpName + " has upgraded to an Affiliate"
                     Case 2
                     tmpSubject = tmpName + " has upgraded to the Silver Pack"
                     Case 3
                     tmpSubject = tmpName + " has upgraded to the Gold Pack"
                     Case 4
                     tmpSubject = tmpName + " has upgraded to the Platinum Pack"
                     End Select
                     tmpBody = tmpSubject
                     SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
                  
               End With
            End If
            Set oMember = Nothing
         End If
      End If
      LoadBilling
      If (xmlError = "") Then
         reqResult = 1
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("13301URL")
      reqReturnData = GetCache("13301DATA")
      SetCache "13301URL", ""
      SetCache "13301DATA", ""
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
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " membership=" + Chr(34) + CStr(reqMembership) + Chr(34)
xmlParam = xmlParam + " orderoption=" + Chr(34) + CStr(reqOrderOption) + Chr(34)
xmlParam = xmlParam + " isagree2=" + Chr(34) + CStr(reqIsAgree2) + Chr(34)
xmlParam = xmlParam + " paytype=" + Chr(34) + CStr(reqPayType) + Chr(34)
xmlParam = xmlParam + " amount=" + Chr(34) + CStr(reqAmount) + Chr(34)
xmlParam = xmlParam + " billingprice=" + Chr(34) + CStr(reqBillingPrice) + Chr(34)
xmlParam = xmlParam + " countryid=" + Chr(34) + CStr(reqCountryID) + Chr(34)
xmlParam = xmlParam + " nobill=" + Chr(34) + CStr(reqNoBill) + Chr(34)
xmlParam = xmlParam + " result=" + Chr(34) + CStr(reqResult) + Chr(34)
xmlParam = xmlParam + " street1b=" + Chr(34) + CleanXML(reqStreet1b) + Chr(34)
xmlParam = xmlParam + " street2b=" + Chr(34) + CleanXML(reqStreet2b) + Chr(34)
xmlParam = xmlParam + " cityb=" + Chr(34) + CleanXML(reqCityb) + Chr(34)
xmlParam = xmlParam + " stateb=" + Chr(34) + CleanXML(reqStateb) + Chr(34)
xmlParam = xmlParam + " zipb=" + Chr(34) + CleanXML(reqZipb) + Chr(34)
xmlParam = xmlParam + " countryidb=" + Chr(34) + CleanXML(reqCountryIDb) + Chr(34)
xmlParam = xmlParam + " processor=" + Chr(34) + CStr(reqProcessor) + Chr(34)
xmlParam = xmlParam + " membertoken=" + Chr(34) + CStr(reqMemberToken) + Chr(34)
xmlParam = xmlParam + " token=" + Chr(34) + CStr(reqToken) + Chr(34)
xmlParam = xmlParam + " paydesc=" + Chr(34) + CleanXML(reqPayDesc) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlAddress
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlCountry
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\13301[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\13301[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "13301 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "13301 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "13301 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "13301.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "13301 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "13301 Load file (oData) failed with error code " + CStr(oData.parseError)
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
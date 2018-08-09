<!--#include file="Include\System.asp"-->
<!--#include file="Include\Billing.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionAdd = 2
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
Dim oCountrys, xmlCountrys
Dim oMember, xmlMember
Dim oAddress, xmlAddress
Dim oSalesOrder, xmlSalesOrder
Dim oBilling, xmlBilling
Dim oHTMLFile, xmlHTMLFile
Dim oSalesItems, xmlSalesItems
Dim oPayment, xmlPayment
Dim oDownline, xmlDownline
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqS
Dim reqL
Dim reqT
Dim reqG
Dim reqA
Dim reqSalesOrderID
Dim reqBillingID
Dim reqPaymentOptions
Dim reqTotal
Dim reqCardZip
Dim reqProcessPayment
Dim reqIsAgree
Dim reqSponsor
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
   SetCache "0432URL", reqReturnURL
   SetCache "0432DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0432")
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
reqS =  Numeric(GetInput("S", reqPageData))
reqL =  Numeric(GetInput("L", reqPageData))
reqT =  Numeric(GetInput("T", reqPageData))
reqG =  GetInput("G", reqPageData)
reqA =  Numeric(GetInput("A", reqPageData))
reqSalesOrderID =  Numeric(GetInput("SalesOrderID", reqPageData))
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqPaymentOptions =  GetInput("PaymentOptions", reqPageData)
reqTotal =  GetInput("Total", reqPageData)
reqCardZip =  GetInput("CardZip", reqPageData)
reqProcessPayment =  Numeric(GetInput("ProcessPayment", reqPageData))
reqIsAgree =  Numeric(GetInput("IsAgree", reqPageData))
reqSponsor =  GetInput("Sponsor", reqPageData)
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

Sub GetUserOptions()
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
         If (reqL = 0) Then
            reqSysUserOptions = .FreeOptions
         End If
         If (reqL = 1) Then
            reqSysUserOptions = .Options
         End If
         If (reqL = 2) Then
            reqSysUserOptions = .Options2
         End If
         If (reqL = 3) Then
            reqSysUserOptions = .Options3
         End If
      End With
   End If
   Set oCoption = Nothing
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

Sub LoadOrder()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .TaxIDType = 1
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqSponsor = .NameFirst +  " " + .NameLast
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

   Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
   If oSalesOrder Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
   Else
      With oSalesOrder
         .SysCurrentLanguage = reqSysLanguage
         .Load reqSalesOrderID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         reqTotal = .Total
         xmlSalesOrder = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSalesOrder = Nothing
   If (reqTotal <> 0) Then

      If (reqCompanyID = 0) Then
         Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
         If oBusiness Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
         Else
            With oBusiness
               .SysCurrentLanguage = reqSysLanguage
               .Load 1, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqPaymentOptions = .PaymentOptions
            End With
         End If
         Set oBusiness = Nothing
      End If

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
            reqPaymentOptions = .PaymentOptions
         End With
      End If
      Set oCoption = Nothing
   End If

   If (reqTotal <> 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .PayType = 1
            xmlBilling = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBilling = Nothing
   End If

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Enroll" + CStr(reqS) + CStr(reqL) + ".htm"
         .Path = reqSysWebDirectory + "Sections\Company/" + CStr(reqCompanyID)
         .Language = reqSysLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlHTMLFile = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing
End Sub

Sub ReloadMember()
   On Error Resume Next
   LoadOrder

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Icons = Request.Form.Item("Icons")
         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .TaxIDType = Request.Form.Item("TaxIDType")
         .TaxID = Request.Form.Item("TaxID")
         .Email = Request.Form.Item("Email")
         .CompanyName = Request.Form.Item("CompanyName")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
         .Fax = Request.Form.Item("Fax")
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

   If (reqTotal <> 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .PayType = Request.Form.Item("PayType")
            .CardNumber = Request.Form.Item("CardNumber")
            .CardMo = Request.Form.Item("CardMo")
            .CardYr = Request.Form.Item("CardYr")
            .CardName = Request.Form.Item("CardName")
            .CardCode = Request.Form.Item("CardCode")
            .Zip = Request.Form.Item("CardZip")
            .CheckBank = Request.Form.Item("CheckBank")
            .CheckRoute = Request.Form.Item("CheckRoute")
            .CheckAccount = Request.Form.Item("CheckAccount")
            .CheckNumber = Request.Form.Item("CheckNumber")
            .CheckName = Request.Form.Item("CheckName")
            xmlBilling = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBilling = Nothing
   End If
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
            DoError 10104, "", "Oops, Email Address Already Exists."
         End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub Join()
   On Error Resume Next
   If (reqTotal <> 0) Then
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
                  DoError 10010, "", "Oops, Selected Card Type does not match Card Number."
               End If
               If (result = 1) And (InStr(reqPaymentOptions,"A") = 0) Then
                  DoError 10012, "", "Oops, Invalid Credit Card Type."
               End If
               If (result = 2) And (InStr(reqPaymentOptions,"B") = 0) Then
                  DoError 10012, "", "Oops, Invalid Credit Card Type."
               End If
               If (result = 3) And (InStr(reqPaymentOptions,"C") = 0) Then
                  DoError 10012, "", "Oops, Invalid Credit Card Type."
               End If
               If (result = 4) And (InStr(reqPaymentOptions,"D") = 0) Then
                  DoError 10012, "", "Oops, Invalid Credit Card Type."
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
            DoError 10013, "", "Oops, Invalid Credit Card Date."
         End If
      End If

      If (xmlError = "") And (tmpPayType <= 5) Then
         Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
         If oBilling Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
         Else
            With oBilling
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqBillingID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpPayType = Request.Form.Item("PayType")
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
                  .CheckNumber = Request.Form.Item("CheckNumber")
                  .CheckName = Request.Form.Item("CheckName")
               End If
               .Validate 1, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (xmlError = "") And (reqBillingID <> 0) Then
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (xmlError = "") And (reqBillingID = 0) Then
                  reqBillingID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               tmpDescription = BillingPayment( oBilling )
            End With
         End If
         Set oBilling = Nothing
      End If
   End If

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

   If (xmlError = "") Then
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
            If (reqL = 0) Or (reqL = 1) Then
               tmpPrice = .Price
               tmpRetail = .Retail
            End If
            If (reqL = 2) Then
               tmpPrice = .Price2
               tmpRetail = .Retail2
            End If
            If (reqL = 3) Then
               tmpPrice = .Price3
               tmpRetail = .Retail3
            End If
            tmpInitPrice = .InitPrice
            tmpBilling = .Billing
            tmpDiscount = .Discount
            tmpIsDiscount = .IsDiscount
            tmpPromoID = .PromoCode
            tmpAccessLimit = .AccessLimit
            tmpQuizLimit = .QuizLimit
            tmpTrialDays = .TrialDays
         End With
      End If
      Set oCoption = Nothing
   End If

   If (xmlError = "") Then
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
            .TaxIDType = Request.Form.Item("TaxIDType")
            .TaxID = Request.Form.Item("TaxID")
            .Email = Request.Form.Item("Email")
            .CompanyName = Request.Form.Item("CompanyName")
            .Phone1 = Request.Form.Item("Phone1")
            .Phone2 = Request.Form.Item("Phone2")
            .Fax = Request.Form.Item("Fax")
            If (.TaxIDType = "0") Or (.TaxID = "") Then
               DoError 10011, "", "Oops, Identification Number is Required."
            End If
            If (.Phone1 = "") And (.Phone2 = "") And (.Fax = "") Then
               DoError 10006, "", "Oops, At Least 1 Phone Number is Required."
            End If
            If (xmlError = "") Then
               .CompanyID = reqCompanyID
               .ReferralID = reqMemberID
               .SponsorID = reqMemberID
               .MentorID = reqMemberID
               .BillingID = reqBillingID
               .Status = reqS
               .Level = reqL
               .Title = reqT
               .GroupID = reqG
               .EnrollDate = Now
               .PaidDate = FormatDateTime(.EnrollDate,2)
               .Price = tmpPrice
               .InitPrice = tmpInitPrice
               .Retail = tmpRetail
               .Discount = tmpDiscount
               .IsDiscount = tmpIsDiscount
               .PromoID = tmpPromoID
               .AccessLimit = tmpAccessLimit
               .QuizLimit = tmpQuizLimit
               If (reqS <> 3) Then
                  .Billing = tmpBilling
               End If
               If (reqS = 3) Then
                  .Billing = 0
               End If
               If (reqS = 2) Then
                  .TrialDays = tmpTrialDays
                  .PaidDate = DATEADD("d", tmpTrialDays, reqSysDate)
               End If
               .UserStatus = 1
               .UserGroup = 41
               If (.CompanyName <> "") Then
                  .IsCompany = "1"
               End If
               If (.CompanyName = "") Then
                  .CompanyName = .NameLast + ", " + .NameFirst
               End If
               .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
               .NotifyMentor = "ABCDEFG"
               .Timezone = -6
               tmpMemberID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

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
                        .OwnerID = tmpMemberID
                        .AddressType = 2

                        .Street1 = Request.Form.Item("Street1")
                        .Street2 = Request.Form.Item("Street2")
                        .City = Request.Form.Item("City")
                        .State = Request.Form.Item("State")
                        .Zip = Request.Form.Item("Zip")
                        .CountryID = Request.Form.Item("CountryID")
                        tmpAddressID = CLng(.Add(CLng(reqSysUserID)))
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     End With
                  End If
                  Set oAddress = Nothing
               End If
               If (xmlError = "") And (.Title <> 0) Then

                  Set oMemberTitle = server.CreateObject("ptsMemberTitleUser.CMemberTitle")
                  If oMemberTitle Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberTitleUser.CMemberTitle"
                  Else
                     With oMemberTitle
                        .SysCurrentLanguage = reqSysLanguage
                        .MemberID = tmpMemberID
                        .TitleDate = Now
                        .Title = oMember.Title
                        .Add CLng(reqSysUserID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     End With
                  End If
                  Set oMemberTitle = Nothing
               End If
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   Set oSalesItems = server.CreateObject("ptsSalesItemUser.CSalesItems")
   If oSalesItems Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesItemUser.CSalesItems"
   Else
      With oSalesItems
         .SysCurrentLanguage = reqSysLanguage
         .ListSalesOrder reqSalesOrderID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            tmpPurpose = oSalesItems.Item(1).ProductName

      End With
   End If
   Set oSalesItems = Nothing

   If (xmlError = "") And (reqTotal <> 0) Then
      Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
      Else
         With oPayment
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .CompanyID = reqCompanyID
            .OwnerType = 52
            .OwnerID = reqSalesOrderID
            .PayDate = Now
            .PayType = tmpPayType
            .Status = 1
            .Amount = reqTotal
            .Total = reqTotal
            .Description = tmpDescription
            .Purpose = tmpPurpose
            PaymentID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPayment = Nothing
   End If

   If (xmlError = "") Then
      Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
      If oSalesOrder Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
      Else
         With oSalesOrder
            .SysCurrentLanguage = reqSysLanguage
            .Load reqSalesOrderID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .MemberID = tmpMemberID
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            Result = CLng(.UpdateRecurring(Date(), reqSalesOrderID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSalesOrder = Nothing
   End If

   If (xmlError = "") And (InStr(reqSysUserOptions,"o") <> 0) And (reqMemberID <> 0) And (tmpMemberID <> 0) Then
      Set oDownline = server.CreateObject("ptsDownlineUser.CDownline")
      If oDownline Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsDownlineUser.CDownline"
      Else
         With oDownline
            .SysCurrentLanguage = reqSysLanguage
            Result = CLng(.Build(CLng(reqCompanyID), CLng(reqMemberID), tmpMemberID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oDownline = Nothing
   End If
   If (xmlError <> "") Then
      ReloadMember
   End If
   If (xmlError = "") Then
      
            If Request.Form.Item("ProcessPayment") = 1 Then
               tmpReturnURL = "5254.asp?SalesOrderID=" & reqSalesOrderID & "%26autoship=" + CStr(reqA)
               Response.Redirect "1004.asp?PaymentID=" & PaymentID & "&Acct=" & tmpAcct & "&TxnReturnURL=" & tmpReturnURL
            Else
               Response.Redirect "5254.asp?SalesOrderID=" & reqSalesOrderID & "&txn=1&member=1&autoship=" + CStr(reqA)
            End If

   End If
End Sub

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If
If (reqS < 1) Or (reqS > 3) Then
   reqS = 3
   reqL = 0
End If
If (reqL < 0) Or (reqL > 3) Then
   If (reqS = 3) Then
      reqL = 0
   End If
   If (reqS <> 3) Then
      reqL = 1
   End If
End If
If (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqSalesOrderID = Numeric(GetCache("SHOPPINGCART"))
      LoadOrder

   Case CLng(cActionAdd):
      If (reqIsAgree = 0) Then
         DoError 10103, "", "Oops, You must agree to the terms and conditions."
      End If
      If (xmlError = "") Then
         GetUserOptions
      End If
      If (xmlError = "") And (InStr(reqSysUserOptions,"k") = 0) Then
         ValidEmail
      End If
      If (xmlError = "") Then
         ValidLogon
      End If
      If (xmlError = "") Then
         Join
      End If
      If (xmlError <> "") Then
         ReLoadMember
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
xmlParam = xmlParam + " s=" + Chr(34) + CStr(reqS) + Chr(34)
xmlParam = xmlParam + " l=" + Chr(34) + CStr(reqL) + Chr(34)
xmlParam = xmlParam + " t=" + Chr(34) + CStr(reqT) + Chr(34)
xmlParam = xmlParam + " g=" + Chr(34) + CleanXML(reqG) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqA) + Chr(34)
xmlParam = xmlParam + " salesorderid=" + Chr(34) + CStr(reqSalesOrderID) + Chr(34)
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " paymentoptions=" + Chr(34) + CleanXML(reqPaymentOptions) + Chr(34)
xmlParam = xmlParam + " total=" + Chr(34) + CStr(reqTotal) + Chr(34)
xmlParam = xmlParam + " cardzip=" + Chr(34) + CleanXML(reqCardZip) + Chr(34)
xmlParam = xmlParam + " processpayment=" + Chr(34) + CStr(reqProcessPayment) + Chr(34)
xmlParam = xmlParam + " isagree=" + Chr(34) + CStr(reqIsAgree) + Chr(34)
xmlParam = xmlParam + " sponsor=" + Chr(34) + CleanXML(reqSponsor) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlAddress
xmlTransaction = xmlTransaction +  xmlSalesOrder
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlSalesItems
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlDownline
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\0432[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\0432[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0432 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0432 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0432 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0432.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0432 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0432 Load file (oData) failed with error code " + CStr(oData.parseError)
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
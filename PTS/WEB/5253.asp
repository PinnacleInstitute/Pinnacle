<!--#include file="Include\System.asp"-->
<!--#include file="Include\Billing.asp"-->
<!--#include file="Include\Payment.asp"-->
<!--#include file="Include\Wallet.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\CommissionEmail.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionPurchase = 1
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
Dim oSalesOrder, xmlSalesOrder
Dim oPayments, xmlPayments
Dim oCountrys, xmlCountrys
Dim oMember, xmlMember
Dim oAddress, xmlAddress
Dim oBilling, xmlBilling
Dim oCompany, xmlCompany
Dim oSalesItems, xmlSalesItems
Dim oPayment, xmlPayment
'-----declare page parameters
Dim reqSalesOrderID
Dim reqCompanyID
Dim reqMemberID
Dim reqAddressID
Dim reqSponsorID
Dim reqPaymentOptions
Dim reqTotal
Dim reqProcessPayment
Dim reqMemberEmail
Dim reqShipOption
Dim reqExistingPayments
Dim reqNoBill
Dim reqCashPayment
Dim reqWallet
Dim reqStreet12
Dim reqStreet22
Dim reqCity2
Dim reqState2
Dim reqZip2
Dim reqCountryID2
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
   SetCache "5253URL", reqReturnURL
   SetCache "5253DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "5253")
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
reqSalesOrderID =  Numeric(GetInput("SalesOrderID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqAddressID =  Numeric(GetInput("AddressID", reqPageData))
reqSponsorID =  Numeric(GetInput("SponsorID", reqPageData))
reqPaymentOptions =  GetInput("PaymentOptions", reqPageData)
reqTotal =  GetInput("Total", reqPageData)
reqProcessPayment =  Numeric(GetInput("ProcessPayment", reqPageData))
reqMemberEmail =  GetInput("MemberEmail", reqPageData)
reqShipOption =  GetInput("ShipOption", reqPageData)
reqExistingPayments =  Numeric(GetInput("ExistingPayments", reqPageData))
reqNoBill =  Numeric(GetInput("NoBill", reqPageData))
reqCashPayment =  Numeric(GetInput("CashPayment", reqPageData))
reqWallet =  GetInput("Wallet", reqPageData)
reqStreet12 =  GetInput("Street12", reqPageData)
reqStreet22 =  GetInput("Street22", reqPageData)
reqCity2 =  GetInput("City2", reqPageData)
reqState2 =  GetInput("State2", reqPageData)
reqZip2 =  GetInput("Zip2", reqPageData)
reqCountryID2 =  GetInput("CountryID2", reqPageData)
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

Sub LoadOrder()
   On Error Resume Next

   Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
   If oSalesOrder Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
   Else
      With oSalesOrder
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqSalesOrderID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         If (reqMemberID = 0) Then
            reqMemberID = .MemberID
         End If
         reqTotal = .Total
         If (.MemberID = 0) And (reqMemberID <> 0) Then
            .MemberID = reqMemberID
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         xmlSalesOrder = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSalesOrder = Nothing

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

   If (reqCompanyID <> 0) Then
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
            reqShipOption = .Shopping
            If InStr(reqShipOption, "P") > 0 Then reqProcessPayment = 1
            If InStr(reqShipOption, "E") > 0 Then reqExistingPayments = 1
         End With
      End If
      Set oCoption = Nothing
   End If

   If (reqTotal <> 0) And (reqMemberID <> 0) And (reqExistingPayments <> 0) Then
      Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
      If oPayments Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayments"
      Else
         With oPayments
            .SysCurrentLanguage = reqSysLanguage
            .ListMemberPayments CLng(reqMemberID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
            For Each oPayment In oPayments
               PaymentBilling oPayment.Description, oBilling
               With oBilling
                  If .PayType = "1" Then   'Credit Card
                     tmpDate = .CardMo + "/1/" + .CardYr
                     If ISDATE(tmpDate) Then
                        tmpDate = DATEADD("m", 1, tmpDate)
                        If CDate(tmpDate) > Date() Then
                           Select Case .CardType
                           Case 1
                              tmpCardType = "Visa"
                              If InStr(reqPaymentOptions,"A") = 0 Then oPayment.Description = ""
                           Case 2
                              tmpCardType = "MasterCard"
                              If InStr(reqPaymentOptions,"B") = 0 Then oPayment.Description = ""
                           Case 3
                              tmpCardType = "Discover"
                              If InStr(reqPaymentOptions,"C") = 0 Then oPayment.Description = ""
                           Case 4
                              tmpCardType = "Amex"
                              If InStr(reqPaymentOptions,"D") = 0 Then oPayment.Description = ""
                           Case Else 
                              oPayment.Description = ""
                           End Select
                           If oPayment.Description <> "" Then
                              oPayment.Description = tmpCardType + ", ************" + Right(.CardNumber,4) + ", " + .CardMo + "/" + .CardYr + ", " + .CardName
                           End If   
                        Else
                           oPayment.Description = ""
                        End If   
                     End If   
                  End If
                  If .PayType = "2" Then   'Check
                     If InStr(reqPaymentOptions,"E") = 0 Then
                        oPayment.Description = ""
                     Else   
                        oPayment.Description = .CheckBank + ", ************" + Right(.CheckAccount,4)+ ", " + .CheckName
                     End If   
                  End If
               End With
            Next
            Set oBilling = Nothing

            xmlPayments = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPayments = Nothing
   End If
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

Sub LoadMember()
   On Error Resume Next
   If reqMemberID = 0 Then reqMemberID = Numeric(Request.Form.Item("MemberID"))
   LoadOrder

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpBillingID = .BillingID
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
         If (reqAddressID <> 0) Then
            .Load CLng(reqAddressID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqAddressID = 0) Then
            If (reqMemberID <> 0) Then
               .FetchOwner 04, CLng(reqMemberID), 3
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.Street1 = "") Then
                  .FetchOwner 04, CLng(reqMemberID), 2
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               reqAddressID = .AddressID
            End If
            If (reqAddressID = 0) Then
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .CountryID = 224
            End If
            If (reqAddressID <> 0) Then
               reqStreet12 = .Street1
               reqStreet22 = .Street2
               reqCity2 = .City
               reqState2 = .State
               reqZip2 = .Zip
               reqCountryID2 = .CountryID
            End If
         End If
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
            .Load tmpBillingID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlBilling = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBilling = Nothing
   End If
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
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .Email = Request.Form.Item("Email")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
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
         .Load CLng(reqAddressID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Street1 = Request.Form.Item("Street1")
         .Street2 = Request.Form.Item("Street2")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .CountryID = Request.Form.Item("CountryID")
         If (.CountryID = 0) Then
            .CountryID = 224
         End If
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
            .Street1 = Request.Form.Item("Street12")
            .Street2 = Request.Form.Item("Street22")
            .City = Request.Form.Item("City2")
            .State = Request.Form.Item("State2")
            .Zip = Request.Form.Item("Zip2")
            .CountryID = Request.Form.Item("CountryID2")
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

Sub Reorder(product)
   On Error Resume Next

   If (xmlError = "") Then
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
            tmpTo = .Email3
         End With
      End If
      Set oCompany = Nothing
   End If
   
      If InStr(tmpTo, "@") > 0 Then
         If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
         tmpSubject = "REORDER: " + product
         tmpBody = ""
         SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
      End If

End Sub

Sub NewOrderNotice(id)
   On Error Resume Next

   If (xmlError = "") Then
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
            tmpTo = .Email3
            
                  tmpURL = "http://" + reqSysServerName + reqSysServerPath + "5216.asp?SalesOrderID=" + CStr(id)

                  If InStr(tmpTo, "@") > 0 Then
                  If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
                     tmpSubject = "NEW ORDER: #" + CStr(id)
                     tmpBody = "<a href='" + tmpURL + "'>Sales Order Receipt</a>"
                     SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
                  End If
               
         End With
      End If
      Set oCompany = Nothing
   End If
End Sub

If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
   reqCashPayment = 1
End If
If (reqSponsorID = 0) Then
   reqSponsorID = Numeric(GetCache("A"))
End If
If (reqSysMemberID <> 0) And (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqSalesOrderID = Numeric(GetCache("SHOPPINGCART"))
      LoadMember
      reqCountryID2 = 224

   Case CLng(cActionPurchase):
      reqSalesOrderID = Numeric(GetCache("SHOPPINGCART"))

      Set oSalesItems = server.CreateObject("ptsSalesItemUser.CSalesItems")
      If oSalesItems Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesItemUser.CSalesItems"
      Else
         With oSalesItems
            .SysCurrentLanguage = reqSysLanguage
            .ListSalesOrder CLng(reqSalesOrderID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            'confirm inventoried product availability
             Set oProduct = server.CreateObject("ptsProductUser.CProduct")
            For Each oSalesItem In oSalesItems
               With oSalesItem
                  result = oProduct.CheckInventory( .ProductID, .SalesItemID )
                  If result <> -999999 AND result < 0 Then DoError 0, "", "Oops, " + .ProductName + " is no longer available."
               End With   
            Next
             Set oProduct = Nothing

         End With
      End If
      Set oSalesItems = Nothing
      If (xmlError = "") And (reqTotal <> 0) Then
         tmpPaymentMethod = Numeric(Request.Form.Item("PaymentMethod"))
         tmpPayType = Request.Form.Item("PayType")
         tmpCardNumber = Request.Form.Item("CardNumber")
         tmpCheckRoute = Request.Form.Item("CheckRoute")

         If (reqNoBill = 0) And (tmpPaymentMethod = 0) And (tmpPayType = 5) Then
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

         If (reqNoBill = 0) And (tmpPaymentMethod = 0) And (tmpPayType <= 4) Then
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
         If (xmlError = "") And (reqNoBill = 0) And (tmpPaymentMethod = 0) And (tmpPayType <= 4) Then
            tmpCardMo = Request.Form.Item("CardMo")
            tmpCardYr = Request.Form.Item("CardYr")
            tmpCardDate = tmpCardMo + "/1/" + tmpCardYr
            tmpCardDate = DATEADD("m", 1, tmpCardDate)
            If (CDate(tmpCardDate) < CDate(reqSysDate)) Then
               DoError 10013, "", "Oops, Invalid Credit Card Date."
            End If
         End If

         If (xmlError = "") And (tmpPaymentMethod = 0) And (tmpPayType <= 5) Then
            Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
            If oBilling Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
            Else
               With oBilling
                  .SysCurrentLanguage = reqSysLanguage
                  tmpPayType = Request.Form.Item("PayType")
                  If (tmpPayType <= 4) Then
                     .PayType = 1
                     .CardType = tmpPayType
                     .CardNumber = Request.Form.Item("CardNumber")
                     .CardMo = Request.Form.Item("CardMo")
                     .CardYr = Request.Form.Item("CardYr")
                     .CardName = Request.Form.Item("CardName")
                     .CardCode = Request.Form.Item("CardCode")
                     .Street1 = Request.Form.Item("Street12")
                     .Street2 = Request.Form.Item("Street22")
                     .City = Request.Form.Item("City2")
                     .State = Request.Form.Item("State2")
                     .Zip = Request.Form.Item("Zip2")
                     .CountryID = Request.Form.Item("CountryID2")
                  End If
                  If (tmpPayType = 5) Then
                     .PayType = 2
                     .CheckBank = Request.Form.Item("CheckBank")
                     .CheckRoute = Request.Form.Item("CheckRoute")
                     .CheckAccount = Request.Form.Item("CheckAccount")
                     .CheckNumber = Request.Form.Item("CheckNumber")
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
                  If (reqNoBill = 0) Then
                     .Validate 1, CLng(reqSysUserID)
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
               .AddressType = 3

               .Street1 = Request.Form.Item("Street1")
               .Street2 = Request.Form.Item("Street2")
               .City = Request.Form.Item("City")
               .State = Request.Form.Item("State")
               .Zip = Request.Form.Item("Zip")
               .CountryID = Request.Form.Item("CountryID")
               If (.CountryID = "") Or (.CountryID = "0") Then
                  .CountryID = 224
               End If
               .Validate 1, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oAddress = Nothing
      End If

      If (xmlError = "") Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqMemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .NameFirst = Request.Form.Item("NameFirst")
               .NameLast = Request.Form.Item("NameLast")
               .Email = Request.Form.Item("Email")
               .Phone1 = Request.Form.Item("Phone1")
               .Phone2 = Request.Form.Item("Phone2")
               .Fax = Request.Form.Item("Fax")
               If (.CompanyName = "") Then
                  .CompanyName = .NameLast + ", " + .NameFirst
               End If
               If (.Phone1 = "") And (.Phone2 = "") And (.Fax = "") Then
                  DoError 10006, "", "Oops, At Least 1 Phone Number is Required."
               End If
               If (xmlError = "") Then
                  tmpMemberID = reqMemberID
                  If (reqMemberID = 0) Then
                     .EnrollDate = Now
                     .CompanyID = reqCompanyID
                     .ReferralID = reqSponsorID
                     .Status = 3
                     .UserStatus = 1
                     .UserGroup = 41
                     tmpMemberID = CLng(.Add(CLng(reqSysUserID)))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (reqMemberID <> 0) Then
                     .Save CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
               End If
            End With
         End If
         Set oMember = Nothing
      End If

      If (xmlError = "") Then
         Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
         If oAddress Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
         Else
            With oAddress
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqAddressID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpStreet1 = .Street1

               .Street1 = Request.Form.Item("Street1")
               .Street2 = Request.Form.Item("Street2")
               .City = Request.Form.Item("City")
               .State = Request.Form.Item("State")
               .Zip = Request.Form.Item("Zip")
               .CountryID = Request.Form.Item("CountryID")
               If (.CountryID = "") Or (.CountryID = "0") Then
                  .CountryID = 224
               End If
               If (reqAddressID <> 0) Then
                  If (tmpStreet1 = .Street1) Then
                     .Save CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (tmpStreet1 <> .Street1) Then
                     .IsActive = 0
                     reqAddressID = CLng(.Add(CLng(reqSysUserID)))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
               End If
               If (reqAddressID = 0) Then
                  .OwnerType = 04
                  .OwnerID = tmpMemberID
                  .AddressType = 3
                  .IsActive = 1
                  reqAddressID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oAddress = Nothing
      End If

      If (xmlError = "") Then
         Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
         If oSalesOrder Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
         Else
            With oSalesOrder
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqSalesOrderID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (reqMemberID = 0) Then
                  reqMemberID = tmpMemberID
               End If
               .MemberID = reqMemberID
               .AddressID = reqAddressID
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               Result = CLng(.UpdateRecurring(Date(), CLng(reqSalesOrderID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oSalesOrder = Nothing
      End If

      If (xmlError = "") Then
         Set oSalesItems = server.CreateObject("ptsSalesItemUser.CSalesItems")
         If oSalesItems Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesItemUser.CSalesItems"
         Else
            With oSalesItems
               .SysCurrentLanguage = reqSysLanguage
               .ListSalesOrder CLng(reqSalesOrderID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
            tmpPurpose = oSalesItems.Item(1).ProductName

             Set oProduct = server.CreateObject("ptsProductUser.CProduct")
            For Each oSalesItem In oSalesItems
               With oSalesItem
                  result = oProduct.UpdateInventory( .ProductID, .SalesItemID )
                  If result <> -999999 Then 
                     Reorder(.ProductName + " " + .InputValues + " (" + CStr(result) + ")" )
                  End If   
               End With
            Next
             Set oProduct = Nothing

            End With
         End If
         Set oSalesItems = Nothing
      End If

      If (xmlError = "") And (tmpPaymentMethod <> 0) And (reqTotal <> 0) Then
         Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
         If oPayment Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
         Else
            With oPayment
               .SysCurrentLanguage = reqSysLanguage
               .Load tmpPaymentMethod, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpPayType = .PayType
               tmpDescription = .Description
            End With
         End If
         Set oPayment = Nothing
      End If

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
               .PayDate = reqSysDate
               .PayType = tmpPayType
               .Status = 1
               .Amount = reqTotal
               .Total = reqTotal
               .Description = tmpDescription
               .Purpose = tmpPurpose
               .CommStatus = 1
               If (reqNoBill <> 0) Then
                  .Status = 3
                  .Notes = .Notes + " NOT BILLED"
                  .PaidDate = reqSysDate
               End If
               PaymentID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oPayment = Nothing
      End If
      If (xmlError = "") Then
         NewOrderNotice(reqSalesOrderID)
      End If
      If (xmlError = "") Then

         If (reqCompanyID <> 0) Then
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
                  tmpCardProcessor = .MerchantCardType
                  tmpCardAcct = .MerchantCardAcct
                  tmpCheckProcessor = .MerchantCheckType
                  tmpCheckAcct = .MerchantCheckAcct
                  tmpWalletType = .WalletType
                  tmpWalletAcct = .WalletAcct
                  reqShipOption = .Shopping
                  If InStr(reqShipOption, "P") > 0 Then reqProcessPayment = 1
                  If InStr(reqShipOption, "E") > 0 Then reqExistingPayments = 1
                  EmailBonuses = InStr(reqShipOption, "N")
               End With
            End If
            Set oCoption = Nothing
         End If
         If (reqProcessPayment <> 0) Then
            If (reqNoBill = 0) Then
               PostProcess = 1
               
                        tmpProcessor = ""
                        tmpAcct = ""
                        Select Case tmpPayType
                        Case 1, 2, 3, 4   'Process Credit Cards
                        tmpProcessor = tmpCardProcessor
                        tmpAcct = tmpCardAcct
                        Case 5 'Process Electronic Checks
                        tmpProcessor = tmpCheckProcessor
                        tmpAcct = tmpCheckAcct
                        Case 11, 12, 13 'Process Wallets
                        tmpProcessor = GetWalletProcessor( tmpWalletType, tmpWalletAcct, reqPayType, tmpAcct )
                        End Select
                     
               Result = GetPayment( reqCompanyID, reqMemberID, PaymentID, tmpPayType, tmpDescription, reqTotal, tmpPurpose, tmpProcessor, tmpAcct, PostProcess, EmailBonuses )
               If (IsNumeric(Result) = 0) Then
                  DoError 0, "", Result
               End If
            End If
            If (reqNoBill <> 0) Then

               Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
               If oCompany Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
               Else
                  With oCompany
                     .SysCurrentLanguage = reqSysLanguage
                     Result = CLng(.Custom(CLng(reqCompanyID), 99, 0, PaymentID, 0))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oCompany = Nothing
               If (EmailBonuses <> 0) Then
                  CommissionEmail reqCompanyID, PaymentID, 0, 0, tmpTotal
               End If
            End If
            If (xmlError = "") Then

               Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
               If oSalesOrder Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
               Else
                  With oSalesOrder
                     .SysCurrentLanguage = reqSysLanguage
                     .Custom CLng(reqCompanyID), 1, CLng(reqSalesOrderID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oSalesOrder = Nothing
            End If
         End If
         If (xmlError = "") And (reqCompanyID = 14) Then
            If (xmlError = "") Then

               Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
               If oCompany Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
               Else
                  With oCompany
                     .SysCurrentLanguage = reqSysLanguage
                     Count = CLng(.Custom(CLng(reqCompanyID), 100, 0, CLng(reqMemberID), 0))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oCompany = Nothing
            End If
         End If
         If (xmlError = "") Then
            Response.Redirect "5254.asp?txn=1&SalesOrderID=" + CStr(reqSalesOrderID)
         End If
      End If
      If (xmlError <> "") Then
         ReloadMember
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("5253URL")
      reqReturnData = GetCache("5253DATA")
      SetCache "5253URL", ""
      SetCache "5253DATA", ""
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
xmlParam = xmlParam + " salesorderid=" + Chr(34) + CStr(reqSalesOrderID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " addressid=" + Chr(34) + CStr(reqAddressID) + Chr(34)
xmlParam = xmlParam + " sponsorid=" + Chr(34) + CStr(reqSponsorID) + Chr(34)
xmlParam = xmlParam + " paymentoptions=" + Chr(34) + CleanXML(reqPaymentOptions) + Chr(34)
xmlParam = xmlParam + " total=" + Chr(34) + CStr(reqTotal) + Chr(34)
xmlParam = xmlParam + " processpayment=" + Chr(34) + CStr(reqProcessPayment) + Chr(34)
xmlParam = xmlParam + " memberemail=" + Chr(34) + CleanXML(reqMemberEmail) + Chr(34)
xmlParam = xmlParam + " shipoption=" + Chr(34) + CleanXML(reqShipOption) + Chr(34)
xmlParam = xmlParam + " existingpayments=" + Chr(34) + CStr(reqExistingPayments) + Chr(34)
xmlParam = xmlParam + " nobill=" + Chr(34) + CStr(reqNoBill) + Chr(34)
xmlParam = xmlParam + " cashpayment=" + Chr(34) + CStr(reqCashPayment) + Chr(34)
xmlParam = xmlParam + " wallet=" + Chr(34) + CleanXML(reqWallet) + Chr(34)
xmlParam = xmlParam + " street12=" + Chr(34) + CleanXML(reqStreet12) + Chr(34)
xmlParam = xmlParam + " street22=" + Chr(34) + CleanXML(reqStreet22) + Chr(34)
xmlParam = xmlParam + " city2=" + Chr(34) + CleanXML(reqCity2) + Chr(34)
xmlParam = xmlParam + " state2=" + Chr(34) + CleanXML(reqState2) + Chr(34)
xmlParam = xmlParam + " zip2=" + Chr(34) + CleanXML(reqZip2) + Chr(34)
xmlParam = xmlParam + " countryid2=" + Chr(34) + CleanXML(reqCountryID2) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlSalesOrder
xmlTransaction = xmlTransaction +  xmlPayments
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlAddress
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlSalesItems
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\5253[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\5253[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "5253 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "5253 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "5253 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "5253.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "5253 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "5253 Load file (oData) failed with error code " + CStr(oData.parseError)
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
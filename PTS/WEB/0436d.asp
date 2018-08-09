<!--#include file="Include\System.asp"-->
<!--#include file="Include\Billing.asp"-->
<!--#include file="Include\Payment.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\CommissionEmail.asp"-->
<!--#include file="Include\IP.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionBilling = 5
Const cActionAddBilling = 7
Const cActionReprocess = 8
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
Dim oPayout, xmlPayout
Dim oMember, xmlMember
Dim oNexxus, xmlNexxus
Dim oBilling, xmlBilling
Dim oPayments, xmlPayments
Dim oPayment, xmlPayment
'-----other transaction data variables
Dim xmlPayment2
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqBillingID
Dim reqPaymentID
Dim reqDeclines
Dim reqCash
Dim reqProcessStatus
Dim reqPayType
Dim reqPayDesc
Dim reqPayAmount
Dim reqWallet
Dim reqWalletNumber
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
   SetCache "0436dURL", reqReturnURL
   SetCache "0436dDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0436d")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqPaymentID =  Numeric(GetInput("PaymentID", reqPageData))
reqDeclines =  Numeric(GetInput("Declines", reqPageData))
reqCash =  Numeric(GetInput("Cash", reqPageData))
reqProcessStatus =  Numeric(GetInput("ProcessStatus", reqPageData))
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqPayDesc =  GetInput("PayDesc", reqPageData)
reqPayAmount =  GetInput("PayAmount", reqPageData)
reqWallet =  GetInput("Wallet", reqPageData)
reqWalletNumber =  GetInput("WalletNumber", reqPageData)
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

Sub GetWallet()
   On Error Resume Next

   Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
   If oPayout Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
   Else
      With oPayout
         .SysCurrentLanguage = reqSysLanguage
         Result = .WalletTotal(04, CLng(reqMemberID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            a = Split(Result, ";")
            reqWalletNumber = a(0)
            reqWallet = FormatCurrency(a(0),2)
          
      End With
   End If
   Set oPayout = Nothing
End Sub

Sub ActivateMember()
   On Error Resume Next

   If (reqProcessStatus <> 0) And (reqDeclines = 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.Status = 4) Then
               .Status = 1
               reqProcessStatus = 2
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   Set oNexxus = server.CreateObject("ptsNexxusUser.CNexxus")
   If oNexxus Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsNexxusUser.CNexxus"
   Else
      With oNexxus
         .SysCurrentLanguage = reqSysLanguage
         Count = CLng(.Custom(503, 0, CLng(reqMemberID), 0))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oNexxus = Nothing
End Sub

Sub LoadBilling()
   On Error Resume Next
   GetWallet

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqBillingID = .BillingID
         reqCompanyID = .CompanyID
         xmlMember = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBillingID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.CardNumber <> "") Then
            .CardNumber = "xxxxxxxxxxxx" + Right(.CardNumber,4)
         End If
         If (.CardCode <> "") Then
            .CardCode = "xxx"
         End If
         If (.CheckAccount <> "") Then
            .CheckAccount = "xxxx" + Right(.CheckAccount,4)
         End If
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

Sub LoadLists()
   On Error Resume Next

   Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
   If oPayments Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayments"
   Else
      With oPayments
         .SysCurrentLanguage = reqSysLanguage
         tmpFromDate = DateAdd("yyyy", -1, reqSysDate)
         tmpToDate = DateAdd("d", 1, reqSysDate)
         reqBookmark = .FindMember(1008, "", "", 1, CLng(reqMemberID), tmpFromDate, tmpToDate, CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
                  For Each oPayment In oPayments
                     If oPayment.Status = 4 Then reqDeclines = reqDeclines + 1
                     If oPayment.Status < 3 And oPayment.PayType = 7 Then reqCash = reqCash + 1
                     If oPayment.PayType <= 5 Then
                        PaymentBilling oPayment.Description, oBilling
                        With oBilling
                           If .PayType = "1" Then   'Credit Card
                           Select Case .CardType
                           Case 1
                           tmpCardType = "Visa"
                           Case 2
                           tmpCardType = "MasterCard"
                           Case 3
                           tmpCardType = "Discover"
                           Case 4
                           tmpCardType = "Amex"
                           End Select
                           oPayment.Description = tmpCardType + ", ************" + Right(.CardNumber,4) + ", " + .CardMo + "/" + .CardYr + ", " + .CardName
                           End If
                           If .PayType = "2" Then   'Check
                           oPayment.Description = .CheckBank + ", ************" + Right(.CheckAccount,4)+ ", " + .CheckName
                           End If
                        End With
                     End If
                  Next
                  Set oBilling = Nothing
               
         xmlPayments = .XML(15)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPayments = Nothing

   Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
   If oPayments Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayments"
   Else
      With oPayments
         .SysCurrentLanguage = reqSysLanguage
         reqBookmark = .FindOwner(1008, "", "", 1, 04, CLng(reqMemberID), CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
                  For Each oPayment In oPayments
                     If oPayment.Status = 4 Then reqDeclines = reqDeclines + 1
                     If oPayment.PayType <= 5 Then
                        PaymentBilling oPayment.Description, oBilling
                        With oBilling
                           If .PayType = "1" Then   'Credit Card
                           Select Case .CardType
                           Case 1
                           tmpCardType = "Visa"
                           Case 2
                           tmpCardType = "MasterCard"
                           Case 3
                           tmpCardType = "Discover"
                           Case 4
                           tmpCardType = "Amex"
                           End Select
                           oPayment.Description = tmpCardType + ", ************" + Right(.CardNumber,4) + ", " + .CardMo + "/" + .CardYr + ", " + .CardName
                           End If
                           If .PayType = "2" Then   'Check
                           oPayment.Description = .CheckBank + ", ************" + Right(.CheckAccount,4)+ ", " + .CheckName + ", " + .CheckAcctType
                           End If
                        End With
                     End If
                  Next
                  Set oBilling = Nothing
               
         xmlPayment2 = .XML(15, "Payment2")
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPayments = Nothing
End Sub

Sub UpdateMethod()
   On Error Resume Next
   reqPayType = 0
   reqPayDesc = ""

   If (reqBillingID <> 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqBillingID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPayDesc = BillingPayment( oBilling )
            If (.PayType = 1) Then
               reqPayType = .CardType
            End If
            If (.PayType = 2) Then
               reqPayType = 5
            End If
            If (.PayType = 3) Then
               reqPayType = 7
            End If
            If (.PayType = 4) Then
               reqPayType = .CardType
            End If
         End With
      End If
      Set oBilling = Nothing
   End If

   If (reqPayType <> 0) Then
      Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
      Else
         With oPayment
            .SysCurrentLanguage = reqSysLanguage
            .Load reqPaymentID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPayAmount = .Total
            .PayType = reqPayType
            .Description = reqPayDesc
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPayment = Nothing
   End If
End Sub

Sub SubmitPayment()
   On Error Resume Next
   GetWallet
   WalletPrice = reqPayAmount
   If (reqCompanyID = 21) Then
      If (WalletPrice = 11) Then
         WalletPrice = 10
      End If
      If (WalletPrice = 27) Then
         WalletPrice = 25
      End If
      If (WalletPrice = 53) Then
         WalletPrice = 50
      End If
   End If
   If (CCUR(reqWalletNumber) >= CCUR(WalletPrice)) Then
      BillingPrice = WalletPrice

      If (xmlError = "") Then
         Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
         If oPayout Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
         Else
            With oPayout
               .SysCurrentLanguage = reqSysLanguage
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
              IP = Request.ServerVariables("REMOTE_ADDR")
              tmpLocation = GetIPCity( IP )
            
               .CompanyID = reqCompanyID
               .OwnerType = 04
               .OwnerID = reqMemberID
               .PayDate = reqSysDate
               .PaidDate = reqSysDate
               .Status = 1
               .PayType = 5
               .Amount = BillingPrice * -1
               .Reference = reqPaymentID
               .Notes = Left( .Notes + " " + IP + " " + tmpLocation, 500) 
               PayoutID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oPayout = Nothing
      End If

      If (xmlError = "") Then
         Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
         If oPayment Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
         Else
            With oPayment
               .SysCurrentLanguage = reqSysLanguage
               .Load reqPaymentID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .PaidDate = reqSysDate
               .PayType = 90
               .Status = 3
               .Amount = BillingPrice
               .Total = BillingPrice
               .Reference = PayoutID
               .CommStatus = 1
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oPayment = Nothing
      End If
      If (xmlError = "") Then

         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(CLng(reqCompanyID), 99, 0, reqPaymentID, 0))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCompany = Nothing
      End If
   End If
   If (CCUR(reqWalletNumber) < CCUR(WalletPrice)) Then

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
            tmpPrice1 = .Price
            tmpPrice2 = .Price2
            tmpPrice3 = .Price3
            reqSysUserOptions = .Options
            tmpSendEmail = .IsNewEmail
            tmpCardProcessor = .MerchantCardType
            tmpCardAcct = .MerchantCardAcct
            tmpCheckProcessor = .MerchantCheckType
            tmpCheckAcct = .MerchantCheckAcct
            ShipOption = .Shopping
            EmailBonuses = InStr(ShipOption, "N")
         End With
      End If
      Set oCoption = Nothing
      PostProcess = 1
      
                 tmpProcessor = 0
                 tmpAcct = ""
                 Select Case reqPayType
                 Case 1, 2, 3, 4   'Process Credit Cards
                    tmpProcessor = tmpCardProcessor
                    tmpAcct = tmpCardAcct
                 Case 5 'Process Electronic Checks
                    tmpProcessor = tmpCheckProcessor
                    tmpAcct = tmpCheckAcct
                 End Select
              
      Result = GetPayment( reqCompanyID, reqMemberID, reqPaymentID, reqPayType, reqPayDesc, reqPayAmount, "", tmpProcessor, tmpAcct, PostProcess, EmailBonuses )
      If (IsNumeric(Result) <> 0) Then
         reqProcessStatus = 1
      End If
      If (IsNumeric(Result) = 0) Then
         DoError 0, "", Result
      End If
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadBilling
      LoadLists

   Case CLng(cActionBilling):

      Response.Redirect "2903.asp" & "?MemberID=" & reqMemberID & "&CompanyID=" & reqCompanyID & "&BillingID=" & reqBillingID & "&contentpage=" & 3 & "&V=" & 1 & "&ReturnURL=" & reqPageURL

   Case CLng(cActionAddBilling):

      Response.Redirect "2902.asp" & "?MemberID=" & reqMemberID & "&CompanyID=" & reqCompanyID & "&contentpage=" & 3 & "&ReturnURL=" & reqPageURL

   Case CLng(cActionReprocess):
      UpDateMethod
      SubmitPayment
      LoadBilling
      LoadLists
      If (reqProcessStatus <> 0) And (reqDeclines = 0) Then
         ActivateMember
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " paymentid=" + Chr(34) + CStr(reqPaymentID) + Chr(34)
xmlParam = xmlParam + " declines=" + Chr(34) + CStr(reqDeclines) + Chr(34)
xmlParam = xmlParam + " cash=" + Chr(34) + CStr(reqCash) + Chr(34)
xmlParam = xmlParam + " processstatus=" + Chr(34) + CStr(reqProcessStatus) + Chr(34)
xmlParam = xmlParam + " paytype=" + Chr(34) + CStr(reqPayType) + Chr(34)
xmlParam = xmlParam + " paydesc=" + Chr(34) + CleanXML(reqPayDesc) + Chr(34)
xmlParam = xmlParam + " payamount=" + Chr(34) + CStr(reqPayAmount) + Chr(34)
xmlParam = xmlParam + " wallet=" + Chr(34) + CStr(reqWallet) + Chr(34)
xmlParam = xmlParam + " walletnumber=" + Chr(34) + CStr(reqWalletNumber) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlPayout
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlNexxus
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlPayments
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlPayment2
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\0436d[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\0436d[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0436d Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0436d Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0436d Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0436d.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0436d Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0436d Load file (oData) failed with error code " + CStr(oData.parseError)
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
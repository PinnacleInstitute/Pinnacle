<!--#include file="Include\System.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\Payout.asp"-->
<!--#include file="Include\Billing.asp"-->
<!--#include file="Include\Payment.asp"-->
<!--#include file="Include\Wallet.asp"-->
<!--#include file="Include\PaymentFile.asp"-->
<!--#include file="Include\Orders.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\CommissionEmail.asp"-->
<!--#include file="Include\DeclineEmail.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
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
'-----other transaction data variables
Dim xmlMembers
Dim xmlPeopleEdges
'-----declare page parameters
Dim reqCompanyID
Dim reqProcess
Dim reqFromDate
Dim reqToDate
Dim reqOption
Dim reqResult
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
   SetCache "13600URL", reqReturnURL
   SetCache "13600DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "13600")
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
reqProcess =  Numeric(GetInput("Process", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
reqOption =  Numeric(GetInput("Option", reqPageData))
reqResult =  GetInput("Result", reqPageData)
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 125
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

reqCompanyID = 16
Server.ScriptTimeout = 14400
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqSysUserGroup = 21) Then
         If InStr( ",2,3,5,6,11,12,13,21,22,23,24,25,26,27,29,30,31,33,34,35,37,39,40,41,42,43,44,45,46,47,48,49,50,", CSTR(reqProcess)+"," ) = 0 Then reqProcess = 0
      End If
      
   'Set date range to previous month
   If reqOption = 0 Then
   reqFromDate = CSTR(Month(reqSysDate)) + "/1/" + CSTR(Year(reqSysDate))
   reqToDate = DateAdd( "d", -1, reqFromDate )
   reqFromDate = DateAdd( "m", -1, reqFromDate )
   End If
   'Set date range to current date
   If reqOption = 1 Then
   reqToDate = reqSysDate
   reqFromDate = reqSysDate
   End If
   'Set date range to previous month
   If reqOption = 2 Then
   reqToDate = CSTR(Month(reqSysDate)) + "/1/" + CSTR(Year(reqSysDate))
   reqFromDate = DateAdd( "m", -1, reqToDate )
   reqToDate = DateAdd( "d", -1, reqToDate )
   End If
   'Set date range to one month back from last Sunday
   If reqOption = 3 Then
   reqToDate = DateAdd( "d", -5, reqSysDate )
   reqFromDate = DateAdd( "m", -1, reqToDate )
   End If
   'Set date range to 1 week back
   If reqOption = 4 Then
   reqToDate = DateAdd( "d", -1, reqSysDate )
   reqFromDate = DateAdd( "d", -7, reqToDate )
   End If
   'Set date range to yesterday
   If reqOption = 5 Then
   reqFromDate = DateAdd( "d", -1, reqSysDate )
   reqToDate = reqFromDate
   End If
   'Set date range to 2 days ago
   If reqOption = 6 Then
   reqFromDate = DateAdd( "d", -2, reqSysDate )
   reqToDate = reqFromDate
   End If
   'Set date range to 3 days ago
   If reqOption = 7 Then
   reqFromDate = DateAdd( "d", -3, reqSysDate )
   reqToDate = reqFromDate
   End If
   'Set date range to 4 days ago
   If reqOption = 8 Then
   reqFromDate = DateAdd( "d", -4, reqSysDate )
   reqToDate = reqFromDate
   End If
   'Set date range to 5 days ago
   If reqOption = 9 Then
   reqFromDate = DateAdd( "d", -5, reqSysDate )
   reqToDate = reqFromDate
   End If
   'Set todate to 1 week back
   If reqOption = 11 Then
   reqToDate = DateAdd( "d", -7, reqSysDate )
   End If
   'Set todate to 2 weeks back
   If reqOption = 12 Then
   reqToDate = DateAdd( "d", -14, reqSysDate )
   End If
   'Set todate to 3 weeks back
   If reqOption = 13 Then
   reqToDate = DateAdd( "d", -21, reqSysDate )
   End If
   'Set todate to 4 weeks back
   If reqOption = 14 Then
   reqToDate = DateAdd( "d", -28, reqSysDate )
   End If


   Case CLng(cActionUpdate):
      If (reqProcess = 12) Or (reqProcess = 39) Or (reqProcess = 47) Then
         If (reqFromDate = "") Or (reqToDate = "") Then
            DoError 10115, "", "Oops, Specify the date range to process."
         End If
      End If
      If (reqProcess = 2) Or (reqProcess = 11) Or (reqProcess = 21) Or (reqProcess = 24) Or (reqProcess = 25) Or (reqProcess = 35) Or (reqProcess = 28) Or (reqProcess = 48) Or (reqProcess = 49) Then
         If (reqToDate = "") Then
            DoError 10115, "", "Oops, Specify the date range to process."
         End If
      End If
      If (xmlError = "") Then
         If (reqProcess = 1) Then
            
                     Result = BillingTokens()
                     aResult = Split(Result, "|")
                     reqResult = aResult(0) + " New Billing Tokens Successfully Created! (" + aResult(1) + " bad)"
                  
         End If
         If (reqProcess = 2) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(200, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " New Payments Successfully Created!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 3) Then
            
                     PaymentOwnerType = 4
                     PostProcess = 1
                     Result = ProcessPayments( reqCompanyID, PaymentOwnerType, "1/1/2099", PostProcess )
                     aResult = Split(Result, "|")
                     reqResult = aResult(0) + " Payments Successfully Processed! (" + aResult(1) + " bad)"
                  
            If (aResult(0) <> 0) Then
               LogNote 38, reqCompanyID, reqResult
            End If
         End If
         If (reqProcess = 4) Then

            Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
            If oMembers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
            Else
               With oMembers
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList reqCompanyID, 101, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlMembers = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Declined Tokens!"
               End With
            End If
            Set oMembers = Nothing
         End If
         If (reqProcess = 5) Then

            Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
            If oMembers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
            Else
               With oMembers
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList reqCompanyID, 102, 4
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlMembers = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Declined Payments!"
               End With
            End If
            Set oMembers = Nothing
         End If
         If (reqProcess = 6) Then

            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(reqCompanyID, 201, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Declined Payments Updated!"
               End With
            End If
            Set oCompany = Nothing
         End If
         If (reqProcess = 11) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(3, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Members Qualified to Earn Bonuses!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 12) Then

            Set oCommission = server.CreateObject("ptsCommissionUser.CCommission")
            If oCommission Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCommissionUser.CCommission"
            Else
               With oCommission
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.CustomCommissions(reqCompanyID, 1, reqFromDate, reqToDate))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  Amount = CLng(.TotalCommissions(reqCompanyID, CDate(reqSysDate)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " New Bonuses Created! (" & FormatCurrency(Amount,2) & ")"
               End With
            End If
            Set oCommission = Nothing
            If (Count <> 0) Then
               LogNote 38, reqCompanyID, reqResult
            End If
         End If
         If (reqProcess = 13) Then

            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(reqCompanyID, 202, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "All Hidden Bonuses Displayed!"
               End With
            End If
            Set oCompany = Nothing
         End If
         If (reqProcess = 21) Then

            Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
            If oPayout Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
            Else
               With oPayout
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.CompanyPayouts(reqCompanyID, reqToDate))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " New Payouts Created!"
               End With
            End If
            Set oPayout = Nothing
         End If
         If (reqProcess = 22) Then

            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(reqCompanyID, 4, 0, 30, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Payment Credits Created!"
               End With
            End If
            Set oCompany = Nothing
         End If
         If (reqProcess = 23) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(6, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Members Qualified to Receive a Payout!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 24) Then
            Total = 0
            ExportWallet reqCompanyID, 12, reqToDate, -1, tmpTotal, tmpFile, tmpAmount
            Total = Total + tmpTotal
            If (tmpTotal <> 0) Then
               URL = "http://www.pinnaclep.com/payout/" + CStr(reqCompanyID) + "/" + tmpFile
               LINK = "<a href=""" + URL + """ target=""_blank"">" + URL + "</a>"
               MSG = CSTR(tmpTotal) + " PayQuicker eWallets (" & FormatCurrency(tmpAmount,2) & ")  "
               reqResult = reqResult + MSG + LINK + "<br>"
               NOTE = NOTE + MSG + URL + "  " + VBLF
            End If
            If (tmpTotal = 0) Then
               reqResult = "No Payouts to Export!"
            End If
            If (Total <> 0) Then
               NOTE = NOTE + " to " + CStr(reqToDate)
               LogNote 38, reqCompanyID, NOTE

               Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
               If oPayout Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
               Else
                  With oPayout
                     .SysCurrentLanguage = reqSysLanguage
                     Count = CLng(.CompanyStatus2(reqCompanyID, reqToDate, CDate(reqSysDate), -1, "3"))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oPayout = Nothing
            End If
         End If
         If (reqProcess = 25) Then

            Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
            If oPayout Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
            Else
               With oPayout
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.CompanyStatus2(reqCompanyID, reqToDate, CDate(reqSysDate), 0, "3"))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Pending Payouts Marked Paid!"
               End With
            End If
            Set oPayout = Nothing
         End If
         If (reqProcess = 26) Then

            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(reqCompanyID, 203, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "All Hidden Payouts Displayed!"
               End With
            End If
            Set oCompany = Nothing
         End If
         If (reqProcess = 27) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(1, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Group Sales Totals Recalculated!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 28) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(2, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Sales Summary Postings!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 29) Then

            Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
            If oMembers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
            Else
               With oMembers
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList reqCompanyID, 3, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlMembers = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Orphaned Affiliates!"
               End With
            End If
            Set oMembers = Nothing
         End If
         If (reqProcess = 30) Then

            Set oPeopleEdges = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdges")
            If oPeopleEdges Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdges"
            Else
               With oPeopleEdges
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList 3, 0, 0, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlPeopleEdges = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "New eWallets to be imported to iPayout in a .CSV file!"
               End With
            End If
            Set oPeopleEdges = Nothing
         End If
         If (reqProcess = 31) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(105, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " New eWallets Assigned!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 33) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(11, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Member Alerts Set!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 34) Then

            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(reqCompanyID, 12, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Data Cleaned Up!"
               End With
            End If
            Set oCompany = Nothing
         End If
         If (reqProcess = 35) Then
            Total = 0
            ExportOrder reqCompanyID, 101, reqToDate, 1, tmpFile, tmpTotal, tmpAmount
            Total = Total + tmpTotal
            If (tmpTotal <> 0) Then
               URL = "http://www.pinnaclep.com/orders/" + CStr(reqCompanyID) + "/" + tmpFile
               LINK = "<a href=""" + URL + """ target=""_blank"">" + URL + "</a>"
               MSG = CSTR(tmpTotal) + " GFT Submitted Orders (" & FormatCurrency(tmpAmount,2) & ")  "
               reqResult = reqResult + MSG + LINK + "<br>"
               NOTE = NOTE + MSG + URL + "  " + VBLF
            End If
            If (Total <> 0) Then
               LogNote 38, reqCompanyID, NOTE
            End If

            Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
            If oSalesOrder Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
            Else
               With oSalesOrder
                  .SysCurrentLanguage = reqSysLanguage
                  .Custom2 reqCompanyID, 101, reqToDate, 0, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oSalesOrder = Nothing
         End If
         If (reqProcess = 37) Then

            Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
            If oSalesOrder Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
            Else
               With oSalesOrder
                  .SysCurrentLanguage = reqSysLanguage
                  .Custom2 reqCompanyID, 102, 0, 0, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Order Status Updated to Complete!"
               End With
            End If
            Set oSalesOrder = Nothing
         End If
         If (reqProcess = 39) Then
            CommissionEmail reqCompanyID, 0, reqFromDate, reqToDate, tmpTotal
            reqResult = tmpTotal & " Commission Emails Sent"
         End If
         If (reqProcess = 40) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(15, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "All Title Advancements Calculated!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 41) Then
            PaymentOwnerType = 52
            ExportPayments reqCompanyID, PaymentOwnerType, "1/1/2099", CCTotal, CKTotal, CCFile, CKFile, ErrorMsg
            If (ErrorMsg <> "") Then
               
                        response.write ErrorMsg
                        response.end
                     
            End If
            If (CCTotal <> 0) Then
               URL = "http://www.pinnaclep.com/Billing/" + CStr(reqCompanyID) + "/" + CCFile
               LINK = "<a href=""" + URL + """ target=""_blank"">" + URL + "</a>"
               MSG = CSTR(CCTotal) + " CC Payments "
               reqResult = reqResult + MSG + LINK + "<br>"
               NOTE = NOTE + MSG + URL + "  " + VBLF
            End If
            If (CKTotal <> 0) Then
               URL = "http://www.pinnaclep.com/billing/" + CStr(reqCompanyID) + "/" + CKFile
               LINK = "<a href=""" + URL + """ target=""_blank"">" + URL + "</a>"
               MSG = CSTR(CKTotal) + " ACH Payments "
               reqResult = reqResult + MSG + LINK + "<br>"
               NOTE = NOTE + MSG + URL + "  " + VBLF
            End If
            If (CCTotal + CKTotal <> 0) Then
               LogNote 38, reqCompanyID, NOTE
            End If
         End If
         If (reqProcess = 43) Then

            Set oPeopleEdge = server.CreateObject("ptsPeopleEdgeUser.CPeopleEdge")
            If oPeopleEdge Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPeopleEdgeUser.CPeopleEdge"
            Else
               With oPeopleEdge
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(301, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Binary Downline member counts Updated!"
               End With
            End If
            Set oPeopleEdge = Nothing
         End If
         If (reqProcess = 44) Then

            Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
            If oMembers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
            Else
               With oMembers
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList reqCompanyID, 99, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlMembers = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Top Recruiters!"
               End With
            End If
            Set oMembers = Nothing
         End If
         If (reqProcess = 45) Then

            Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
            If oMembers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
            Else
               With oMembers
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList reqCompanyID, 98, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlMembers = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Top Earners!"
               End With
            End If
            Set oMembers = Nothing
         End If
         If (reqProcess = 46) Then

            Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
            If oMembers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
            Else
               With oMembers
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList reqCompanyID, 97, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlMembers = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Top Countries!"
               End With
            End If
            Set oMembers = Nothing
         End If
         If (reqProcess = 47) Then
            Total = 0
            DeclineEmail reqCompanyID, 0, 0, reqFromDate, reqToDate, tmpTotal
            reqResult = tmpTotal & " Declined Payments Emailed!"
         End If
      End If
      If (reqProcess = 48) Then

         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(reqCompanyID, 207, reqToDate, 0, 0))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqResult = Count & " Members Suspended with Declined Payments!"
            End With
         End If
         Set oCompany = Nothing
      End If
      If (reqProcess = 49) Then

         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(reqCompanyID, 208, reqToDate, 0, 0))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqResult = Count & " Suspended Members Cancelled with Declined Payments!"
            End With
         End If
         Set oCompany = Nothing
      End If
      If (reqProcess = 50) Then

         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(reqCompanyID, 209, reqToDate, 0, 0))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqResult = Count & " Declined Payments Resubmitted!"
            End With
         End If
         Set oCompany = Nothing
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
xmlParam = xmlParam + " process=" + Chr(34) + CStr(reqProcess) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " option=" + Chr(34) + CStr(reqOption) + Chr(34)
xmlParam = xmlParam + " result=" + Chr(34) + CleanXML(reqResult) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMembers
xmlTransaction = xmlTransaction +  xmlPeopleEdges
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\13600[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\13600[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "13600 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "13600 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "13600 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "13600.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "13600 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "13600 Load file (oData) failed with error code " + CStr(oData.parseError)
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
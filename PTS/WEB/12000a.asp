<!--#include file="Include\System.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\Payout.asp"-->
<!--#include file="Include\Payment.asp"-->
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
Dim xmlLifeTimes
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
   SetCache "12000aURL", reqReturnURL
   SetCache "12000aDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "12000a")
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

reqCompanyID = 8
Server.ScriptTimeout = 14400
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqSysUserGroup = 21) Then
         If InStr( "2,3,5,6,11,12,13,21,23,24,25,26,29,33,34,41,47,48,49", CSTR(reqProcess)+"," ) = 0 Then reqProcess = 0
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
               reqFromDate = DateAdd( "m", -1, reqSysDate )
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
               'Set date range to one week back
               If reqOption = 4 Then
               reqToDate = DateAdd( "d", -1, reqSysDate )
               reqFromDate = DateAdd( "d", -7, reqToDate )
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

            Set oLifeTime = server.CreateObject("ptsLifeTimeUser.CLifeTime")
            If oLifeTime Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTime"
            Else
               With oLifeTime
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(200, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " New Payments Successfully Created!"
               End With
            End If
            Set oLifeTime = Nothing
         End If
         If (reqProcess = 3) Then
            
                     Result = ProcessPayments()
                     aResult = Split(Result, "|")
                     reqResult = aResult(0) + " Payments Successfully Processed! (" + aResult(1) + " bad)"
                  
            LogNote 38, reqCompanyID, reqResult
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
                  .CustomList reqCompanyID, 100, 4
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

            Set oLifeTime = server.CreateObject("ptsLifeTimeUser.CLifeTime")
            If oLifeTime Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTime"
            Else
               With oLifeTime
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(3, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Members Qualified to Earn Bonuses!"
               End With
            End If
            Set oLifeTime = Nothing
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
            LogNote 38, reqCompanyID, reqResult
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
                  Count = CLng(.Custom(reqCompanyID, 4, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Payment Credits Created!"
               End With
            End If
            Set oCompany = Nothing
         End If
         If (reqProcess = 23) Then

            Set oLifeTime = server.CreateObject("ptsLifeTimeUser.CLifeTime")
            If oLifeTime Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTime"
            Else
               With oLifeTime
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(6, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Members Qualified to Receive a Bonus Check!"
               End With
            End If
            Set oLifeTime = Nothing
         End If
         If (reqProcess = 24) Then
            Total = 0
            ExportWallet reqCompanyID, reqToDate, 0, tmpTotal, tmpFile, tmpAmount
            Total = Total + tmpTotal
            If (tmpTotal <> 0) Then
               URL = "http://www.pinnaclep.com/payout/" + CStr(reqCompanyID) + "/" + tmpFile
               LINK = "<a href=""" + URL + """ target=""_blank"">" + URL + "</a>"
               MSG = CSTR(tmpTotal) + " eWallets (" & FormatCurrency(tmpAmount,2) & ")  "
               reqResult = reqResult + MSG + LINK + "<br>"
               NOTE = NOTE + MSG + URL + "  " + VBLF
            End If
            ExportCheck reqCompanyID, reqToDate, 0, tmpTotal, tmpFile, tmpAmount
            Total = Total + tmpTotal
            If (tmpTotal <> 0) Then
               URL = "http://www.pinnaclep.com/payout/" + CStr(reqCompanyID) + "/" + tmpFile
               LINK = "<a href=""" + URL + """ target=""_blank"">" + URL + "</a>"
               MSG = CSTR(tmpTotal) + " Checks (" & FormatCurrency(tmpAmount,2) & ")  "
               reqResult = reqResult + MSG + LINK + "<br>"
               NOTE = NOTE + MSG + URL + "  " + VBLF
            End If
            If (Total = 0) Then
               reqResult = "No Payouts to Export!"
            End If
            If (Total <> 0) Then
               LogNote 38, reqCompanyID, NOTE
            End If
         End If
         If (reqProcess = 25) Then

            Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
            If oPayout Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
            Else
               With oPayout
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.CompanyStatus2(reqCompanyID, reqToDate, CDate(reqSysDate), 0, "23"))
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

            Set oLifeTime = server.CreateObject("ptsLifeTimeUser.CLifeTime")
            If oLifeTime Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTime"
            Else
               With oLifeTime
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(1, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "Group Sales Volumes and Promotions Recalculated!"
               End With
            End If
            Set oLifeTime = Nothing
         End If
         If (reqProcess = 28) Then

            Set oLifeTime = server.CreateObject("ptsLifeTimeUser.CLifeTime")
            If oLifeTime Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTime"
            Else
               With oLifeTime
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(2, reqToDate, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Sales Summary Postings!"
               End With
            End If
            Set oLifeTime = Nothing
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

            Set oLifeTimes = server.CreateObject("ptsLifeTimeUser.CLifeTimes")
            If oLifeTimes Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTimes"
            Else
               With oLifeTimes
                  .SysCurrentLanguage = reqSysLanguage
                  .CustomList 3, 0, 0, 0
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlLifeTimes = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = "New eWallets to be imported to iPayout in a .CSV file!"
               End With
            End If
            Set oLifeTimes = Nothing
         End If
         If (reqProcess = 31) Then

            Set oLifeTime = server.CreateObject("ptsLifeTimeUser.CLifeTime")
            If oLifeTime Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTime"
            Else
               With oLifeTime
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(105, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " New eWallets Assigned!"
               End With
            End If
            Set oLifeTime = Nothing
         End If
         If (reqProcess = 33) Then

            Set oLifeTime = server.CreateObject("ptsLifeTimeUser.CLifeTime")
            If oLifeTime Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsLifeTimeUser.CLifeTime"
            Else
               With oLifeTime
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(11, 0, 0, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqResult = Count & " Member Alerts Set!"
               End With
            End If
            Set oLifeTime = Nothing
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
xmlTransaction = xmlTransaction +  xmlLifeTimes
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\12000a[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\12000a[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "12000a Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "12000a Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "12000a Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "12000a.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "12000a Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "12000a Load file (oData) failed with error code " + CStr(oData.parseError)
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
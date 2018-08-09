<!--#include file="Include\System.asp"-->
<!--#include file="Include\Debt.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
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
Dim oMember, xmlMember
Dim oFinance, xmlFinance
Dim oDebts, xmlDebts
'-----other transaction data variables
Dim xmlYEAR
Dim xmlDA
'-----declare page parameters
Dim reqMemberID
Dim reqFinanceID
Dim reqExtraPayment
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
   SetCache "10212URL", reqReturnURL
   SetCache "10212DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "10212")
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
reqFinanceID =  Numeric(GetInput("FinanceID", reqPageData))
reqExtraPayment =  Numeric(GetInput("ExtraPayment", reqPageData))
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

Sub LoadMember()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub LoadFinance()
   On Error Resume Next

   Set oFinance = server.CreateObject("ptsFinanceUser.CFinance")
   If oFinance Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsFinanceUser.CFinance"
   Else
      With oFinance
         .SysCurrentLanguage = reqSysLanguage
         .FetchMemberID CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqFinanceID = .FinanceID
         If (reqFinanceID <> 0) Then
            .Load reqFinanceID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            Payoff = .Payoff
            Payment = .Payment
            Savings = .Savings
            StartDate = .StartDate
            IsMinPayment = .IsMinPayment
         End If
         xmlFinance = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oFinance = Nothing
End Sub

Sub AnalyzeDebt()
   On Error Resume Next
   LoadMember
   LoadFinance

   Set oDebts = server.CreateObject("ptsDebtUser.CDebts")
   If oDebts Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsDebtUser.CDebts"
   Else
      With oDebts
         .SysCurrentLanguage = reqSysLanguage
         .ListMember CLng(reqMemberID), Payoff
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
'Count number of debts to process
x = 0
For Each oItem in oDebts
   x = x + 1
Next

'Create two dimensional array of debts to process
ReDim Debt(x-1,10)
x = 0
For Each oItem in oDebts
   With oItem
      Debt(x,0) = .DebtID
      Debt(x,1) = .DebtType
      Debt(x,2) = .DebtName
      Debt(x,3) = .Balance
      If IsMinPayment = 0 Then
         Debt(x,4) = .Payment
      Else
         Debt(x,4) = .MinPayment
         Payment = Payment + ( CCUR(.Payment) - CCUR(.MinPayment) )
      End If   
      Debt(x,5) = .IntRate
      Debt(x,6) = .IntPaid
      Debt(x,7) = .MonthsPaid
   End With
   x = x + 1
Next

reqExtraPayment = FormatCurrency(Payment)
ExtraPayment = Payment * 1.00
Savings = Savings / 100
TotalRegularInterest = 0
TotalRegularMonths = 0
TotalInterest = 0
TotalMonths = 0
TotalSavings = 0
TotalBalance = 0
TotalPayment = 0
OverPayment = 0
ProcessMonth = 0
LastYear = 0

xmlDA = "<PTSDAS>"

For x = 0 to UBound(Debt)
   'Accumulate total regular interest and months
   TotalRegularInterest = TotalRegularInterest + CleanNumber( Debt(x,6) )
   Months = Numeric(Debt(x,7))
   If Months > TotalRegularMonths Then TotalRegularMonths = Months

   'Get variables for calculating accelerated payoff
   MoRate = (CleanNumber( Debt(x,5) ) / 12) / 100
   StartingBalance = CleanNumber( Debt(x,3) )
   Balance = StartingBalance
   CurrentPayment = CleanNumber( Debt(x,4) )
   Payment = CurrentPayment
   TotalBalance = TotalBalance + Balance
   TotalPayment = TotalPayment + Payment

   DebtInterest = 0
   Months = 0
   LastYear = 0
   
   'StartingBalance test will make sure we don't have an increasing balance
   'from a monthly payment that is smaller than the monthly interest
   While Balance > 0 And Balance <= StartingBalance
      Months = Months + 1
      adjPayment = Payment
      SavingsAmt = 0

      'add overpayment from previous debt
      If Months = ProcessMonth Then
         If OverPayment > 0 Then
            adjPayment = adjPayment + OverPayment
            OverPayment = 0
         End If
      End If

      'add extra payment if it is not being used by another debt
      If Months > ProcessMonth Then
         Payment = CurrentPayment + ExtraPayment
         ProcessMonth = Months

         'Savings is a percentage of the extra payment amount   
         SavingsAmt = Round( ExtraPayment * Savings, 2 )
         TotalSavings = TotalSavings + SavingsAmt
         'Take savings amount from the monthly payment
         adjPayment = Payment - SavingsAmt
      End If
      
      'calculate interest
      Interest = Round(Balance * MoRate, 2)
      DebtInterest = DebtInterest + Interest
      TotalInterest = TotalInterest + Interest
      'add calculated monthly interest to balance
      Balance = Balance + Interest

      'handle over payment of last payment for this debt
      If ( Balance - adjPayment ) < 0 Then
         OverPayment = OverPayment + ( adjPayment - Balance )
         adjPayment = Balance
      End If

      'reduce balance by monthly payment
      Balance = Round( Balance - adjPayment, 2 )

      tmpDate = DateAdd( "m", Months-1, StartDate )
      tmpYear = Year( tmpDate )
      tmpMonth = Month( tmpDate )
      Select Case tmpMonth
         Case 1: tmpMonthName = "jan"
         Case 2: tmpMonthName = "feb"
         Case 3: tmpMonthName = "mar"
         Case 4: tmpMonthName = "apr"
         Case 5: tmpMonthName = "may"
         Case 6: tmpMonthName = "jun"
         Case 7: tmpMonthName = "jul"
         Case 8: tmpMonthName = "aug"
         Case 9: tmpMonthName = "sep"
         Case 10: tmpMonthName = "oct"
         Case 11: tmpMonthName = "nov"
         Case 12: tmpMonthName = "dec"
      End Select   

      If tmpYear <> LastYear Then
         xmlDA = xmlDA + "<PTSDA "
         xmlDA = xmlDA + "year=""" + CStr(tmpYear) + """ "
         xmlDA = xmlDA + "debttype=""" + Debt(x,1) + """ "
         xmlDA = xmlDA + "debtname=""" + Debt(x,2) + """ "
      End If
      LastYear = tmpYear

      xmlDA = xmlDA + tmpMonthName + "1=""" + FormatCurrency(adjPayment) + """ "
      xmlDA = xmlDA + tmpMonthName + "2=""" + FormatCurrency(Balance) + """ "

      If tmpMonth = 12 OR Balance = 0 Then
         xmlDA = xmlDA + "/>"
      End If

   Wend
   If Months > TotalMonths Then TotalMonths = Months
   ExtraPayment = ExtraPayment + CurrentPayment
   
   'Save accelerated interest and months for this debt.
   Debt(x,8) = DebtInterest
   Debt(x,9) = Months
Next

xmlDA = xmlDA + "</PTSDAS>"

'Create XML for each year
FirstYear = Year( StartDate )
tmpDate = DateAdd( "m", TotalMonths, StartDate )
LastYear = Year( tmpDate )
xmlYEAR = "<PTSYEARS>"
For x = FirstYear to LastYear
   xmlYEAR = xmlYEAR + "<PTSYEAR "
   xmlYEAR = xmlYEAR + "year=""" + CStr(x) + """ "
   xmlYEAR = xmlYEAR + "/>"
Next
xmlYEAR = xmlYEAR + "</PTSYEARS>"

'Save calculated values in the objects
x = 0
For Each oItem in oDebts
   With oItem
      .RegInterest = FormatCurrency( Debt(x,6) )
      .RegMonths = YrMo( Debt(x,7) )
      .AccInterest = FormatCurrency( Debt(x,8) )
      .AccMonths = YrMo( Debt(x,9) )
   End With
   x = x + 1
Next

         xmlDebts = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oDebts = Nothing
End Sub

If (reqSysUserGroup > 23) And (reqMemberID <> reqSysMemberID) Then

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If

Dim Debt
Payoff = 0
Payment = 0
Savings = 0
StartDate = 0
IsMinPayment = 0

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      AnalyzeDebt
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
xmlParam = xmlParam + " financeid=" + Chr(34) + CStr(reqFinanceID) + Chr(34)
xmlParam = xmlParam + " extrapayment=" + Chr(34) + CStr(reqExtraPayment) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlFinance
xmlTransaction = xmlTransaction +  xmlDebts
xmlTransaction = xmlTransaction +  xmlYEAR
xmlTransaction = xmlTransaction +  xmlDA
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Debt[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Debt[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "10212 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "10212 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "10212 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "10212.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "10212 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "10212 Load file (oData) failed with error code " + CStr(oData.parseError)
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
<!--#include file="Include\System.asp"-->
<!--#include file="Include\Audit.asp"-->
<!--#include file="Include\Wallet.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 2
Const cActionCancel = 3
Const cActioniPayoutWallet = 5
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
Dim oCompany, xmlCompany
Dim oCoption, xmlCoption
Dim oCountrys, xmlCountrys
Dim oBilling, xmlBilling
Dim oPayment, xmlPayment
'-----declare page parameters
Dim reqcontentpage
Dim reqBillingID
Dim reqMemberID
Dim reqCompanyID
Dim reqCardNum
Dim reqCardCode
Dim reqCheckAcct
Dim reqPaymentOptions
Dim reqWalletType
Dim reqWalletName
Dim reqIsUpdate
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
   SetCache "2913URL", reqReturnURL
   SetCache "2913DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "2913")
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
reqcontentpage =  Numeric(GetInput("contentpage", reqPageData))
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqCardNum =  GetInput("CardNum", reqPageData)
reqCardCode =  GetInput("CardCode", reqPageData)
reqCheckAcct =  GetInput("CheckAcct", reqPageData)
reqPaymentOptions =  GetInput("PaymentOptions", reqPageData)
reqWalletType =  Numeric(GetInput("WalletType", reqPageData))
reqWalletName =  GetInput("WalletName", reqPageData)
reqIsUpdate =  Numeric(GetInput("IsUpdate", reqPageData))
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

'-----Log Audit Information
DoAudit "2913", "?/2,21/0,22/0,23/0"

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

Sub NotifyChange()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpName = .NameFirst + " " + .NameLast
         tmpCompanyID = .CompanyID
         tmpTo = .Email + "," + .Email2
      End With
   End If
   Set oMember = Nothing

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         .Load tmpCompanyID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpSender = .Email
         tmpFrom = .Email
      End With
   End If
   Set oCompany = Nothing
   
               tmpSubject = "Payout Method Change Notification"
               tmpBody = tmpName + "; This is a security notice that your Payout Method for acct #" + CStr(reqMemberID) + " has been changed by " + reqSysUserName + ".  If you are aware of this change no further action is required, otherwise contact customer support immediately."
               SendEmail tmpCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
            
End Sub

Sub CreateWallet()
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
         tmpWalletType = .WalletType
         tmpWalletAcct = .WalletAcct
      End With
   End If
   Set oCoption = Nothing

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpUserName = .Logon
         tmpFirstName = .NameFirst
         tmpLastName = .NameLast
         tmpEmail = .Email
         If (tmpWalletType = 11) Then
            
                     result = iPayout_RegisterUser( tmpWalletAcct, tmpUserName, tmpFirstName, tmpLastName, tmpEmail )
                     If result = "" Then reqWalletName = tmpUserName Else DoError 0, "iPayout_RegisterUser", result
                  
         End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub LoadList()
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
End Sub

Sub LoadBilling()
   On Error Resume Next
   LoadList

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBillingID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCardNum = .CardName
         reqCardCode = .CardCode
         reqCheckAcct = .CheckAccount
         If (.CardNumber <> "") Then
            .CardNumber = "xxxxxxxxxxxx" + Right(.CardNumber,4)
         End If
         If (.CardCode <> "") Then
            .CardCode = "xxx"
         End If
         If (.CheckAccount <> "") Then
            .CheckAccount = "xxxx" + Right(.CheckAccount,4)
         End If
         If (.CommType = 4) Then
            reqWalletType = .CardType
            reqWalletName = .CardName
         End If
         If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (.Verified <> 3) Then
            reqIsUpdate = 1
         End If
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

Sub UpdateBilling()
   On Error Resume Next
   tmpCommType = Request.Form.Item("CommType")
   tmpCardType = Request.Form.Item("CardType")
   tmpCardNumber = Request.Form.Item("CardNumber")
   tmpCheckRoute = Request.Form.Item("CheckRoute")

   If (tmpCommType = 2) Then
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

   If (tmpCommType = 1) And (LEFT(tmpCardNumber,12) <> "xxxxxxxxxxxx") Then
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
            If (result >= 1) And (result <= 4) And (CLng(result) <> CLng(tmpCardType)) Then
               DoError 10010, "", "Oops, Selected Card Type does not match Card Number."
            End If
         End With
      End If
      Set oPayment = Nothing
   End If

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBillingID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpCardNumber = .CardNumber
         tmpCardCode = .CardCode
         tmpCheckAccount = .CheckAccount

         .Verified = Request.Form.Item("Verified")
         .BillingName = Request.Form.Item("BillingName")
         .Street1 = Request.Form.Item("Street1")
         .Street2 = Request.Form.Item("Street2")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .CountryID = Request.Form.Item("CountryID")
         .CommType = Request.Form.Item("CommType")
         .CardType = Request.Form.Item("CardType")
         .CardNumber = Request.Form.Item("CardNumber")
         .CardMo = Request.Form.Item("CardMo")
         .CardYr = Request.Form.Item("CardYr")
         .CardName = Request.Form.Item("CardName")
         .CardCode = Request.Form.Item("CardCode")
         .CheckBank = Request.Form.Item("CheckBank")
         .CheckName = Request.Form.Item("CheckName")
         .CheckRoute = Request.Form.Item("CheckRoute")
         .CheckAccount = Request.Form.Item("CheckAccount")
         .CheckAcctType = Request.Form.Item("CheckAcctType")
         If (.CheckAcctType = 0) Then
            .CheckAcctType = 1
         End If
         If (.CommType = 1) Then
            If (.CardNumber <> "") Then
               If (.CardNumber = "xxxxxxxxxxxx" + Right(.CardNumber,4)) Then
                  .CardNumber = tmpCardNumber
               End If
            End If
            If (.CardCode <> "") Then
               If (.CardCode = "xxx") Then
                  .CardCode = tmpCardCode
               End If
            End If
         End If
         If (.CommType = 2) Then
            If (.CheckAccount <> "") Then
               If (.CheckAccount <> "xxxx" + Right(.CheckAccount,4)) Then
                  .Verified = 0
               End If
               If (.CheckAccount = "xxxx" + Right(.CheckAccount,4)) Then
                  .CheckAccount = tmpCheckAccount
               End If
            End If
         End If
         If (.CommType = 4) Then
            .CardType = reqWalletType
            .CardName = reqWalletName
         End If
         If (xmlError = "") Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") And (reqSysUserGroup <> 1) Then
            NotifyChange
         End If
         If (xmlError <> "") Then
            reqCardNum = .CardName
            reqCardCode = .CardCode
            reqCheckAcct = .CheckAccount
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
         End If
      End With
   End If
   Set oBilling = Nothing
   If (xmlError <> "") Then
      LoadList
   End If
End Sub

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then
   LogFile "2913", "ILLEGAL ACCESS by Member #" + CStr(reqSysMemberID) + " of #" + CStr(reqMemberID)

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

         Response.Redirect "0101.asp" & "?ActionCode=" & 9
      End If
      LoadBilling

   Case CLng(cActionUpdate):
      UpdateBilling

      If (xmlError = "") Then
         reqReturnURL = GetCache("2913URL")
         reqReturnData = GetCache("2913DATA")
         SetCache "2913URL", ""
         SetCache "2913DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("2913URL")
      reqReturnData = GetCache("2913DATA")
      SetCache "2913URL", ""
      SetCache "2913DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActioniPayoutWallet):
      CreateWallet
      UpdateBilling
      LoadBilling
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
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqcontentpage) + Chr(34)
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " cardnum=" + Chr(34) + CleanXML(reqCardNum) + Chr(34)
xmlParam = xmlParam + " cardcode=" + Chr(34) + CleanXML(reqCardCode) + Chr(34)
xmlParam = xmlParam + " checkacct=" + Chr(34) + CleanXML(reqCheckAcct) + Chr(34)
xmlParam = xmlParam + " paymentoptions=" + Chr(34) + CleanXML(reqPaymentOptions) + Chr(34)
xmlParam = xmlParam + " wallettype=" + Chr(34) + CStr(reqWalletType) + Chr(34)
xmlParam = xmlParam + " walletname=" + Chr(34) + CleanXML(reqWalletName) + Chr(34)
xmlParam = xmlParam + " isupdate=" + Chr(34) + CStr(reqIsUpdate) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Billing[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Billing[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "2913 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "2913 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "2913 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "2913.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "2913 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "2913 Load file (oData) failed with error code " + CStr(oData.parseError)
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
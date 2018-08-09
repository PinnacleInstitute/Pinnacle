<!--#include file="Include\System.asp"-->
<!--#include file="Include\Coins.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionPayment_Add = 5
Const cActionPayment_Crypto = 6
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
Dim oPayment, xmlPayment
'-----declare page parameters
Dim reqPaymentID
Dim reqOwnerType
Dim reqOwnerID
Dim reqAmount
Dim reqCoinType
Dim reqPayDate
Dim reqPayStatus
Dim reqDescription
Dim reqCompanyID
Dim reqCompanyName
Dim reqUserName
Dim reqCryptoStatus
Dim reqAmountFormat
Dim reqResult
Dim reqOrderProcess
Dim reqPopup
Dim reqAcceptedCoins
Dim reqCurrencyCode
Dim reqCoinPrice
Dim reqQR_Name
Dim reqQR_URL
Dim reqQR_Address
Dim reqQR_Amount
Dim reqQR_Label
Dim reqQR_Msg
Dim reqCoinToken
Dim reqReplaceURL
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
   SetCache "CryptoPayURL", reqReturnURL
   SetCache "CryptoPayDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "cryptopay")
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
reqPaymentID =  Numeric(GetInput("PaymentID", reqPageData))
reqOwnerType =  Numeric(GetInput("OwnerType", reqPageData))
reqOwnerID =  Numeric(GetInput("OwnerID", reqPageData))
reqAmount =  GetInput("Amount", reqPageData)
reqCoinType =  Numeric(GetInput("CoinType", reqPageData))
reqPayDate =  GetInput("PayDate", reqPageData)
reqPayStatus =  Numeric(GetInput("PayStatus", reqPageData))
reqDescription =  GetInput("Description", reqPageData)
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqCompanyName =  GetInput("CompanyName", reqPageData)
reqUserName =  GetInput("UserName", reqPageData)
reqCryptoStatus =  GetInput("CryptoStatus", reqPageData)
reqAmountFormat =  GetInput("AmountFormat", reqPageData)
reqResult =  GetInput("Result", reqPageData)
reqOrderProcess =  Numeric(GetInput("OrderProcess", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqAcceptedCoins =  GetInput("AcceptedCoins", reqPageData)
reqCurrencyCode =  GetInput("CurrencyCode", reqPageData)
reqCoinPrice =  GetInput("CoinPrice", reqPageData)
reqQR_Name =  GetInput("QR_Name", reqPageData)
reqQR_URL =  GetInput("QR_URL", reqPageData)
reqQR_Address =  GetInput("QR_Address", reqPageData)
reqQR_Amount =  GetInput("QR_Amount", reqPageData)
reqQR_Label =  GetInput("QR_Label", reqPageData)
reqQR_Msg =  GetInput("QR_Msg", reqPageData)
reqCoinToken =  GetInput("CoinToken", reqPageData)
reqReplaceURL =  GetInput("ReplaceURL", reqPageData)
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

Sub SetupOrder()
   On Error Resume Next
   If (reqCryptoStatus = "") Then
      reqCryptoStatus = CoinTest(1)
   End If
   If (reqCryptoStatus = "OK") Then
      reqOrderProcess = 1

      Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
      Else
         With oPayment
            .SysCurrentLanguage = reqSysLanguage
            .Load reqPaymentID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.Status <> 1) And (.Status <> 2) And (.Status <> 7) Then
               
                response.write "Invalid Payment"
                response.end
              
            End If
            reqPayStatus = .Status
            reqCompanyID = .CompanyID
            reqOwnerType = .OwnerType
            reqOwnerID = .OwnerID
            reqPayDate = .PayDate
            tmpPurpose = .Purpose
            reqAmount = .Amount
            If (reqCompanyID = 21) Then
               If (reqAmount = 11) Then
                  reqAmount = 10
               End If
               If (reqAmount = 27) Then
                  reqAmount = 25
               End If
               If (reqAmount = 53) Then
                  reqAmount = 50
               End If
            End If
            reqAmountFormat = FormatCurrency(reqAmount,2)
         End With
      End If
      Set oPayment = Nothing

      If (reqOwnerType = 04) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqOwnerID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqUserName = .NameFirst + " " + .NameLast
            End With
         End If
         Set oMember = Nothing
      End If

      If (reqOwnerType = 151) Then
         Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
         If oConsumer Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
         Else
            With oConsumer
               .SysCurrentLanguage = reqSysLanguage
               .Load reqOwnerID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqUserName = .NameFirst + " " + .NameLast
            End With
         End If
         Set oConsumer = Nothing
      End If

      If (tmpPurpose <> "") Then
         Set oProduct = server.CreateObject("ptsProductUser.CProduct")
         If oProduct Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductUser.CProduct"
         Else
            With oProduct
               .SysCurrentLanguage = reqSysLanguage
               .FetchCode reqCompanyID, tmpPurpose
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.ProductID <> 0) Then
                  .Load .ProductID, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqDescription = .ProductName
               End If
            End With
         End If
         Set oProduct = Nothing
      End If
      reqCompanyName = "Nexxus Rewards"
      reqAcceptedCoins = ",1,"
      reqCoinPrice = FormatCurrency(CoinPrice(1,reqCurrencyCode))
   End If
End Sub

Sub SetupCryptoPayment()
   On Error Resume Next
   reqOrderProcess = 2

   Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
   If oPayment Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
   Else
      With oPayment
         .SysCurrentLanguage = reqSysLanguage
         .Load reqPaymentID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqQR_Address = .Reference
         If (reqQR_Address = "") Then
            reqQR_Address = CoinAddress(reqCoinType, CSTR(reqPaymentID))
            .Reference = reqQR_Address
         End If
         If (.Notes <> "") Then
            
              aCoins = Split(.Notes, "|")
              If IsNumeric( aCoins(0) ) Then
                PayCoins = 0
                PaidCoins = 0
                If UBOUND(aCoins) >= 0 Then
                  If IsNumeric(aCoins(0)) Then PayCoins = CDBL(aCoins(0))
                End If  
                If UBOUND(aCoins) >= 1 Then
                  If IsNumeric(aCoins(1)) Then PaidCoins = CDBL(aCoins(1))
                End If  
                Coins = fromSatoshi(PayCoins - PaidCoins)
              Else
                .Notes = ""              
              End If
            
         End If
         If (.Notes = "") Then
            Price = CoinPrice( reqCoinType, reqCurrencyCode )
            Coins =  Round(reqAmount / Price,8) 
            .Notes = CStr(toSatoshi(Coins))
         End If
         .PayType = reqCoinType + 21
         .Total = reqAmount
         .Amount = reqAmount
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPayment = Nothing
   reqQR_Amount = Coins
   reqQR_Label = reqCompanyName
   reqQR_Msg = reqDescription
   reqReplaceURL = CoinQR(reqCoinType, reqQR_Address, "{amt}", reqQR_Label, reqQR_Msg, 0 )
   reqQR_URL = Replace( reqReplaceURL, "{amt}", reqQR_Amount )
   reqQR_Name = CoinName(reqCoinType)
   key =  reqPaymentID + reqOwnerID 
   reqCoinToken =  CoinToken( reqCoinType, reqQR_Address, key) 
End Sub

If (reqPaymentID = 0) Then
   
          response.write "Missing PaymentID"
          response.end
        
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      SetupOrder

   Case CLng(cActionPayment_Add):
      SetupCryptoPayment

   Case CLng(cActionPayment_Crypto):
      reqOrderProcess = 3
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
xmlParam = xmlParam + " paymentid=" + Chr(34) + CStr(reqPaymentID) + Chr(34)
xmlParam = xmlParam + " ownertype=" + Chr(34) + CStr(reqOwnerType) + Chr(34)
xmlParam = xmlParam + " ownerid=" + Chr(34) + CStr(reqOwnerID) + Chr(34)
xmlParam = xmlParam + " amount=" + Chr(34) + CleanXML(reqAmount) + Chr(34)
xmlParam = xmlParam + " cointype=" + Chr(34) + CStr(reqCoinType) + Chr(34)
xmlParam = xmlParam + " paydate=" + Chr(34) + CStr(reqPayDate) + Chr(34)
xmlParam = xmlParam + " paystatus=" + Chr(34) + CStr(reqPayStatus) + Chr(34)
xmlParam = xmlParam + " description=" + Chr(34) + CleanXML(reqDescription) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " companyname=" + Chr(34) + CleanXML(reqCompanyName) + Chr(34)
xmlParam = xmlParam + " username=" + Chr(34) + CleanXML(reqUserName) + Chr(34)
xmlParam = xmlParam + " cryptostatus=" + Chr(34) + CleanXML(reqCryptoStatus) + Chr(34)
xmlParam = xmlParam + " amountformat=" + Chr(34) + CleanXML(reqAmountFormat) + Chr(34)
xmlParam = xmlParam + " result=" + Chr(34) + CleanXML(reqResult) + Chr(34)
xmlParam = xmlParam + " orderprocess=" + Chr(34) + CStr(reqOrderProcess) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " acceptedcoins=" + Chr(34) + CleanXML(reqAcceptedCoins) + Chr(34)
xmlParam = xmlParam + " currencycode=" + Chr(34) + CleanXML(reqCurrencyCode) + Chr(34)
xmlParam = xmlParam + " coinprice=" + Chr(34) + CleanXML(reqCoinPrice) + Chr(34)
xmlParam = xmlParam + " qr_name=" + Chr(34) + CleanXML(reqQR_Name) + Chr(34)
xmlParam = xmlParam + " qr_url=" + Chr(34) + CleanXML(reqQR_URL) + Chr(34)
xmlParam = xmlParam + " qr_address=" + Chr(34) + CleanXML(reqQR_Address) + Chr(34)
xmlParam = xmlParam + " qr_amount=" + Chr(34) + CStr(reqQR_Amount) + Chr(34)
xmlParam = xmlParam + " qr_label=" + Chr(34) + CleanXML(reqQR_Label) + Chr(34)
xmlParam = xmlParam + " qr_msg=" + Chr(34) + CleanXML(reqQR_Msg) + Chr(34)
xmlParam = xmlParam + " cointoken=" + Chr(34) + CleanXML(reqCoinToken) + Chr(34)
xmlParam = xmlParam + " replaceurl=" + Chr(34) + CleanXML(reqReplaceURL) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Reward[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Reward[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "CryptoPay Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "CryptoPay Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "CryptoPay Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "CryptoPay.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "CryptoPay Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "CryptoPay Load file (oData) failed with error code " + CStr(oData.parseError)
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
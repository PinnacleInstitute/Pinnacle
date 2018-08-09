<!--#include file="Include\System.asp"-->
<!--#include file="Include\Coins.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\2FA.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionTransferAmount = 1
Const cActionDoTransfer = 2
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
Dim oConsumer, xmlConsumer
Dim oReward, xmlReward
'-----declare page parameters
Dim reqConsumerID
Dim reqRecipientID
Dim reqSender
Dim reqRecipient
Dim reqLogon
Dim reqShopperID
Dim reqAmount
Dim reqPoints
Dim reqTotal
Dim reqNote
Dim reqValue
Dim reqNXCPrice
Dim reqNXCFormat
Dim reqStep
Dim reqConsumer2FA
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
   SetCache "m_15225URL", reqReturnURL
   SetCache "m_15225DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_15225")
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
reqConsumerID =  Numeric(GetInput("ConsumerID", reqPageData))
reqRecipientID =  Numeric(GetInput("RecipientID", reqPageData))
reqSender =  GetInput("Sender", reqPageData)
reqRecipient =  GetInput("Recipient", reqPageData)
reqLogon =  GetInput("Logon", reqPageData)
reqShopperID =  GetInput("ShopperID", reqPageData)
reqAmount =  GetInput("Amount", reqPageData)
reqPoints =  GetInput("Points", reqPageData)
reqTotal =  GetInput("Total", reqPageData)
reqNote =  GetInput("Note", reqPageData)
reqValue =  GetInput("Value", reqPageData)
reqNXCPrice =  GetInput("NXCPrice", reqPageData)
reqNXCFormat =  GetInput("NXCFormat", reqPageData)
reqStep =  Numeric(GetInput("Step", reqPageData))
reqConsumer2FA =  Numeric(GetInput("Consumer2FA", reqPageData))
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

Sub SetupTransfer()
   On Error Resume Next

   Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
   If oConsumer Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
   Else
      With oConsumer
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqConsumerID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqSender = .NameFirst + " " + .NameLast
      End With
   End If
   Set oConsumer = Nothing
End Sub

Sub GetTransferTotal()
   On Error Resume Next

   Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
   If oConsumer Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
   Else
      With oConsumer
         .SysCurrentLanguage = reqSysLanguage
         reqTotal = .Custom(CLng(reqConsumerID), 3, 0, 0, "")
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqNXCPrice = CoinPrice( 2, "USD" )
         If (reqNXCPrice = 0) Then
            reqNXCPrice = .1
         End If
         reqNXCFormat = FormatCurrency(reqNXCPrice)
         reqValue = FormatCurrency(reqTotal * reqNXCPrice)
      End With
   End If
   Set oConsumer = Nothing
End Sub

Sub GetRecipient()
   On Error Resume Next

   Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
   If oConsumer Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
   Else
      With oConsumer
         .SysCurrentLanguage = reqSysLanguage
         If (reqShopperID <> "") Then
            Result = reqShopperID
         End If
         If (reqShopperID = "") Then
            Result = CLng(.Logon2(reqLogon))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (Result > 0) Then
            reqRecipientID = Result
            .Load reqRecipientID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.NameFirst <> "") Then
               reqRecipient = .NameFirst + " " + .NameLast
            End If
            If (.NameFirst = "") Then
               DoError 10154, "", "Oops, The Shopper could not be found."
            End If
         End If
         If (Result = -1000002) Then
            DoError 10129, "", "Oops, The Email could not be found."
         End If
         If (Result = -1000003) Then
            DoError 10134, "", "Oops, The Phone Number could not be found."
         End If
      End With
   End If
   Set oConsumer = Nothing
End Sub

Sub ValidTransfer()
   On Error Resume Next
   GetTransferTotal
   If (reqAmount = "0") Then
      reqAmount = ""
   End If
   If (reqAmount <> "") Then
      tmpAmount = CDBL(reqAmount) / CDBL(reqNXCPrice) 
   End If
   If (reqAmount = "") Then
      tmpAmount = reqPoints
   End If
   If (CDBL(tmpAmount) <= 0) Then
      DoError 10152, "", "Oops, Please enter an amount greater than zero to transfer."
   End If
   If (CDBL(tmpAmount) > CDBL(reqTotal)) Then
      DoError 10153, "", "Oops, Please enter an amount less or equal to the total points available."
   End If
   If (xmlError = "") Then
      reqAmount = tmpAmount
   End If
End Sub

Sub DoTransfer()
   On Error Resume Next

   Set oReward = server.CreateObject("ptsRewardUser.CReward")
   If oReward Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsRewardUser.CReward"
   Else
      With oReward
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .MerchantID = 0
         .Payment2ID = 0
         .AwardID = 18
         .RewardType = 1
         .Status = 3
         .RewardDate = Now
         .HoldDate = 0
         .Note = reqNote
         .ConsumerID = reqConsumerID
         .Amount =  toSatoshi(reqAmount * -1) 
         .Reference = ""
         SenderRewardID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .ConsumerID = reqRecipientID
         .Amount =  toSatoshi(reqAmount) 
         .Reference = CSTR(SenderRewardID)
         RewardID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load SenderRewardID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Reference = CSTR(RewardID)
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oReward = Nothing
End Sub

If (reqConsumer2FA = 0) Then
   reqConsumer2FA = Is2FAConsumer( reqConsumerID )
   If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
      reqConsumer2FA = 1
   End If
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqStep = 0
      If (reqConsumer2FA <> 0) Then
         SetupTransfer
         reqStep = 1
      End If

   Case CLng(cActionTransferAmount):
      GetTransferTotal
      GetRecipient
      If (xmlError = "") Then
         reqStep = 2
      End If

   Case CLng(cActionDoTransfer):
      ValidTransfer
      If (xmlError = "") Then
         DoTransfer
      End If
      If (xmlError = "") Then
         reqStep = 3
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
xmlParam = xmlParam + " consumerid=" + Chr(34) + CStr(reqConsumerID) + Chr(34)
xmlParam = xmlParam + " recipientid=" + Chr(34) + CStr(reqRecipientID) + Chr(34)
xmlParam = xmlParam + " sender=" + Chr(34) + CleanXML(reqSender) + Chr(34)
xmlParam = xmlParam + " recipient=" + Chr(34) + CleanXML(reqRecipient) + Chr(34)
xmlParam = xmlParam + " logon=" + Chr(34) + CleanXML(reqLogon) + Chr(34)
xmlParam = xmlParam + " shopperid=" + Chr(34) + CleanXML(reqShopperID) + Chr(34)
xmlParam = xmlParam + " amount=" + Chr(34) + CleanXML(reqAmount) + Chr(34)
xmlParam = xmlParam + " points=" + Chr(34) + CleanXML(reqPoints) + Chr(34)
xmlParam = xmlParam + " total=" + Chr(34) + CleanXML(reqTotal) + Chr(34)
xmlParam = xmlParam + " note=" + Chr(34) + CleanXML(reqNote) + Chr(34)
xmlParam = xmlParam + " value=" + Chr(34) + CleanXML(reqValue) + Chr(34)
xmlParam = xmlParam + " nxcprice=" + Chr(34) + CleanXML(reqNXCPrice) + Chr(34)
xmlParam = xmlParam + " nxcformat=" + Chr(34) + CleanXML(reqNXCFormat) + Chr(34)
xmlParam = xmlParam + " step=" + Chr(34) + CStr(reqStep) + Chr(34)
xmlParam = xmlParam + " consumer2fa=" + Chr(34) + CStr(reqConsumer2FA) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlReward
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
   Response.Write "m_15225 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_15225 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_15225 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "m_15225.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_15225 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_15225 Load file (oData) failed with error code " + CStr(oData.parseError)
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
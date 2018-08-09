<!--#include file="Include\System.asp"-->
<!--#include file="Include\CompanyHeader.asp"-->
<!--#include file="Include\Portal.asp"-->
<!--#include file="Include\MenuColors.asp"-->
<!--#include file="Include\2FA.asp"-->
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
Dim oConsumer, xmlConsumer
'-----declare page parameters
Dim reqConsumerID
Dim reqCompanyID
Dim reqHeader
Dim reqMenuBehindColor
Dim reqMenuBehindImage
Dim reqTitle
Dim reqPageImage
Dim reqC
Dim reqUser2FA
Dim reqHeaderPosition
Dim reqHeaderAlign
Dim reqMenuAlign
Dim reqMenuBackground
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
   SetCache "m_15100URL", reqReturnURL
   SetCache "m_15100DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_15100")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqHeader =  GetInput("Header", reqPageData)
reqMenuBehindColor =  GetInput("MenuBehindColor", reqPageData)
reqMenuBehindImage =  GetInput("MenuBehindImage", reqPageData)
reqTitle =  GetInput("Title", reqPageData)
reqPageImage =  GetInput("PageImage", reqPageData)
reqC =  Numeric(GetInput("C", reqPageData))
reqUser2FA =  Numeric(GetInput("User2FA", reqPageData))
reqHeaderPosition =  Numeric(GetInput("HeaderPosition", reqPageData))
reqHeaderAlign =  Numeric(GetInput("HeaderAlign", reqPageData))
reqMenuAlign =  Numeric(GetInput("MenuAlign", reqPageData))
reqMenuBackground =  Numeric(GetInput("MenuBackground", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
m_CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0, "m_15100.asp"
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

If (reqSysUserGroup > 23) And (reqSysUserGroup <> 51) Then
   reqUser2FA = Is2FAConsumer(reqConsumerID)
   tmpConsumerID = Numeric(GetCache("CONSUMER"))
   If (reqConsumerID <> tmpConsumerID) Then
      SetCache "CONSUMER", ""

      Response.Redirect "15005.asp"
   End If
End If
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
   reqUser2FA = 1
End If
If (reqC = 0) Then
   reqC = reqConsumerID
End If
If (reqCompanyID = 0) Then
   reqCompanyID = 21
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
          reqHeader = GetHeader( reqCompanyID, 0, "MobileHeader", "" )
          If reqCompanyID = 21 Then reqHeader = "NexxusRewardsMobile.png"
          reqHeader = "company/" + CStr(reqCompanyID) + "/" + reqHeader
        

      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqConsumerID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            ConsumerName = .NameFirst + " " + .NameLast
            SetCache "MERCHANTSEARCH", .City
            xmlConsumer = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oConsumer = Nothing
      GetMenuColors reqCompanyID, GroupID, reqMenuBehindColor, MenuTopColor, MenuTopBGColor, MenuColor, MenuBGColor, MenuShadowColor, MenuBDColor, MenuOverColor, MenuOverBGColor, MenuDividerColor, reqMenuBehindImage, MenuTopImage, MenuImage
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " header=" + Chr(34) + CleanXML(reqHeader) + Chr(34)
xmlParam = xmlParam + " menubehindcolor=" + Chr(34) + CleanXML(reqMenuBehindColor) + Chr(34)
xmlParam = xmlParam + " menubehindimage=" + Chr(34) + CleanXML(reqMenuBehindImage) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " pageimage=" + Chr(34) + CleanXML(reqPageImage) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " user2fa=" + Chr(34) + CStr(reqUser2FA) + Chr(34)
xmlParam = xmlParam + " headerposition=" + Chr(34) + CStr(reqHeaderPosition) + Chr(34)
xmlParam = xmlParam + " headeralign=" + Chr(34) + CStr(reqHeaderAlign) + Chr(34)
xmlParam = xmlParam + " menualign=" + Chr(34) + CStr(reqMenuAlign) + Chr(34)
xmlParam = xmlParam + " menubackground=" + Chr(34) + CStr(reqMenuBackground) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\m_15100[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\m_15100[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_15100 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_15100 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_15100 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the menu Definitions
s = "<MENU name=""UserMenu"" type=""bar"" menuwidth=""125"" top-color=""" & MenuTopColor & """ top-bgcolor=""" & MenuTopBGColor & """ color=""" & MenuColor & """ bgcolor=""" & MenuBGColor & """ shadow-color=""" & MenuShadowColor & """ bdcolor=""" & MenuBDColor & """ over-color=""" & MenuOverColor & """ over-bgcolor=""" & MenuOverBGColor & """ divider-color=""" & MenuDividerColor & """ top-bgimg=""" & MenuTopImage & """ bgimg=""" & MenuImage & """>"
s=s+   "<ITEM width=""40"" menuwidth=""150"">"
s=s+      "<IMAGE name=""Menu2.png"" width=""29"" height=""30""/>"
s=s+      "<ITEM label=""mDashboard"" width=""100"" height=""40"" menuwidth=""100"" menuheight=""40"">"
s=s+         "<IMAGE name=""Home.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabDashboard',1))""/>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""mShopping"" width=""100"" height=""40"" menuwidth=""100"" menuheight=""40"">"
s=s+         "<IMAGE name=""ShoppingCart.gif"" width=""18"" height=""18""/>"
s=s+         "<ITEM label=""mPurchases"">"
s=s+            "<IMAGE name=""sales.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabRewards',1))""/>"
s=s+         "</ITEM>"
s=s+         "<ITEM label=""mRewards"">"
s=s+            "<IMAGE name=""mNXC.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabRewards',2))""/>"
s=s+         "</ITEM>"
s=s+         "<ITEM label=""mTransfer"">"
s=s+            "<IMAGE name=""mTransfer.gif"" width=""18"" height=""18""/>"
s=s+            "<ITEM label=""mRewards"">"
s=s+               "<IMAGE name=""mNXC.gif"" width=""18"" height=""18""/>"
s=s+               "<LINK name=""JAVA(ShowTab('TabRewards',3))""/>"
s=s+            "</ITEM>"
s=s+         "</ITEM>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""mMerchants"" width=""125"" height=""40"" menuwidth=""125"" menuheight=""40"">"
s=s+         "<IMAGE name=""Prospect.gif"" width=""18"" height=""18""/>"
s=s+         "<ITEM label=""mSearch"">"
s=s+            "<IMAGE name=""Suspect.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabMerchants',1))""/>"
s=s+         "</ITEM>"
s=s+         "<ITEM label=""mBlocks"">"
s=s+            "<IMAGE name=""Block.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabMerchants',3))""/>"
s=s+         "</ITEM>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""mAccount"" width=""100"" height=""40"" menuwidth=""145"" menuheight=""40"">"
s=s+         "<IMAGE name=""MyInfo.gif"" width=""18"" height=""18""/>"
s=s+         "<ITEM label=""mProfile"">"
s=s+            "<IMAGE name=""MyInfo.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabAccount',1))""/>"
s=s+         "</ITEM>"
s=s+         "<ITEM label=""mReferrals"">"
s=s+            "<IMAGE name=""Referrals.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabAccount',2))""/>"
s=s+         "</ITEM>"
s=s+         "<DIVIDER/>"
s=s+         "<ITEM label=""m2FA"">"
s=s+            "<IMAGE name=""logon.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabAccount',3))""/>"
s=s+         "</ITEM>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""mHelp"" width=""100"" height=""40"" menuwidth=""175"" menuheight=""40"">"
s=s+         "<IMAGE name=""Help.gif"" width=""18"" height=""18""/>"
s=s+         "<ITEM label=""mFAQ"">"
s=s+            "<IMAGE name=""Question.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabHelp',1))""/>"
s=s+         "</ITEM>"
s=s+         "<ITEM label=""mTickets"">"
s=s+            "<IMAGE name=""SupportTicket.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabHelp',2))""/>"
s=s+         "</ITEM>"
s=s+         "<DIVIDER/>"
s=s+         "<ITEM label=""mSignout"">"
s=s+            "<IMAGE name=""close.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""m_15005"" nodata=""true""/>"
s=s+         "</ITEM>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM value=""" & ConsumerName & """ width=""220"" align=""center""/>"
s=s+   "<ITEM width=""40"">"
s=s+      "<IMAGE name=""Refresh2.png"" width=""29"" height=""30""/>"
s=s+      "<LINK name=""JAVA(doSubmit(0,''))""/>"
s=s+   "</ITEM>"
s=s+"</MENU>"
xmlUserMenu = s

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
xmlData = xmlData +  xmlUserMenu
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "m_15100.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_15100 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_15100 Load file (oData) failed with error code " + CStr(oData.parseError)
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
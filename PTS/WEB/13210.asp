<!--#include file="Include\System.asp"-->
<!--#include file="Include\Company.asp"-->
<!--#include file="Include\CompanyHeader.asp"-->
<!--#include file="Include\MenuColors.asp"-->
<!--#include file="Include\BuildHeader12.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionSignIn = 1
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
Dim oNewsTopics, xmlNewsTopics
Dim oNewss, xmlNewss
Dim oAds, xmlAds
Dim oHTMLFile, xmlHTMLFile
'-----other transaction data variables
Dim xmlBreaking
Dim xmlTopic
Dim xmlHDR
Dim xmlStrategic
Dim xmlFooter
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqTitle
Dim reqPageImage
Dim reqSearch
Dim reqMenuBehindColor
Dim reqMenuBehindImage
Dim reqMenuTopColor
Dim reqMenuBehindColor2
Dim reqMenuBehindImage2
Dim reqLgn
Dim reqPwd
Dim reqRemember
Dim reqA
Dim reqG
Dim reqC
Dim reqS
Dim reqLogo1
Dim reqLogo2
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
   SetCache "13210URL", reqReturnURL
   SetCache "13210DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "13210")
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
reqTitle =  GetInput("Title", reqPageData)
reqPageImage =  GetInput("PageImage", reqPageData)
reqSearch =  GetInput("Search", reqPageData)
reqMenuBehindColor =  GetInput("MenuBehindColor", reqPageData)
reqMenuBehindImage =  GetInput("MenuBehindImage", reqPageData)
reqMenuTopColor =  Numeric(GetInput("MenuTopColor", reqPageData))
reqMenuBehindColor2 =  GetInput("MenuBehindColor2", reqPageData)
reqMenuBehindImage2 =  GetInput("MenuBehindImage2", reqPageData)
reqLgn =  GetInput("Lgn", reqPageData)
reqPwd =  GetInput("Pwd", reqPageData)
reqRemember =  Numeric(GetInput("Remember", reqPageData))
reqA =  Numeric(GetInput("A", reqPageData))
reqG =  Numeric(GetInput("G", reqPageData))
reqC =  Numeric(GetInput("C", reqPageData))
reqS =  Numeric(GetInput("S", reqPageData))
reqLogo1 =  GetInput("Logo1", reqPageData)
reqLogo2 =  GetInput("Logo2", reqPageData)
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

If (reqS <> 0) Then

   Response.Redirect "13213.asp" & "?S=" & reqS & "&G=" & reqG
End If
reqCompanyID = 12
reqC = 12
reqTitle = CleanXML(reqSysUserName)
If (reqA <> 0) Then
   reqMemberID = reqA
End If
If (reqSysUserGroup = 41) Then
   If (reqMemberID = 0) Then
      reqMemberID = reqSysMemberID
   End If
   If (reqCompanyID = 0) Then
      reqCompanyID = reqSysCompanyID
   End If
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oNewsTopics = server.CreateObject("ptsNewsTopicUser.CNewsTopics")
      If oNewsTopics Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsNewsTopicUser.CNewsTopics"
      Else
         With oNewsTopics
            .SysCurrentLanguage = reqSysLanguage
            .ListMajor reqCompanyID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlNewsTopics = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oNewsTopics = Nothing

      Set oNewss = server.CreateObject("ptsNewsUser.CNewss")
      If oNewss Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsNewsUser.CNewss"
      Else
         With oNewss
            .SysCurrentLanguage = reqSysLanguage
            .ListNews reqCompanyID, 2, 0
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlNewss = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .ListNews reqCompanyID, 3, 0
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlBreaking = .XML(13, "Breaking")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .ListNews reqCompanyID, 6, 0
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlTopic = .XML(13, "Topic")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oNewss = Nothing

      Set oAds = server.CreateObject("ptsAdUser.CAds")
      If oAds Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAdUser.CAds"
      Else
         With oAds
            .SysCurrentLanguage = reqSysLanguage
            .ListAds reqCompanyID, 1, 0, CLng(reqSysUserGroup), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlAds = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAds = Nothing
      
               Dim xmlTopicMenu, MenuTopColor, MenuTopBGColor, MenuColor, MenuBGColor, MenuShadowColor, MenuBDColor, MenuOverColor, MenuOverBGColor, MenuDividerColor, MenuTopImage, MenuImage
            
      BuildHeader

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = "Footer.htm"
            .Path = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID)
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlFooter = .XML("Footer")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing

   Case CLng(cActionSignIn):
      tmpLgn = Request.Form.Item("Lgn")
      tmpPwd = Request.Form.Item("Pwd")
      tmpRemember = Request.Form.Item("Remember")
      If (tmpRemember = "1") Then
         SetCookie "LGN", tmpLgn
         SetCookie "PWD", tmpPwd
      End If
      If (tmpRemember = "") Then
         SetCookie "LGN", ""
         SetCookie "PWD", ""
      End If

      Response.Redirect "0101.asp" & "?Lgn=" & tmpLgn & "&Pwd=" & tmpPwd
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
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " pageimage=" + Chr(34) + CleanXML(reqPageImage) + Chr(34)
xmlParam = xmlParam + " search=" + Chr(34) + CleanXML(reqSearch) + Chr(34)
xmlParam = xmlParam + " menubehindcolor=" + Chr(34) + CleanXML(reqMenuBehindColor) + Chr(34)
xmlParam = xmlParam + " menubehindimage=" + Chr(34) + CleanXML(reqMenuBehindImage) + Chr(34)
xmlParam = xmlParam + " menutopcolor=" + Chr(34) + CStr(reqMenuTopColor) + Chr(34)
xmlParam = xmlParam + " menubehindcolor2=" + Chr(34) + CleanXML(reqMenuBehindColor2) + Chr(34)
xmlParam = xmlParam + " menubehindimage2=" + Chr(34) + CleanXML(reqMenuBehindImage2) + Chr(34)
xmlParam = xmlParam + " lgn=" + Chr(34) + CleanXML(reqLgn) + Chr(34)
xmlParam = xmlParam + " pwd=" + Chr(34) + CleanXML(reqPwd) + Chr(34)
xmlParam = xmlParam + " remember=" + Chr(34) + CStr(reqRemember) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqA) + Chr(34)
xmlParam = xmlParam + " g=" + Chr(34) + CStr(reqG) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " s=" + Chr(34) + CStr(reqS) + Chr(34)
xmlParam = xmlParam + " logo1=" + Chr(34) + CleanXML(reqLogo1) + Chr(34)
xmlParam = xmlParam + " logo2=" + Chr(34) + CleanXML(reqLogo2) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlNewsTopics
xmlTransaction = xmlTransaction +  xmlNewss
xmlTransaction = xmlTransaction +  xmlAds
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlBreaking
xmlTransaction = xmlTransaction +  xmlTopic
xmlTransaction = xmlTransaction +  xmlHDR
xmlTransaction = xmlTransaction +  xmlStrategic
xmlTransaction = xmlTransaction +  xmlFooter
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\R180[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\R180[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "13210 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "13210 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "13210 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the menu Definitions
s = "<MENU name=""NewsMenu"" type=""bar"" menuwidth=""125"" height=""30"" top-color=""" & reqMenuTopColor & """ top-bgcolor=""" & MenuTopBGColor & """ color=""" & MenuColor & """ bgcolor=""" & MenuBGColor & """ shadow-color=""" & MenuShadowColor & """ bdcolor=""" & MenuBDColor & """ over-color=""" & MenuOverColor & """ over-bgcolor=""" & MenuOverBGColor & """ divider-color=""" & MenuDividerColor & """ top-bgimg=""" & MenuTopImage & """ bgimg=""" & MenuImage & """>"
s=s+   "<ITEM label=""mHome"" width=""75"">"
s=s+      "<IMAGE name=""Home.gif"" width=""18"" height=""18""/>"
s=s+      "<LINK name=""JAVA(ShowTab('TabHome',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""mAbout"" width=""90"">"
s=s+      "<IMAGE name=""News.gif"" width=""18"" height=""18""/>"
s=s+      "<LINK name=""JAVA(ShowTab('TabCompany',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""mContact"" width=""100"">"
s=s+      "<IMAGE name=""Email.gif"" width=""18"" height=""18""/>"
s=s+      "<LINK name=""JAVA(ShowTab('TabCompany',2))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""mReferrals"" width=""150"">"
s=s+      "<IMAGE name=""Finance.gif"" width=""18"" height=""18""/>"
s=s+      "<LINK name=""JAVA(ShowTab('TabCompany',3))""/>"
s=s+   "</ITEM>"
      If (reqSysUserGroup = 41) Then
s=s+   "<ITEM value=""" & reqTitle & """ width=""175"">"
s=s+      "<IMAGE name=""Favorite.gif"" width=""16"" height=""16""/>"
s=s+      "<LINK name=""JAVA(ShowTab('TabMember',4))""/>"
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup = 41) Then
s=s+   "<ITEM label=""mMyFriends"" width=""125"">"
s=s+      "<IMAGE name=""Genealogy.gif"" width=""18"" height=""18""/>"
s=s+      "<LINK name=""JAVA(ShowTab('TabMember',1))""/>"
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup = 41) Then
s=s+   "<ITEM label=""mShareNews"" width=""110"" menuwidth=""150"">"
s=s+      "<IMAGE name=""Newsletter.gif"" width=""18"" height=""18""/>"
s=s+      "<ITEM label=""mShareNow"">"
s=s+         "<IMAGE name=""Newsletter.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',2))""/>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""mShareList"">"
s=s+         "<IMAGE name=""Newsletter.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',3))""/>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup = 41) Then
s=s+   "<ITEM label=""mAccount"" width=""90"" menuwidth=""150"">"
s=s+      "<IMAGE name=""MyInfo.gif"" width=""18"" height=""18""/>"
         If (InStr(reqSysUserOptions,"I") <> 0) Then
s=s+      "<ITEM label=""mProfile"">"
s=s+         "<IMAGE name=""MyInfo.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',4))""/>"
s=s+      "</ITEM>"
         End If
         If (InStr(reqSysUserOptions,"\") <> 0) Then
s=s+      "<ITEM label=""mGroup"">"
s=s+         "<IMAGE name=""Genealogy.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',10))""/>"
s=s+      "</ITEM>"
         End If
         If (InStr(reqSysUserOptions,"x") <> 0) Then
s=s+      "<ITEM label=""mPayoutMethod"">"
s=s+         "<IMAGE name=""Payout.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',5))""/>"
s=s+      "</ITEM>"
         End If
s=s+      "<DIVIDER/>"
         If (reqSysUserGroup <> 1) And (InStr(reqSysUserOptions,"~y") = 0) Then
s=s+      "<ITEM label=""mChangeLogon"">"
s=s+         "<IMAGE name=""logon.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',6))""/>"
s=s+      "</ITEM>"
         End If
s=s+      "<ITEM label=""mChangePassword"">"
s=s+         "<IMAGE name=""logon.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',7))""/>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup = 41) Then
s=s+   "<ITEM label=""mHelp"" width=""90"" menuwidth=""200"">"
s=s+      "<IMAGE name=""Help.gif"" width=""18"" height=""18""/>"
         If (InStr(reqSysUserOptions,"S") <> 0) Then
s=s+      "<ITEM label=""mFAQ"">"
s=s+         "<IMAGE name=""Question.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',8))""/>"
s=s+      "</ITEM>"
         End If
         If (InStr(reqSysUserOptions,"m") <> 0) Then
s=s+      "<ITEM label=""mTickets"">"
s=s+         "<IMAGE name=""SupportTicket.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabMember',9))""/>"
s=s+      "</ITEM>"
         End If
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""mSignout"">"
s=s+         "<IMAGE name=""close.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""0101"" nodata=""true"">"
s=s+            "<PARAM name=""ActionCode"" value=""9""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
      End If
s=s+"</MENU>"
xmlNewsMenu = s

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
xmlData = xmlData +  xmlTopicMenu
xmlData = xmlData +  xmlNewsMenu
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "13210.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "13210 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "13210 Load file (oData) failed with error code " + CStr(oData.parseError)
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
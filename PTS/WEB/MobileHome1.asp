<!--#include file="Include\System.asp"-->
<!--#include file="Include\MenuColors.asp"-->
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
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGAA, reqSysCGAA
Dim reqLangDialect, reqLangCountry, reqLangDefault
Dim xmlSystem, xmlConfig, xmlParam, xmlError, xmlErrorLabels, reqConfirm
Dim xmlTransaction, xmlData
'-----language variables
Dim oLanguage, xmlLanguage
Dim xslPage
Dim fileLanguage
'-----object variables
Dim oMember, xmlMember
'-----other transaction data variables
Dim xmlIcons1
Dim xmlIcons2
Dim xmlIcons3
Dim xmlIcons4
Dim xmlIcons5
'-----declare page parameters
Dim reqM
Dim reqC
Dim reqG
Dim reqHeader
Dim reqMenuTopColor
Dim reqMenuTopBGColor
Dim reqMenuColor
Dim reqMenuBGColor
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
   SetCache "MobileHome1URL", reqReturnURL
   SetCache "MobileHome1DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "mobilehome1")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

reqSysCompanyID = Numeric(GetCache("COMPANYID"))
reqSysTrainerID = Numeric(GetCache("TRAINERID"))
reqSysMemberID = Numeric(GetCache("MEMBERID"))
reqSysOrgID = Numeric(GetCache("ORGID"))
reqSysUserMode = Numeric(GetCache("USERMODE"))
reqSysUserOptions = GetCache("USEROPTIONS")
reqSysGAA = GetCache("GAA")
reqSysCGAA = GetCache("CGAA")

'-----fetch page parameters
reqM =  Numeric(GetInput("M", reqPageData))
reqC =  Numeric(GetInput("C", reqPageData))
reqG =  Numeric(GetInput("G", reqPageData))
reqHeader =  GetInput("Header", reqPageData)
reqMenuTopColor =  GetInput("MenuTopColor", reqPageData)
reqMenuTopBGColor =  GetInput("MenuTopBGColor", reqPageData)
reqMenuColor =  GetInput("MenuColor", reqPageData)
reqMenuBGColor =  GetInput("MenuBGColor", reqPageData)
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

If (reqM = 0) Then
   reqM = reqSysMemberID
End If
If (reqC = 0) Then
   reqC = reqSysCompanyID
End If
If (reqG = 0) Then
   reqG = Numeric(GetCache("GROUPID"))
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
               reqHeader = GetHeader( reqC, reqG, "MobileHeader", "" )
               If reqG > 0 And reqHeader = "" Then reqHeader = GetHeader( reqC, 0, "MobileHeader", "" )
               reqHeader = "company/" + CStr(reqC) + "/" + reqHeader
            

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqM, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqC = .CompanyID
            tmpLevel = .Level
            xmlMember = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMember = Nothing
      GetMenuColors reqC, reqM, MenuBehindColor, reqMenuTopColor, reqMenuTopBGColor, reqMenuColor, reqMenuBGColor, MenuShadowColor, MenuBDColor, MenuOverColor, MenuOverBGColor, MenuDividerColor, MenuBehindImage, MenuTopImage, MenuImage
      If (InStr(reqSysUserOptions,"l") <> 0) Then
         xmlIcons1 = "<ICONS1>"
         xmlIcons1 = xmlIcons1 + "<ICON name=""LogActivity"" action=""ShowTab('TabProductivity', 1)"" image=""m_ActivitiesAdd.gif""/>"
         xmlIcons1 = xmlIcons1 + "<ICON name=""Statistics"" action=""ShowTab('TabProductivity', 2)"" image=""m_Activities.gif""/>"
         If (InStr(reqSysUserOptions,"*") <> 0) Then
            xmlIcons1 = xmlIcons1 + "<ICON name=""ViewContests"" action=""ShowTab('TabProductivity', 4)"" image=""m_Contest.gif""/>"
         End If
         If (reqC = 7) And (tmpLevel = 0) Then
            xmlIcons1 = xmlIcons1 + "<ICON name=""ViewContests"" action=""ShowTab('TabProductivity', 7)"" image=""m_Contest.gif""/>"
         End If
         xmlIcons1 = xmlIcons1 + "<ICON name=""LeaderBoard"" action=""ShowTab('TabProductivity', 3)"" image=""m_LeaderBoard.gif""/>"
         xmlIcons1 = xmlIcons1 + "<ICON name=""ActivityGoals"" action=""ShowTab('TabProductivity', 6)"" image=""m_Goal.gif""/>"
         If (InStr(reqSysUserOptions,"#") <> 0) Then
            xmlIcons1 = xmlIcons1 + "<ICON name=""ActivityReports"" action=""ShowTab('TabProductivity', 5)"" image=""m_Chart.gif""/>"
         End If
         If (reqC = 7) And (tmpLevel = 0) Then
            xmlIcons1 = xmlIcons1 + "<ICON name=""ActivityReports"" action=""ShowTab('TabProductivity', 7)"" image=""m_Chart.gif""/>"
         End If
         xmlIcons1 = xmlIcons1 + "</ICONS1>"
      End If
      If (InStr(reqSysUserOptions,"h") <> 0) Then
         xmlIcons2 = "<ICONS2>"
         xmlIcons2 = xmlIcons2 + "<ICON name=""Contacts"" action=""ShowTab('TabMarketing', 1)"" image=""m_ContactAdd.gif""/>"
         xmlIcons2 = xmlIcons2 + "<ICON name=""ViewContacts"" action=""ShowTab('TabMarketing', 2)"" image=""m_Search.gif""/>"
         If (InStr(reqSysUserOptions,"Z") <> 0) Then
            xmlIcons2 = xmlIcons2 + "<ICON name=""LeadPages"" action=""ShowTab('TabMarketing', 3)"" image=""m_LeadPage.gif""/>"
         End If
         If (InStr(reqSysUserOptions,"z") <> 0) Then
            xmlIcons2 = xmlIcons2 + "<ICON name=""Presentations"" action=""ShowTab('TabMarketing', 4)"" image=""m_Presentation.gif""/>"
         End If
         xmlIcons2 = xmlIcons2 + "</ICONS2>"
      End If
      If (InStr(reqSysUserOptions,"w") <> 0) Then
         xmlIcons3 = "<ICONS3>"
         If (tmpLevel = 0) Or (tmpLevel = 3) Then
            xmlIcons3 = xmlIcons3 + "<ICON name=""Upgrade"" action=""ShowTab('TabFinancial', 3)"" image=""m_Member.gif""/>"
         End If
         If (InStr(reqSysUserOptions,"V") <> 0) Then
            xmlIcons3 = xmlIcons3 + "<ICON name=""Payments"" action=""ShowTab('TabFinancial', 1)"" image=""m_CreditCard.gif""/>"
         End If
         If (InStr(reqSysUserOptions,";") <> 0) Then
            xmlIcons3 = xmlIcons3 + "<ICON name=""Referrals"" action=""ShowTab('TabFinancial', 2)"" image=""m_Referral.gif""/>"
         End If
         xmlIcons3 = xmlIcons3 + "</ICONS3>"
      End If
      xmlIcons4 = "<ICONS4>"
      xmlIcons4 = xmlIcons4 + "<ICON name=""Profile"" action=""ShowTab('TabAccount', 1)"" image=""m_Member.gif""/>"
      If (InStr(reqSysUserOptions,"G") <> 0) Then
         xmlIcons4 = xmlIcons4 + "<ICON name=""Mentoring"" action=""ShowTab('TabAccount', 5)"" image=""m_Mentor.gif""/>"
      End If
      If (InStr(reqSysUserOptions,"V") <> 0) Then
         xmlIcons4 = xmlIcons4 + "<ICON name=""BillingMethod"" action=""ShowTab('TabAccount', 2)"" image=""m_CreditCard.gif""/>"
      End If
      If (reqSysUserGroup <> 1) And (InStr(reqSysUserOptions,"~y") = 0) Then
         xmlIcons4 = xmlIcons4 + "<ICON name=""ChangeLogon"" action=""ShowTab('TabAccount', 3)"" image=""m_Logon.gif""/>"
      End If
      xmlIcons4 = xmlIcons4 + "<ICON name=""ChangePassword"" action=""ShowTab('TabAccount', 4)"" image=""m_Logon.gif""/>"
      xmlIcons4 = xmlIcons4 + "</ICONS4>"
      If (InStr(reqSysUserOptions,"S") <> 0) Or (InStr(reqSysUserOptions,"R") <> 0) Or (InStr(reqSysUserOptions,"m") <> 0) Then
         xmlIcons5 = "<ICONS5>"
         If (InStr(reqSysUserOptions,"S") <> 0) Then
            xmlIcons5 = xmlIcons5 + "<ICON name=""FAQ"" action=""ShowTab('TabHelp', 1)"" image=""m_Question.gif""/>"
         End If
         If (InStr(reqSysUserOptions,"R") <> 0) Then
            xmlIcons5 = xmlIcons5 + "<ICON name=""Docs"" action=""ShowTab('TabHelp', 2)"" image=""m_Docs.gif""/>"
         End If
         If (InStr(reqSysUserOptions,"m") <> 0) Then
            xmlIcons5 = xmlIcons5 + "<ICON name=""Tickets"" action=""ShowTab('TabHelp', 3)"" image=""m_SupportTicket.gif""/>"
         End If
         xmlIcons5 = xmlIcons5 + "</ICONS5>"
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
xmlSystem = xmlSystem + " gaa=" + Chr(34) + reqSysGAA + Chr(34)
xmlSystem = xmlSystem + " cgaa=" + Chr(34) + reqSysCGAA + Chr(34)
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
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " g=" + Chr(34) + CStr(reqG) + Chr(34)
xmlParam = xmlParam + " header=" + Chr(34) + CleanXML(reqHeader) + Chr(34)
xmlParam = xmlParam + " menutopcolor=" + Chr(34) + CleanXML(reqMenuTopColor) + Chr(34)
xmlParam = xmlParam + " menutopbgcolor=" + Chr(34) + CleanXML(reqMenuTopBGColor) + Chr(34)
xmlParam = xmlParam + " menucolor=" + Chr(34) + CleanXML(reqMenuColor) + Chr(34)
xmlParam = xmlParam + " menubgcolor=" + Chr(34) + CleanXML(reqMenuBGColor) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlIcons1
xmlTransaction = xmlTransaction +  xmlIcons2
xmlTransaction = xmlTransaction +  xmlIcons3
xmlTransaction = xmlTransaction +  xmlIcons4
xmlTransaction = xmlTransaction +  xmlIcons5
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language\MobileHome1[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\MobileHome1[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "MobileHome1 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "MobileHome1 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "MobileHome1 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "MobileHome1.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "MobileHome1 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "MobileHome1 Load file (oData) failed with error code " + CStr(oData.parseError)
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
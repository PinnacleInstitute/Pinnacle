<!--#include file="Include\System.asp"-->
<!--#include file="Include\CompanyHeader.asp"-->
<!--#include file="Include\Portal.asp"-->
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
Dim oCoption, xmlCoption
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqHeader
Dim reqMenuBehindColor
Dim reqMenuBehindImage
Dim reqTitle
Dim reqPageImage
Dim reqWallet
Dim reqMenuLogo
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
   SetCache "m_MemberHomeURL", reqReturnURL
   SetCache "m_MemberHomeDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_memberhome")
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
reqHeader =  GetInput("Header", reqPageData)
reqMenuBehindColor =  GetInput("MenuBehindColor", reqPageData)
reqMenuBehindImage =  GetInput("MenuBehindImage", reqPageData)
reqTitle =  GetInput("Title", reqPageData)
reqPageImage =  GetInput("PageImage", reqPageData)
reqWallet =  Numeric(GetInput("Wallet", reqPageData))
reqMenuLogo =  GetInput("MenuLogo", reqPageData)
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
m_CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0, "m_MemberHome.asp"
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

reqTitle = CleanXML(reqSysUserName)
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
      GroupID = Numeric(GetCache("GROUPID"))

      If (reqSysUserGroup <> 41) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqMemberID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqCompanyID = .CompanyID
               GroupID = .GroupID
               xmlMember = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oMember = Nothing
      End If
      
          reqHeader = GetHeader( reqCompanyID, 0, "MobileHeader", "" )
          If reqCompanyID = 21 Then reqHeader = "NexxusRewardsMobile.png"
          reqHeader = "company/" + CStr(reqCompanyID) + "/" + reqHeader
        
      If (reqCompanyID = 21) Then
         reqMenuLogo = "MenuLogo.png"
      End If

      Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
      If oCoption Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
      Else
         With oCoption
            .SysCurrentLanguage = reqSysLanguage
            .FetchCompany reqCompanyID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpPayoutProcessors = .PayoutProcessors
            If (InStr(tmpPayoutProcessors,"10") > 0) Then
               reqWallet = 1
            End If
         End With
      End If
      Set oCoption = Nothing
      If (reqCompanyID = 7) Then
         reqPageImage = "bg7.jpg"
      End If
      GetPortal reqCompanyID, GroupID, reqHeaderPosition, reqHeaderAlign, reqMenuAlign, reqMenuBackground
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
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " header=" + Chr(34) + CleanXML(reqHeader) + Chr(34)
xmlParam = xmlParam + " menubehindcolor=" + Chr(34) + CleanXML(reqMenuBehindColor) + Chr(34)
xmlParam = xmlParam + " menubehindimage=" + Chr(34) + CleanXML(reqMenuBehindImage) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " pageimage=" + Chr(34) + CleanXML(reqPageImage) + Chr(34)
xmlParam = xmlParam + " wallet=" + Chr(34) + CStr(reqWallet) + Chr(34)
xmlParam = xmlParam + " menulogo=" + Chr(34) + CleanXML(reqMenuLogo) + Chr(34)
xmlParam = xmlParam + " headerposition=" + Chr(34) + CStr(reqHeaderPosition) + Chr(34)
xmlParam = xmlParam + " headeralign=" + Chr(34) + CStr(reqHeaderAlign) + Chr(34)
xmlParam = xmlParam + " menualign=" + Chr(34) + CStr(reqMenuAlign) + Chr(34)
xmlParam = xmlParam + " menubackground=" + Chr(34) + CStr(reqMenuBackground) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\m_MemberHome[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\m_MemberHome[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_MemberHome Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_MemberHome Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_MemberHome Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the menu Definitions
s = "<MENU name=""MemberMenu"" type=""bar"" menuwidth=""125"" top-color=""" & MenuTopColor & """ top-bgcolor=""" & MenuTopBGColor & """ color=""" & MenuColor & """ bgcolor=""" & MenuBGColor & """ shadow-color=""" & MenuShadowColor & """ bdcolor=""" & MenuBDColor & """ over-color=""" & MenuOverColor & """ over-bgcolor=""" & MenuOverBGColor & """ divider-color=""" & MenuDividerColor & """ top-bgimg=""" & MenuTopImage & """ bgimg=""" & MenuImage & """>"
s=s+   "<ITEM width=""40"" menuwidth=""150"">"
s=s+      "<IMAGE name=""Menu2.png"" width=""29"" height=""30""/>"
s=s+      "<ITEM label=""mDashboard"" width=""125"" height=""40"" menuwidth=""100"" menuheight=""40"">"
s=s+         "<IMAGE name=""Home.gif"" width=""18"" height=""18""/>"
s=s+         "<LINK name=""JAVA(ShowTab('TabDashboard',1))""/>"
s=s+      "</ITEM>"
         If (InStr(reqSysUserOptions,"n") <> 0) Then
s=s+      "<ITEM label=""mProductivity"" width=""125"" height=""40"" menuwidth=""150"" menuheight=""40"">"
s=s+         "<IMAGE name=""Activity.gif"" width=""18"" height=""18""/>"
            If (InStr(reqSysUserOptions,"l") <> 0) Then
s=s+         "<ITEM label=""mLogActivity"">"
s=s+            "<IMAGE name=""Activity.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabProductivity',1))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"l") <> 0) Then
s=s+         "<ITEM label=""mActivities"">"
s=s+            "<IMAGE name=""Activity.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabProductivity',2))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"l") <> 0) Then
s=s+         "<ITEM label=""mLeaderBoard"">"
s=s+            "<IMAGE name=""leaderboard.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabProductivity',3))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"l") <> 0) Then
s=s+         "<ITEM label=""mActivityStatistics"">"
s=s+            "<IMAGE name=""Goal.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabProductivity',4))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"*") <> 0) Then
s=s+         "<ITEM label=""mContests"">"
s=s+            "<IMAGE name=""Contest.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabProductivity',5))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"l") <> 0) Then
s=s+         "<ITEM label=""mActivityGoals"">"
s=s+            "<IMAGE name=""Goal.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabProductivity',6))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"#") <> 0) Then
s=s+         "<ITEM label=""mActivityReports"">"
s=s+            "<IMAGE name=""Chart.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabProductivity',7))""/>"
s=s+         "</ITEM>"
            End If
s=s+      "</ITEM>"
         End If
         If (InStr(reqSysUserOptions,"A") <> 0) Then
s=s+      "<ITEM label=""mMarketing"" width=""125"" height=""40"" menuwidth=""125"" menuheight=""40"">"
s=s+         "<IMAGE name=""Prospect.gif"" width=""18"" height=""18""/>"
            If (InStr(reqSysUserOptions,"h") <> 0) Then
s=s+         "<ITEM label=""mLeadAdd"">"
s=s+            "<IMAGE name=""Suspect.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabMarketing',1))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"h") <> 0) Then
s=s+         "<ITEM label=""mLeads"">"
s=s+            "<IMAGE name=""Suspect.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabMarketing',2))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"Z") <> 0) Then
s=s+         "<ITEM label=""mLeadPages"">"
s=s+            "<IMAGE name=""LeadPage.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabMarketing',3))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"z") <> 0) Then
s=s+         "<ITEM label=""mPresentations"">"
s=s+            "<IMAGE name=""Presentation.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabMarketing',4))""/>"
s=s+         "</ITEM>"
            End If
s=s+      "</ITEM>"
         End If
         If (InStr(reqSysUserOptions,"B") <> 0) Then
s=s+      "<ITEM label=""mTraining"" width=""125"" height=""40"" menuwidth=""150"" menuheight=""40"">"
s=s+         "<IMAGE name=""Class.gif"" width=""18"" height=""18""/>"
            If (InStr(reqSysUserOptions,"4") <> 0) Then
s=s+         "<ITEM label=""mGroupTraining"">"
s=s+            "<IMAGE name=""TeamTraining.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabTraining',4))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"K") <> 0) Then
s=s+         "<ITEM label=""mClasses"">"
s=s+            "<IMAGE name=""Class.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabTraining',1))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"L") <> 0) Then
s=s+         "<ITEM label=""mAssessments"">"
s=s+            "<IMAGE name=""Assessment.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabTraining',2))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"M") <> 0) Then
s=s+         "<ITEM label=""mCourses"">"
s=s+            "<IMAGE name=""Catalog.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabTraining',3))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"G") <> 0) Then
s=s+         "<ITEM label=""mMentoring"">"
s=s+            "<IMAGE name=""Mentor.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabTraining',5))""/>"
s=s+         "</ITEM>"
            End If
s=s+      "</ITEM>"
         End If
         If (InStr(reqSysUserOptions,"w") <> 0) Or (InStr(reqSysUserOptions,"/") <> 0) Then
s=s+      "<ITEM label=""mFinancial"" width=""125"" height=""40"" menuwidth=""150"" menuheight=""40"">"
s=s+         "<IMAGE name=""Finance.gif"" width=""18"" height=""18""/>"
            If (InStr(reqSysUserOptions,"V") <> 0) Then
s=s+         "<ITEM label=""mPayments"">"
s=s+            "<IMAGE name=""Finance.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabFinancial',1))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,";") <> 0) Then
s=s+         "<ITEM label=""mReferrals"">"
s=s+            "<IMAGE name=""Genealogy.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabFinancial',2))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"/") <> 0) Then
s=s+         "<DIVIDER/>"
            End If
            If (InStr(reqSysUserOptions,"/") <> 0) Then
s=s+         "<ITEM label=""mExpenses"">"
s=s+            "<IMAGE name=""Calculator.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabFinancial',3))""/>"
s=s+         "</ITEM>"
            End If
s=s+      "</ITEM>"
         End If
s=s+      "<ITEM label=""mAccount"" width=""125"" height=""40"" menuwidth=""150"" menuheight=""40"">"
s=s+         "<IMAGE name=""MyInfo.gif"" width=""18"" height=""18""/>"
            If (InStr(reqSysUserOptions,"I") <> 0) Then
s=s+         "<ITEM label=""mProfile"">"
s=s+            "<IMAGE name=""MyInfo.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabAccount',1))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"V") <> 0) Then
s=s+         "<ITEM label=""mBillingMethod"">"
s=s+            "<IMAGE name=""Finance.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabAccount',2))""/>"
s=s+         "</ITEM>"
            End If
s=s+         "<DIVIDER/>"
            If (reqSysUserGroup <> 1) And (InStr(reqSysUserOptions,"~y") = 0) Then
s=s+         "<ITEM label=""mChangeLogon"">"
s=s+            "<IMAGE name=""logon.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabAccount',3))""/>"
s=s+         "</ITEM>"
            End If
s=s+         "<ITEM label=""mChangePassword"">"
s=s+            "<IMAGE name=""logon.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabAccount',4))""/>"
s=s+         "</ITEM>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""mHelp"" width=""125"" height=""40"" menuwidth=""175"" menuheight=""40"">"
s=s+         "<IMAGE name=""Help.gif"" width=""18"" height=""18""/>"
            If (InStr(reqSysUserOptions,"S") <> 0) Then
s=s+         "<ITEM label=""mFAQ"">"
s=s+            "<IMAGE name=""Question.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabHelp',1))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"R") <> 0) Then
s=s+         "<ITEM label=""mDocs"">"
s=s+            "<IMAGE name=""Help.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabHelp',2))""/>"
s=s+         "</ITEM>"
            End If
            If (InStr(reqSysUserOptions,"m") <> 0) Then
s=s+         "<ITEM label=""mTickets"">"
s=s+            "<IMAGE name=""SupportTicket.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabHelp',3))""/>"
s=s+         "</ITEM>"
            End If
s=s+         "<DIVIDER/>"
s=s+         "<ITEM label=""mWebsite"">"
s=s+            "<IMAGE name=""Home.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""JAVA(ShowTab('TabHelp',4))""/>"
s=s+         "</ITEM>"
s=s+         "<ITEM label=""mSignout"">"
s=s+            "<IMAGE name=""close.gif"" width=""18"" height=""18""/>"
s=s+            "<LINK name=""0101"" nodata=""true"">"
s=s+               "<PARAM name=""ActionCode"" value=""9""/>"
s=s+            "</LINK>"
s=s+         "</ITEM>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM value=""" & reqTitle & """ width=""300"" align=""center""/>"
s=s+   "<ITEM width=""40"">"
s=s+      "<IMAGE name=""Refresh2.png"" width=""29"" height=""30""/>"
s=s+      "<LINK name=""JAVA(doSubmit(0,''))""/>"
s=s+   "</ITEM>"
s=s+"</MENU>"
xmlMemberMenu = s

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
xmlData = xmlData +  xmlMemberMenu
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "m_MemberHome.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_MemberHome Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_MemberHome Load file (oData) failed with error code " + CStr(oData.parseError)
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
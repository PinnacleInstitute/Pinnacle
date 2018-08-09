<!--#include file="Include\System.asp"-->
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
Dim oDownline, xmlDownline
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqTeam2
Dim reqTeam3
Dim reqTeam4
Dim reqTeam5
Dim reqTeam6
Dim reqTeam7
Dim reqTeam8
Dim reqTeam9
Dim reqTeam10
Dim reqTeam11
Dim reqTeam2a
Dim reqTeam3a
Dim reqTeam4a
Dim reqTeam5a
Dim reqTeam6a
Dim reqTeam7a
Dim reqTeam8a
Dim reqTeam9a
Dim reqTeam10a
Dim reqTeam11a
Dim reqTitle
Dim reqTeams
Dim reqTeam6b
Dim reqTeam7b
Dim reqTeam8b
Dim reqTeam9b
Dim reqTeam10b
Dim reqTeam6c
Dim reqTeam7c
Dim reqTeam8c
Dim reqTeam9c
Dim reqTeam10c
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
   SetCache "5409URL", reqReturnURL
   SetCache "5409DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "5409")
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
reqTeam2 =  Numeric(GetInput("Team2", reqPageData))
reqTeam3 =  Numeric(GetInput("Team3", reqPageData))
reqTeam4 =  Numeric(GetInput("Team4", reqPageData))
reqTeam5 =  Numeric(GetInput("Team5", reqPageData))
reqTeam6 =  Numeric(GetInput("Team6", reqPageData))
reqTeam7 =  Numeric(GetInput("Team7", reqPageData))
reqTeam8 =  Numeric(GetInput("Team8", reqPageData))
reqTeam9 =  Numeric(GetInput("Team9", reqPageData))
reqTeam10 =  Numeric(GetInput("Team10", reqPageData))
reqTeam11 =  Numeric(GetInput("Team11", reqPageData))
reqTeam2a =  Numeric(GetInput("Team2a", reqPageData))
reqTeam3a =  Numeric(GetInput("Team3a", reqPageData))
reqTeam4a =  Numeric(GetInput("Team4a", reqPageData))
reqTeam5a =  Numeric(GetInput("Team5a", reqPageData))
reqTeam6a =  Numeric(GetInput("Team6a", reqPageData))
reqTeam7a =  Numeric(GetInput("Team7a", reqPageData))
reqTeam8a =  Numeric(GetInput("Team8a", reqPageData))
reqTeam9a =  Numeric(GetInput("Team9a", reqPageData))
reqTeam10a =  Numeric(GetInput("Team10a", reqPageData))
reqTeam11a =  Numeric(GetInput("Team11a", reqPageData))
reqTitle =  Numeric(GetInput("Title", reqPageData))
reqTeams =  GetInput("Teams", reqPageData)
reqTeam6b =  Numeric(GetInput("Team6b", reqPageData))
reqTeam7b =  Numeric(GetInput("Team7b", reqPageData))
reqTeam8b =  Numeric(GetInput("Team8b", reqPageData))
reqTeam9b =  Numeric(GetInput("Team9b", reqPageData))
reqTeam10b =  Numeric(GetInput("Team10b", reqPageData))
reqTeam6c =  Numeric(GetInput("Team6c", reqPageData))
reqTeam7c =  Numeric(GetInput("Team7c", reqPageData))
reqTeam8c =  Numeric(GetInput("Team8c", reqPageData))
reqTeam9c =  Numeric(GetInput("Team9c", reqPageData))
reqTeam10c =  Numeric(GetInput("Team10c", reqPageData))
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

If (reqCompanyID = 9) Then
   reqTeams = "7,8,9,10,11,"
End If
If (reqCompanyID = 13) Then
   reqTeams = "5,6,7,9,10,11,"
End If
If (reqCompanyID = 14) Then
   reqTeams = "6,7,8,9,10,"
End If
If (reqCompanyID = 17) Then
   reqTeams = "6,7,8,"
End If
If (reqCompanyID = 20) Then
   reqTeams = "2,3,4,"
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqMemberID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqTitle = .Title
            reqCompanyID = .CompanyID
            xmlMember = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMember = Nothing

      Set oDownline = server.CreateObject("ptsDownlineUser.CDownline")
      If oDownline Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsDownlineUser.CDownline"
      Else
         With oDownline
            .SysCurrentLanguage = reqSysLanguage
            If (reqTitle >= 2) And (InStr(reqTeams,"2,") <> 0) Then
               .GetCounts 2, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam2 = .Old
               reqTeam2a = .Dec
            End If
            If (reqTitle >= 3) And (InStr(reqTeams,"3,") <> 0) Then
               .GetCounts 3, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam3 = .Old
               reqTeam3a = .Dec
            End If
            If (reqTitle >= 4) And (InStr(reqTeams,"4,") <> 0) Then
               .GetCounts 4, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam4 = .Old
               reqTeam4a = .Dec
            End If
            If (reqTitle >= 5) And (InStr(reqTeams,"5,") <> 0) Then
               .GetCounts 5, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam5 = .Old
               reqTeam5a = .Dec
            End If
            If (reqTitle >= 6) And (InStr(reqTeams,"6,") <> 0) Then
               .GetCounts 6, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam6 = .Old
               reqTeam6a = .Dec
               If (reqCompanyID = 14) Then
                  .GetCustom 14, 1, 6, reqMemberID
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqTeam6b = .Dec
                  reqTeam6c = .Old
               End If
            End If
            If (reqTitle >= 7) And (InStr(reqTeams,"7,") <> 0) Then
               .GetCounts 7, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam7 = .Old
               reqTeam7a = .Dec
               If (reqCompanyID = 14) Then
                  .GetCustom 14, 1, 7, reqMemberID
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqTeam7b = .Dec
                  reqTeam7c = .Old
               End If
            End If
            If (reqTitle >= 8) And (InStr(reqTeams,"8,") <> 0) Then
               .GetCounts 8, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam8 = .Old
               reqTeam8a = .Dec
               If (reqCompanyID = 14) Then
                  .GetCustom 14, 1, 8, reqMemberID
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqTeam8b = .Dec
                  reqTeam8c = .Old
               End If
            End If
            If (reqTitle >= 9) And (InStr(reqTeams,"9,") <> 0) Then
               .GetCounts 9, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam9 = .Old
               reqTeam9a = .Dec
               If (reqCompanyID = 14) Then
                  .GetCustom 14, 1, 9, reqMemberID
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqTeam9b = .Dec
                  reqTeam9c = .Old
               End If
            End If
            If (reqTitle >= 10) And (InStr(reqTeams,"10,") <> 0) Then
               .GetCounts 10, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam10 = .Old
               reqTeam10a = .Dec
               If (reqCompanyID = 14) Then
                  .GetCustom 14, 1, 10, reqMemberID
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  reqTeam10b = .Dec
                  reqTeam10c = .Old
               End If
            End If
            If (reqTitle >= 11) And (InStr(reqTeams,"11,") <> 0) Then
               .GetCounts 11, reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTeam11 = .Old
               reqTeam11a = .Dec
            End If
         End With
      End If
      Set oDownline = Nothing
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
xmlParam = xmlParam + " team2=" + Chr(34) + CStr(reqTeam2) + Chr(34)
xmlParam = xmlParam + " team3=" + Chr(34) + CStr(reqTeam3) + Chr(34)
xmlParam = xmlParam + " team4=" + Chr(34) + CStr(reqTeam4) + Chr(34)
xmlParam = xmlParam + " team5=" + Chr(34) + CStr(reqTeam5) + Chr(34)
xmlParam = xmlParam + " team6=" + Chr(34) + CStr(reqTeam6) + Chr(34)
xmlParam = xmlParam + " team7=" + Chr(34) + CStr(reqTeam7) + Chr(34)
xmlParam = xmlParam + " team8=" + Chr(34) + CStr(reqTeam8) + Chr(34)
xmlParam = xmlParam + " team9=" + Chr(34) + CStr(reqTeam9) + Chr(34)
xmlParam = xmlParam + " team10=" + Chr(34) + CStr(reqTeam10) + Chr(34)
xmlParam = xmlParam + " team11=" + Chr(34) + CStr(reqTeam11) + Chr(34)
xmlParam = xmlParam + " team2a=" + Chr(34) + CStr(reqTeam2a) + Chr(34)
xmlParam = xmlParam + " team3a=" + Chr(34) + CStr(reqTeam3a) + Chr(34)
xmlParam = xmlParam + " team4a=" + Chr(34) + CStr(reqTeam4a) + Chr(34)
xmlParam = xmlParam + " team5a=" + Chr(34) + CStr(reqTeam5a) + Chr(34)
xmlParam = xmlParam + " team6a=" + Chr(34) + CStr(reqTeam6a) + Chr(34)
xmlParam = xmlParam + " team7a=" + Chr(34) + CStr(reqTeam7a) + Chr(34)
xmlParam = xmlParam + " team8a=" + Chr(34) + CStr(reqTeam8a) + Chr(34)
xmlParam = xmlParam + " team9a=" + Chr(34) + CStr(reqTeam9a) + Chr(34)
xmlParam = xmlParam + " team10a=" + Chr(34) + CStr(reqTeam10a) + Chr(34)
xmlParam = xmlParam + " team11a=" + Chr(34) + CStr(reqTeam11a) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CStr(reqTitle) + Chr(34)
xmlParam = xmlParam + " teams=" + Chr(34) + CleanXML(reqTeams) + Chr(34)
xmlParam = xmlParam + " team6b=" + Chr(34) + CStr(reqTeam6b) + Chr(34)
xmlParam = xmlParam + " team7b=" + Chr(34) + CStr(reqTeam7b) + Chr(34)
xmlParam = xmlParam + " team8b=" + Chr(34) + CStr(reqTeam8b) + Chr(34)
xmlParam = xmlParam + " team9b=" + Chr(34) + CStr(reqTeam9b) + Chr(34)
xmlParam = xmlParam + " team10b=" + Chr(34) + CStr(reqTeam10b) + Chr(34)
xmlParam = xmlParam + " team6c=" + Chr(34) + CStr(reqTeam6c) + Chr(34)
xmlParam = xmlParam + " team7c=" + Chr(34) + CStr(reqTeam7c) + Chr(34)
xmlParam = xmlParam + " team8c=" + Chr(34) + CStr(reqTeam8c) + Chr(34)
xmlParam = xmlParam + " team9c=" + Chr(34) + CStr(reqTeam9c) + Chr(34)
xmlParam = xmlParam + " team10c=" + Chr(34) + CStr(reqTeam10c) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlDownline
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Downline[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Downline[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "5409 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "5409 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "5409 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "5409.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "5409 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "5409 Load file (oData) failed with error code " + CStr(oData.parseError)
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
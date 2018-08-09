<!--#include file="Include\System.asp"-->
<!--#include file="Include\Resources.asp"-->
<!--#include file="Include\Share.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionView = 1
Const cActionReturn = 3
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
Dim oMetric, xmlMetric
Dim oMetrics, xmlMetrics
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqGroupID
Dim reqFromDate
Dim reqToDate
Dim reqTerm
Dim reqTotal
Dim reqDays
Dim reqDays30
Dim reqTrack
Dim reqTheme
Dim reqRank
Dim reqEnrollDate
Dim reqFromPts1
Dim reqFromPts2
Dim reqFromPts3
Dim reqFromPts4
Dim reqFromPts5
Dim reqToPts1
Dim reqToPts2
Dim reqToPts3
Dim reqToPts4
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
   SetCache "m_11712URL", reqReturnURL
   SetCache "m_11712DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_11712")
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
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
reqTerm =  Numeric(GetInput("Term", reqPageData))
reqTotal =  Numeric(GetInput("Total", reqPageData))
reqDays =  Numeric(GetInput("Days", reqPageData))
reqDays30 =  Numeric(GetInput("Days30", reqPageData))
reqTrack =  Numeric(GetInput("Track", reqPageData))
reqTheme =  Numeric(GetInput("Theme", reqPageData))
reqRank =  Numeric(GetInput("Rank", reqPageData))
reqEnrollDate =  GetInput("EnrollDate", reqPageData)
reqFromPts1 =  Numeric(GetInput("FromPts1", reqPageData))
reqFromPts2 =  Numeric(GetInput("FromPts2", reqPageData))
reqFromPts3 =  Numeric(GetInput("FromPts3", reqPageData))
reqFromPts4 =  Numeric(GetInput("FromPts4", reqPageData))
reqFromPts5 =  Numeric(GetInput("FromPts5", reqPageData))
reqToPts1 =  Numeric(GetInput("ToPts1", reqPageData))
reqToPts2 =  Numeric(GetInput("ToPts2", reqPageData))
reqToPts3 =  Numeric(GetInput("ToPts3", reqPageData))
reqToPts4 =  Numeric(GetInput("ToPts4", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
m_CheckSecurity reqSysUserID, reqSysUserGroup, 1, 52, "MobileHome.asp"
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
         reqCompanyID = .CompanyID
         reqEnrollDate = DateValue(.EnrollDate)
         reqGroupID = .GroupID
      End With
   End If
   Set oMember = Nothing
End Sub

Sub ViewMetrics()
   On Error Resume Next
   If (reqGroupID <> 0) Then
      reqGroupID = GetSharedActivities( reqGroupID, tmpTracks, reqTheme )
   End If

   If (reqGroupID = 0) Then
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
            tmpTracks = .UploadURL
         End With
      End If
      Set oCoption = Nothing
   End If

   Set oMetric = server.CreateObject("ptsMetricUser.CMetric")
   If oMetric Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetric"
   Else
      With oMetric
         .SysCurrentLanguage = reqSysLanguage
         .MemberTotal CLng(reqMemberID), CDate(reqFromDate), CDate(reqToDate)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqRank = .MetricTypeID
      End With
   End If
   Set oMetric = Nothing

   Set oMetrics = server.CreateObject("ptsMetricUser.CMetrics")
   If oMetrics Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetrics"
   Else
      With oMetrics
         .SysCurrentLanguage = reqSysLanguage
         .MemberSummary CLng(reqMemberID), CDate(reqFromDate), CDate(reqToDate)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  Default = "10,100,250,500"
                  If tmpTracks = "" Then tmpTracks = Default
                  pts = Split(tmpTracks, ",")
                  If UBOUND(pts) < 3 Then
                  tmpTracks = Default
                  pts = Split(tmpTracks, ",")
                  End If

                  reqFromPts1 = 1
                  reqToPts1 =   pts(0)
                  reqFromPts2 = pts(0) + 1
                  reqToPts2 =   pts(1)
                  reqFromPts3 = pts(1) + 1
                  reqToPts3 =   pts(2)
                  reqFromPts4 = pts(2) + 1
                  reqToPts4 =   pts(3)
                  reqFromPts5 = pts(3) + 1

                  reqTotal = 0
                  For Each oItem in oMetrics
                  reqTotal = reqTotal + oItem.Points
                  Next
                  reqDays = DateDiff( "d", reqFromDate, reqToDate ) + 1
                  If reqDays > 0 Then
                  avg = ROUND( reqTotal / reqDays, 1)
                  reqDays30 = avg * 30
                  If reqDays30 <= reqToPts1 Then reqTrack = 1
                  If reqDays30 >= reqFromPts2 And reqDays30 <= reqToPts2 Then reqTrack = 2
                  If reqDays30 >= reqFromPts3 And reqDays30 <= reqToPts3 Then reqTrack = 3
                  If reqDays30 >= reqFromPts4 And reqDays30 <= reqToPts4 Then reqTrack = 4
                  If reqDays30 >= reqFromPts5 Then reqTrack = 5
                  End If
               
         xmlMetrics = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMetrics = Nothing
End Sub

If (reqCompanyID = 0) Then
   reqCompanyID = reqSysCompanyID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadMember
      reqTerm = 1
      reqFromDate = reqEnrollDate
      reqToDate = reqSysDate
      ViewMetrics

   Case CLng(cActionView):
      LoadMember
      ViewMetrics

   Case CLng(cActionReturn):

      Response.Redirect "m_11711.asp" & "?MemberID=" & reqMemberID
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
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " term=" + Chr(34) + CStr(reqTerm) + Chr(34)
xmlParam = xmlParam + " total=" + Chr(34) + CStr(reqTotal) + Chr(34)
xmlParam = xmlParam + " days=" + Chr(34) + CStr(reqDays) + Chr(34)
xmlParam = xmlParam + " days30=" + Chr(34) + CStr(reqDays30) + Chr(34)
xmlParam = xmlParam + " track=" + Chr(34) + CStr(reqTrack) + Chr(34)
xmlParam = xmlParam + " theme=" + Chr(34) + CStr(reqTheme) + Chr(34)
xmlParam = xmlParam + " rank=" + Chr(34) + CStr(reqRank) + Chr(34)
xmlParam = xmlParam + " enrolldate=" + Chr(34) + CStr(reqEnrollDate) + Chr(34)
xmlParam = xmlParam + " frompts1=" + Chr(34) + CStr(reqFromPts1) + Chr(34)
xmlParam = xmlParam + " frompts2=" + Chr(34) + CStr(reqFromPts2) + Chr(34)
xmlParam = xmlParam + " frompts3=" + Chr(34) + CStr(reqFromPts3) + Chr(34)
xmlParam = xmlParam + " frompts4=" + Chr(34) + CStr(reqFromPts4) + Chr(34)
xmlParam = xmlParam + " frompts5=" + Chr(34) + CStr(reqFromPts5) + Chr(34)
xmlParam = xmlParam + " topts1=" + Chr(34) + CStr(reqToPts1) + Chr(34)
xmlParam = xmlParam + " topts2=" + Chr(34) + CStr(reqToPts2) + Chr(34)
xmlParam = xmlParam + " topts3=" + Chr(34) + CStr(reqToPts3) + Chr(34)
xmlParam = xmlParam + " topts4=" + Chr(34) + CStr(reqToPts4) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlMetric
xmlTransaction = xmlTransaction +  xmlMetrics
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Metric[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Metric[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_11712 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_11712 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_11712 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "m_11712.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_11712 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_11712 Load file (oData) failed with error code " + CStr(oData.parseError)
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
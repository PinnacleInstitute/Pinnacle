<!--#include file="Include\System.asp"-->
<!--#include file="Include\ChartURL.asp"-->
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
Dim oCompany, xmlCompany
Dim oMembers, xmlMembers
'-----declare page parameters
Dim reqCompanyID
Dim reqReport
Dim reqFromDate
Dim reqToDate
Dim reqCount
Dim reqOption
Dim reqChartSource
Dim reqUnit
Dim reqImageMap
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
   SetCache "0460URL", reqReturnURL
   SetCache "0460DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0460")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqReport =  Numeric(GetInput("Report", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
reqCount =  Numeric(GetInput("Count", reqPageData))
reqOption =  Numeric(GetInput("Option", reqPageData))
reqChartSource =  GetInput("ChartSource", reqPageData)
reqUnit =  GetInput("Unit", reqPageData)
reqImageMap =  GetInput("ImageMap", reqPageData)
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 125
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

If (reqSysUserGroup > 23) And (reqCompanyID <> reqSysCompanyID) Then
   AbortUser()
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
            'validate all parameters
            If reqReport < 1 OR reqReport > 6 Then reqReport = 1
            If IsDate(reqFromDate) AND IsDate(reqToDate) Then
               tmpDays = DateDiff("d", reqFromDate, reqToDate )
               If tmpDays <= 31 Then reqUnit = "day"
               If tmpDays > 31 AND tmpDays <= 180 Then reqUnit = "week"
               If tmpDays > 180 AND tmpDays <= 365 Then reqUnit = "month"
               If tmpDays > 365 Then reqUnit = "quarter"
            Else
               reqFromDate = CDate( DateAdd("d", -1, Date()) )
               reqToDate = CDate( Date() )
               reqUnit = "day"   
            End If


      If (reqCompanyID > 0) Then
         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqCompanyID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlCompany = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCompany = Nothing
      End If

      Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
      If oMembers Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
      Else
         With oMembers
            .SysCurrentLanguage = reqSysLanguage
            If (reqReport = 1) Then
               .ReportMembership CLng(reqCompanyID), reqFromDate, reqToDate
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqReport = 2) Then
               .ReportNewEnrollment CLng(reqCompanyID), reqFromDate, reqToDate, reqUnit
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqReport = 3) Then
               .ReportTotalEnrollment CLng(reqCompanyID), reqFromDate, reqToDate, reqUnit
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqReport = 4) Then
               .ReportBilling CLng(reqCompanyID), reqFromDate, reqToDate
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqReport = 5) And (reqOption = 0) Then
               .ReportVisit CLng(reqCompanyID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqReport = 5) And (reqOption <> 0) Then
               .ReportVisitStatus CLng(reqCompanyID), reqOption
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqReport = 6) Then
               .ReportAuthLog CLng(reqCompanyID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            
            tmpData = ""
            tmpLabels = ""
            Dim extraData
            ReDim extraData(oMembers.Count)
            counter = LBound(extraData)
            For Each oMember in oMembers
               With oMember
                  If reqReport <> 6 Then reqCount = reqCount + .Quantity
                  Select Case reqReport
                  Case 1:
                     tmpLabels = tmpLabels + .Status + "|"
                     tmpData = tmpData + .Quantity + "|"
                     extraData(counter) = .MemberID
                  Case 2:
                     .EnrollDate = FormatDateTime(.EnrollDate,2)
                     tmpLabels = tmpLabels + Left(.EnrollDate,Len(.EnrollDate)-5) + "|"
                     tmpData = tmpData + .Quantity + "|"
                  Case 3:
                     .EnrollDate = FormatDateTime(.EnrollDate,2)
                     tmpLabels = tmpLabels + Left(.EnrollDate,Len(.EnrollDate)-5) + "|"
                     tmpData = tmpData + .Quantity + "|"
                  Case 4:
                     tmpLabels = tmpLabels + .Billing + "|"
                     tmpData = tmpData + .Quantity + "|"
                     extraData(counter) = .MemberID
                  Case 5:
                     tmpLabels = tmpLabels + .Amount + "|"
                     tmpData = tmpData + .Quantity + "|"
                     extraData(counter) = .MemberID
                  Case 6:
                     reqCount = reqCount + 1
                  End Select
               End With
               counter = counter + 1
            Next

            'Remove last | delimiter
            If tmpData <> "" And Right(tmpData,1) = "|" Then tmpData = Left(tmpData, Len(tmpData)-1 )
            If tmpLabels <> "" And Right(tmpLabels,1) = "|" Then tmpLabels = Left(tmpLabels, Len(tmpLabels)-1 )

            reqCount = FormatNumber(reqCount,0)
            tmpImageMapURL = "0461.asp?Report=" & reqReport & "&FromDate=" & reqFromDate & "&ToDate=" & reqToDate & "&CompanyID=" & reqCompanyID & "&Option=" & reqOption

            '---ChartURL( Type, Width, Height, StartDate, EndDate, Unit, LangFile, Data, Title, XTitle, YTitle )
            Select Case reqReport
            Case 1:
               ChartLabels "0460Chart1", tmpLabels, "", "", "", ""
               reqChartSource = ChartImageMap( "pie", 750, 400, "", "", "", tmpData, tmpLabels, "", "", "", extraData, reqImageMap, tmpImageMapURL)
            Case 2:
               reqChartSource = "Chart.asp?type=line&width=750&height=400&data=" + tmpData + "&labels=" + tmpLabels
            Case 3:
               reqChartSource = "Chart.asp?type=bar&width=750&height=400&data=" + tmpData + "&labels=" + tmpLabels
            Case 4:
               ChartLabels "0460Chart2", tmpLabels, "", "", "", ""
               reqChartSource = ChartImageMap( "pie", 750, 400, "", "", "", tmpData, tmpLabels, "", "", "", extraData, reqImageMap, tmpImageMapURL)
            Case 5:
               ChartLabels "0460Chart3", tmpLabels, "", "", "", ""
               reqChartSource = ChartImageMap( "pie", 750, 400, "", "", "", tmpData, tmpLabels, "", "", "", extraData, reqImageMap, tmpImageMapURL)
            End Select

            If (reqReport = 6) Then
               xmlMembers = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMembers = Nothing
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " report=" + Chr(34) + CStr(reqReport) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " option=" + Chr(34) + CStr(reqOption) + Chr(34)
xmlParam = xmlParam + " chartsource=" + Chr(34) + CleanXML(reqChartSource) + Chr(34)
xmlParam = xmlParam + " unit=" + Chr(34) + CleanXML(reqUnit) + Chr(34)
xmlParam = xmlParam + " imagemap=" + Chr(34) + CleanXML(reqImageMap) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlMembers
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\0460[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\0460[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0460 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0460 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0460 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0460.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0460 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0460 Load file (oData) failed with error code " + CStr(oData.parseError)
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
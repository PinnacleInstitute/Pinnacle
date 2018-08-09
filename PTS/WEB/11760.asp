<!--#include file="Include\System.asp"-->
<!--#include file="Include\ChartURL.asp"-->
<!--#include file="Include\Resources.asp"-->
<!--#include file="Include\Share.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionReport = 1
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
Dim oMetrics, xmlMetrics
Dim oMember, xmlMember
'-----declare page parameters
Dim reqMemberID
Dim reqGroupID
Dim reqCompanyID
Dim reqReport
Dim reqTerm
Dim reqFromDate
Dim reqToDate
Dim reqChartSource
Dim reqUnit
Dim reqTracks
Dim reqCount
Dim reqEnrollDate
Dim reqTotal1
Dim reqTotal2
Dim reqTotal3
Dim reqTrack1
Dim reqTrack2
Dim reqTrack3
Dim reqTrack4
Dim reqTheme
Dim reqTest
Dim reqMobile
Dim reqGoal
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
   SetCache "11760URL", reqReturnURL
   SetCache "11760DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "11760")
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
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqReport =  Numeric(GetInput("Report", reqPageData))
reqTerm =  Numeric(GetInput("Term", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
reqChartSource =  GetInput("ChartSource", reqPageData)
reqUnit =  GetInput("Unit", reqPageData)
reqTracks =  GetInput("Tracks", reqPageData)
reqCount =  Numeric(GetInput("Count", reqPageData))
reqEnrollDate =  GetInput("EnrollDate", reqPageData)
reqTotal1 =  GetInput("Total1", reqPageData)
reqTotal2 =  GetInput("Total2", reqPageData)
reqTotal3 =  GetInput("Total3", reqPageData)
reqTrack1 =  Numeric(GetInput("Track1", reqPageData))
reqTrack2 =  Numeric(GetInput("Track2", reqPageData))
reqTrack3 =  Numeric(GetInput("Track3", reqPageData))
reqTrack4 =  Numeric(GetInput("Track4", reqPageData))
reqTheme =  Numeric(GetInput("Theme", reqPageData))
reqTest =  Numeric(GetInput("Test", reqPageData))
reqMobile =  Numeric(GetInput("Mobile", reqPageData))
reqGoal =  GetInput("Goal", reqPageData)
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

Function FillDataLabels( byVal bvFromDate, byVal bvToDate, byVal bvUnit, byRef brLabels, byRef brData, byRef brLabels2, byRef brData2 )
   On Error Resume Next
   
               tmpLabels = ""
               tmpData = ""
               tmpData2 = ""
               tmpPart = "d"

               'Build Master Label List ******************
               Select Case bvUnit
               Case "day": tmpPart = "d"
               Case "week": tmpPart = "ww"
               Case "month": tmpPart = "m"
               Case "quarter": tmpPart = "q"
               End Select

               total = DateDiff( tmpPart, bvFromDate, bvToDate )

               While total >= 0
                  tmpLabels = tmpLabels + CStr( DatePart( tmpPart, bvFromDate ) ) + "|"
                  bvFromDate = DateAdd( tmpPart, 1, bvFromDate )
                  total = total - 1
               Wend
               If tmpLabels <> "" Then tmpLabels = Left(tmpLabels, Len(tmpLabels)-1 )

               'Update Data Lists ******************
               aMasterLabels = Split(tmpLabels, "|")
               aLabels = Split(brLabels, "|")
               aLabels2 = Split(brLabels2, "|")
               aData = Split(brData, "|")
               aData2 = Split(brData2, "|")

               tmpData = ""
               tmpData2 = ""
               For x = 0 to UBound(aMasterLabels)
                  label = aMasterLabels(x)
                  val = 0
                  For y = 0 to UBound(aLabels)
                     If label = aLabels(y) Then
                        val = aData(y)
                        Exit For
                     End If
                  Next
                  tmpData = tmpData + CStr(val) + "|"
                  val = 0
                  For y = 0 to UBound(aLabels2)
                     If label = aLabels2(y) Then
                        val = aData2(y)
                        Exit For
                     End If
                  Next
                  tmpData2 = tmpData2 + CStr(val) + "|"
               Next
               If tmpData <> "" Then tmpData = Left(tmpData, Len(tmpData)-1 )
               If tmpData2 <> "" Then tmpData2 = Left(tmpData2, Len(tmpData2)-1 )

               brLabels = tmpLabels
               brData = tmpData
               brData2 = tmpData2
            
End Function

Function FillGoalData(byRef brData )
   On Error Resume Next
   
               tmpData = ""
               aData = Split(brData, "|")
               Points = 0
               total = UBOUND(aData)
               For x = 0 to total
                  pts = CInt(aData(x))
                  If pts = 0 Then pts = Points Else Points = pts
                  tmpData = tmpData + CStr(pts)
                  If x < total Then tmpData = tmpData + "|"
               Next
               brData = tmpData
            
End Function

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
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub LoadReport()
   On Error Resume Next
   If (reqReport = 10) Or (reqReport = 20) Or (reqReport = 30) Then
      If (reqSysUserGroup <> 41) Then
         GetResources reqGroupID
      End If
      If (reqGroupID <> 0) Then
         tmpGroupID = GetSharedActivities( reqGroupID, tmpTracks, reqTheme )
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
      If (tmpTracks = "") Then
         tmpTracks = "10,100,250,500"
      End If
      reqUnit = tmpTracks
   End If
   
               'validate all parameters
               If reqReport < 1 OR reqReport > 45 Then reqReport = 20
               If reqReport <> 10 And reqReport <> 30 Then
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
               End If

               If reqReport = 10 Or reqReport = 30 Then
                  If reqUnit = "" Then reqUnit = "10,100,250,500"
                  a = Split(reqUnit,",")
                  If ubound(a) = 3 Then
                     reqTrack1 = a(0)
                     reqTrack2 = a(1)
                     reqTrack3 = a(2)
                     reqTrack4 = a(3)
                  End If
               End If
            

   If (reqReport <> 20) Then
      Set oMetrics = server.CreateObject("ptsMetricUser.CMetrics")
      If oMetrics Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetrics"
      Else
         With oMetrics
            .SysCurrentLanguage = reqSysLanguage
            .Report reqReport, CLng(reqMemberID), CDate(reqFromDate), CDate(reqToDate), reqUnit
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
                  If reqTest > 0 Then response.write "<BR>" + CStr(reqReport) + " - " + CStr(reqMemberID) + " - " + CStr(reqFromDate) + " - " + CStr(reqToDate) + " - " + CStr(reqUnit)
                  tmpData = ""
                  tmpLabels = ""
                  tmpData2 = ""
                  tmpLabels2 = ""
                  reqCount = 0
                  tmp1 = 0
                  tmp2 = 0
                  Dim extraData
                  ReDim extraData(oMetrics.Count)
                  counter = LBound(extraData)
                  For Each oMetric in oMetrics
                     reqCount = reqCount + 1
                     With oMetric
                        Select Case reqReport
                        Case 1,11,31:
                           tmpLabels = tmpLabels + .Note + "|"
                           tmpData = tmpData + .Points + "|"
                           If .MetricID <= 2 Then tmp1 = tmp1 + .Points
                           If .MetricID >= 3 Then tmp2 = tmp2 + .Points
                        Case 2,12,32,3,13,33:
                           tmp = .Note
                           If Len(tmp) > 30 Then tmp = Left(tmp,30) + "..."
                           If .Qty <> 0 Then tmp = "**" + tmp
                           tmpLabels = tmpLabels + tmp + "|"
                           tmpData = tmpData + .Points + "|"
                           If .Qty <> 0 Then tmp1 = tmp1 + .Points
                           If .Qty = 0 Then tmp2 = tmp2 + .Points
                        Case 4,14,34,5,15,35:
                           If .Qty = 0 Then
                              tmpLabels2 = tmpLabels2 + .Note + "|"
                              tmpData2 = tmpData2 + .Points + "|"
                           Else
                              tmpLabels = tmpLabels + .Note + "|"
                              tmpData = tmpData + .Points + "|"
                           End If
                        Case 41,42,43,44,45:
                           If .Qty = 0 Then  'Goal
                              tmpLabels = tmpLabels + .Note + "|"
                              tmpData = tmpData + .Points + "|"
                           Else
                              tmpLabels2 = tmpLabels2 + .Note + "|"
                              tmpData2 = tmpData2 + .Points + "|"
                           End If
                        Case 10,30:
                           tmpLabels = tmpLabels + .Note + "|"
                           tmpData = tmpData + .Points + "|"
                        End Select
                     End With
                     counter = counter + 1
                  Next
                  If reqCount = 0 Then reqCount = -1

                  'Remove last | delimiter
                  If tmpData <> "" And Right(tmpData,1) = "|" Then tmpData = Left(tmpData, Len(tmpData)-1 )
                  If tmpData2 <> "" And Right(tmpData2,1) = "|" Then tmpData2 = Left(tmpData2, Len(tmpData2)-1 )
                  'If tmpData3 <> "" And Right(tmpData3,1) = "|" Then tmpData3 = Left(tmpData3, Len(tmpData3)-1 )
                  If tmpLabels <> "" And Right(tmpLabels,1) = "|" Then tmpLabels = Left(tmpLabels, Len(tmpLabels)-1 )
                  If tmpLabels2 <> "" And Right(tmpLabels2,1) = "|" Then tmpLabels2 = Left(tmpLabels2, Len(tmpLabels2)-1 )
               
         End With
      End If
      Set oMetrics = Nothing
   End If

   If (reqReport = 20) Then
      Set oMetrics = server.CreateObject("ptsMetricUser.CMetrics")
      If oMetrics Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetrics"
      Else
         With oMetrics
            .SysCurrentLanguage = reqSysLanguage
            .MemberSummary CLng(reqMemberID), CDate(reqFromDate), CDate(reqToDate)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
                  reqTotal = 0
                  Points = 0
                  For Each oItem in oMetrics
                     reqTotal = reqTotal + oItem.Points
                  Next
                  reqDays = DateDiff( "d", reqFromDate, reqToDate ) + 1
                  If reqDays > 0 Then
                  avg = ROUND( reqTotal / reqDays, 1)
                  Points = avg * 30
                  End If
                  a = Split( tmpTracks, ",")
                  val = a(3)
                  'Create 5th Track pts. rounded up to 100x
                  val = Round( ((val*1.25)+50) /100 ) * 100
                  If Points > val Then Points = val
                  tmpData = CStr(Points) + "|" + Replace(tmpTracks, ",", "|") + "|" + CStr(val)
               
            xmlMetrics = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMetrics = Nothing
   End If
   
               Select Case reqReport
               Case 1,11,31:
               tmpResult = tmp1 / (tmp1+tmp2)
               tmpActivity = tmp2 / (tmp1+tmp2)
               reqTotal1 = FormatPercent( tmpResult, 0)
               reqTotal2 = FormatPercent( tmpActivity, 0)
               reqTotal3 = FormatPercent( tmpResult / tmpActivity, 0)
               ChartLabels "11760Chart", tmpLabels, "", "", "", ""
               reqChartSource = "Chart.asp?type=pie&width=750&height=400&data=" + tmpData + "&labels=" + tmpLabels

               Case 2,12,32,3,13,33:
               tmpResult = tmp1 / (tmp1+tmp2)
               tmpActivity = tmp2 / (tmp1+tmp2)
               reqTotal1 = FormatPercent( tmpResult, 0)
               reqTotal2 = FormatPercent( tmpActivity, 0)
               reqTotal3 = FormatPercent( tmpResult / tmpActivity, 0)
               reqChartSource = "Chart.asp?type=hbar&width=750&height=400&data=" + tmpData + "&labels=" + tmpLabels

               Case 4,14,34,5,15,35:
               tmpLegend = "Results|Activities"
               ChartLabels "11760Chart", "", tmpLegend, "", "", ""
               FillDataLabels reqFromDate, reqToDate, reqUnit, tmpLabels, tmpData, tmpLabels2, tmpData2
               reqChartSource = "Chart.asp?type=line&width=750&height=400&data=" + tmpData + "&data2=" + tmpData2 + "&labels=" + tmpLabels + "&legend=" + tmpLegend

               Case 41,42,43,44,45:
               tmpLegend = "Goal|Actual"
               ChartLabels "11760Chart", "", tmpLegend, "", "", ""
               FillDataLabels reqFromDate, reqToDate, reqUnit, tmpLabels, tmpData, tmpLabels2, tmpData2
               FillGoalData tmpData
               reqChartSource = "Chart.asp?type=line&width=750&height=400&data=" + tmpData + "&data2=" + tmpData2 + "&labels=" + tmpLabels + "&legend=" + tmpLegend

               Case 10,30:
               If reqTheme = 1 Then
               tmpLabels = Replace(tmpLabels, "2-1", "2-1a")
               tmpLabels = Replace(tmpLabels, "2-2", "2-2a")
               tmpLabels = Replace(tmpLabels, "2-3", "2-3a")
               tmpLabels = Replace(tmpLabels, "2-4", "2-4a")
               tmpLabels = Replace(tmpLabels, "2-5", "2-5a")
               End If
               ChartLabels "11760Chart", tmpLabels, "", "", "", ""
               reqChartSource = "Chart.asp?type=pie&width=750&height=400&data=" + tmpData + "&labels=" + tmpLabels + "&unit=" + reqUnit

               Case 20:
               reqCount = 1
               If reqTheme = 0 Then tmpLabels="2-1|2-2|2-3|2-4|2-5"
               If reqTheme = 1 Then tmpLabels="2-1a|2-2a|2-3a|2-4a|2-5a"
               ChartLabels "11760Chart", tmpLabels, "", "", "", ""
               reqChartSource = "Chart.asp?type=meter&width=750&height=400&data=" + tmpData + "&labels=" + tmpLabels

               End Select
               If reqTest > 0 Then response.write "<BR>" + reqChartSource
            
End Sub


Set oMetrics = server.CreateObject("ptsMetricUser.CMetrics")
If oMetrics Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetrics"
Else
   With oMetrics
      .SysCurrentLanguage = reqSysLanguage
      .ListGoal CLng(reqMemberID)
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      
                  reqGoal = ""
                  For Each oItem in oMetrics
                     With oItem
                        Select Case .MetricTypeID
                           Case "-1": reqGoal = reqGoal + "41,"
                           Case "-2": reqGoal = reqGoal + "42,"
                           Case "-3": reqGoal = reqGoal + "43,"
                           Case "-4": reqGoal = reqGoal + "44,"
                           Case "-5": reqGoal = reqGoal + "45,"
                        End Select
                     End With
                  Next
               
   End With
End If
Set oMetrics = Nothing
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadMember
      reqReport = 20
      reqTerm = 1
      reqFromDate = reqEnrollDate
      reqToDate = reqSysDate
      LoadReport

   Case CLng(cActionReport):
      LoadMember
      LoadReport
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
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " report=" + Chr(34) + CStr(reqReport) + Chr(34)
xmlParam = xmlParam + " term=" + Chr(34) + CStr(reqTerm) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " chartsource=" + Chr(34) + CleanXML(reqChartSource) + Chr(34)
xmlParam = xmlParam + " unit=" + Chr(34) + CleanXML(reqUnit) + Chr(34)
xmlParam = xmlParam + " tracks=" + Chr(34) + CleanXML(reqTracks) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " enrolldate=" + Chr(34) + CStr(reqEnrollDate) + Chr(34)
xmlParam = xmlParam + " total1=" + Chr(34) + CleanXML(reqTotal1) + Chr(34)
xmlParam = xmlParam + " total2=" + Chr(34) + CleanXML(reqTotal2) + Chr(34)
xmlParam = xmlParam + " total3=" + Chr(34) + CleanXML(reqTotal3) + Chr(34)
xmlParam = xmlParam + " track1=" + Chr(34) + CStr(reqTrack1) + Chr(34)
xmlParam = xmlParam + " track2=" + Chr(34) + CStr(reqTrack2) + Chr(34)
xmlParam = xmlParam + " track3=" + Chr(34) + CStr(reqTrack3) + Chr(34)
xmlParam = xmlParam + " track4=" + Chr(34) + CStr(reqTrack4) + Chr(34)
xmlParam = xmlParam + " theme=" + Chr(34) + CStr(reqTheme) + Chr(34)
xmlParam = xmlParam + " test=" + Chr(34) + CStr(reqTest) + Chr(34)
xmlParam = xmlParam + " mobile=" + Chr(34) + CStr(reqMobile) + Chr(34)
xmlParam = xmlParam + " goal=" + Chr(34) + CleanXML(reqGoal) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMetrics
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\11760[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\11760[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "11760 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "11760 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "11760 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "11760.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "11760 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "11760 Load file (oData) failed with error code " + CStr(oData.parseError)
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
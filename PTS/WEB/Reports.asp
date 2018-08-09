<!--#include file="Include\System.asp"-->
<!--#include file="Include\ChartURL.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oMember, xmlMember
'-----declare page parameters
Dim reqC
Dim reqM
Dim reqD
Dim reqMR
Dim reqRpt
Dim reqP1
Dim reqP2
Dim reqP3
Dim reqP4
Dim reqP5
Dim reqUserName
Dim reqRptType
Dim reqNewRpt
Dim reqMode
Dim reqSecure
Dim reqChartSource
Dim reqCount
Dim reqTest
Dim reqDate
Dim reqFile
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

reqSysTestFile = GetInput("SysTestFile", reqPageData)
If Len(reqSysTestFile) > 0 Then
   SetCache "SYSTESTFILE", reqSysTestFile
Else
   reqSysTestFile = GetCache("SYSTESTFILE")
End If

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
reqSysDate = CStr(Date())
reqSysTime = CStr(Time())
reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
reqSysServerName = Request.ServerVariables("SERVER_NAME")
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(LCASE(reqSysServerPath), "reports")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqC =  Numeric(GetInput("C", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqD =  GetInput("D", reqPageData)
reqMR =  Numeric(GetInput("MR", reqPageData))
reqRpt =  Numeric(GetInput("Rpt", reqPageData))
reqP1 =  GetInput("P1", reqPageData)
reqP2 =  GetInput("P2", reqPageData)
reqP3 =  GetInput("P3", reqPageData)
reqP4 =  GetInput("P4", reqPageData)
reqP5 =  GetInput("P5", reqPageData)
reqUserName =  GetInput("UserName", reqPageData)
reqRptType =  GetInput("RptType", reqPageData)
reqNewRpt =  Numeric(GetInput("NewRpt", reqPageData))
reqMode =  Numeric(GetInput("Mode", reqPageData))
reqSecure =  Numeric(GetInput("Secure", reqPageData))
reqChartSource =  GetInput("ChartSource", reqPageData)
reqCount =  Numeric(GetInput("Count", reqPageData))
reqTest =  Numeric(GetInput("Test", reqPageData))
reqDate =  GetInput("Date", reqPageData)
reqFile =  GetInput("File", reqPageData)
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

Sub GetMemberReference()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqM, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqMR = .Reference
      End With
   End If
   Set oMember = Nothing
End Sub


reqUserName = GetCache("USERNAME")
reqSysUserGroup = Numeric(GetCache("USERGROUP"))
reqSysUserID = Numeric(GetCache("USERID"))
reqSysCompanyID = Numeric(GetCache("COMPANYID"))
reqSysMemberID = Numeric(GetCache("MEMBERID"))
reqSecure = Numeric(GetCache("SECURITYLEVEL"))
reqSysUserOptions = GetCache("USEROPTIONS")
reqDate = CStr(Date()) + " " + CStr(Time())

If reqC = 0 Then reqC = reqSysCompanyID
If reqM = 0 Then reqM = reqSysMemberID
If reqC = 0 AND reqM = 0 Then reqRptType = "system"

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqRptType = "") Then
         If (reqM = 0) Then
            reqRptType = "company"
         End If
         If (reqM <> 0) Then
            reqRptType = "member"
         End If
      End If
      If (reqRptType = "system") Then
         If (reqSysUserGroup > 23) Then
            reqRptType = ""
         End If
      End If
      If (reqRptType = "company") Then
         If (reqSysUserGroup > 23) And (reqSysUserGroup <> 51) And (reqSysUserGroup <> 52) Then
            reqRptType = ""
         End If
      End If
      If (reqRptType = "member") Then
         If (reqSysUserGroup > 41) And (reqSysUserGroup <> 51) And (reqSysUserGroup <> 52) Then
            reqRptType = ""
         End If
      End If
      If (reqRptType = "") Then
         
               response.write "Unauthorized Access"
               response.end

      End If
      
      'The very first time the mode is (0) waiting for the user to select a report 
      'When the user selects a new report, set the mode to (1) to get the report parameters 
      'If the user already selected a report, and the mode is (2+) get the report data
      If reqNewRpt = 1 Then reqMode = 1
      
      LanguageURL = ""
      SourceURL = ""

      'Get Reports Definition XML file
      If Len(reqD) > 0 Then
         tmpReports = reqD
         If reqTest = 1 Then response.write "<BR>Report Definition: " + tmpReports
      Else   
         If reqC = 0 Then
            tmpReports = "Reports.xml"
         Else
            tmpReports = "sections/company/" + CSTR(reqC) + "/Reports.xml"
         End If
         If reqTest = 1 Then response.write "<BR>Report Definition: " + server.MapPath(tmpReports)

         'Check if report definition file exists
         Set oFileSys = CreateObject("Scripting.FileSystemObject")
         Exists = oFileSys.FileExists( server.MapPath(tmpReports) )
         If Not Exists Then
            Response.Write "<BR>Report Definition File Missing! (" + server.MapPath(tmpReports) + ")"
            Response.End
         End If
         Set oFileSys = Nothing
      End If
      
      'Load Reports Definition XML file
      Set oReports = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
      If InStr(LCASE(tmpReports), "http:" ) = 0 Then
         oReports.load server.MapPath(tmpReports)
      Else      
         oReports.setProperty "ServerHTTPRequest", True
         oReports.async = False
         oReports.load tmpReports
      End If   
      If oReports.parseError <> 0 Then
         Response.Write "Error Loading Reports Definition (" + tmpReports + ") (" + CStr(oReports.parseError) + ")"
         Response.End
      End If

      If reqTest = 1 Then response.write "<BR>Report Type: " + reqRptType

      'delete all reports that the user can't access
      For Each oItem In oReports.selectNodes("/REPORTS/REPORT")
         tmpDeleted = false
         With oItem
            'check if the user can access this type of report (member, company, or system)
            tmptype = .getAttribute("type")
            If reqRptType <> tmpType Then
               oItem.parentNode.removeChild(oItem) 
               tmpDeleted = true
            End If
            'check additional access limits for admins and members (non-employees)
            If reqSysUserGroup > 23 Then
               If tmpDeleted = false Then
                  'check if the user can access this security level of report
                  tmpSecure = .getAttribute("secure")
                  If IsNumeric(tmpSecure) Then
                     If CLng(tmpSecure) > reqSecure Then
                        oItem.parentNode.removeChild(oItem)
                        tmpDeleted = true
                     End If    
                  End If    
               End If    
               If tmpDeleted = false Then
                  'check if the user can access this report option
                  tmpOption = .getAttribute("option")
                  If Len(tmpOption) > 0 Then
                     If InStr(reqSysUserOptions,tmpOption) = 0 Then
                        oItem.parentNode.removeChild(oItem) 
                        tmpDeleted = true
                     End If
                  End If
               End If
            End If
         End With
      Next

      'Get URLs for Source and Language
      With oReports.documentElement
         tmpPath = .getAttribute("path")
         tmpLanguage = .getAttribute("language")
         tmpSource = .getAttribute("source")
      End With 

      'Create complete URL path
      If Right(tmpPath,1) <> "/" Then tmpPath = tmpPath + "/"

      'Append language to language URL if not present
      If InStr(LCASE(tmpLanguage), "[") = 0 And InStr(LCASE(tmpLanguage), ".") > 0 Then
         tmpLanguage = Replace(tmpLanguage, ".", "[" + reqSysLanguage + "]." )
      End If 
      'Create complete URL for Language
      LanguageURL = tmpLanguage
      If InStr(LCASE(tmpLanguage), "http:") = 0 Then LanguageURL = tmpPath + tmpLanguage

      If reqTest = 1 Then response.write "<BR>Language: " + LanguageURL

      SourceURL = tmpSource
      If InStr(LCASE(tmpSource), "http:") = 0 Then SourceURL = tmpPath + tmpSource

      If reqTest = 1 Then response.write "<BR>Reports Source: " + SourceURL

      'if a report is selected (mode 1), get the parameters.  if no user parameters set mode to 2
      'if a report is selected and parameters are entered (mode 2+), get the report data
      If reqMode > 0 Then
         'Get selected report element
         Set oReport = oReports.selectSingleNode("/REPORTS/REPORT[@id=" + CSTR(reqRpt) + "]" )
         If Not (oReport Is Nothing) Then
         
            'look for a path and source for the selected report
            rptPath = oReport.getAttribute("path")
            rptSource = oReport.getAttribute("source")
            If Len(rptPath) > 0 Then tmpPath = rptPath
            If Len(rptSource) > 0 Then tmpSource = rptSource
            
            'Create complete URL for Source
            If Right(tmpPath,1) <> "/" Then tmpPath = tmpPath + "/"
            SourceURL = tmpSource
            If InStr(LCASE(tmpSource), "http:") = 0 Then SourceURL = tmpPath + tmpSource

            If reqTest = 1 Then response.write "<BR>Report Source: " + SourceURL

            'Initialize Source URL with report number
            SourceURL = SourceURL + "?r=" + CSTR(reqRpt)
            x = 1
            parms = 0 
            'Walk report parameters to build SourceURL and initialize params
            For Each oItem In oReport.selectNodes("PARAM")
               'Get the user provided value for up to 5 parameters
               Select Case x
                  Case 1: val = reqP1
                  Case 2: val = reqP2
                  Case 3: val = reqP3
                  Case 4: val = reqP4
                  Case 5: val = reqP5
                  Case Else: val = ""
               End Select
               
               'Initialize parameters
               nam = oItem.getAttribute("name")
               typ = oItem.getAttribute("type")
               'Initialize system parameters
               If LCASE(typ) = "system" Then   
                  Select Case LCASE(nam)
                     Case "companyid": val = CSTR(reqC)
                     Case "memberid": val = CSTR(reqM)
                     Case "authuserid": val = CSTR(reqSysUserID)
                     Case "const": val = ""
                     Case "memberref"
                        If reqMR = 0 Then GetMemberReference()
                        val = CSTR(reqMR)
                  End Select   
               Else
                  'count user provided (non-system) parameters
                  parms = parms + 1   
               End If
               'Initilize parameters if empty and if "init" is provided
               If Len(val) = 0 Then
                  init = oItem.getAttribute("init")
                  If Len(init) > 0 Then
                     If typ = "date" And LEFT(init, 3) = "now" Then
                        val = CSTR(Date())
                        init = MID(init, 4)
                        'increment / decrement date if provided in init (now+7)
                        If IsNumeric( init ) Then
                           val = DATEADD("d", init, val)
                        End If
                     Else
                        val = init   
                     End If
                  End If
               End If
               'reassign the initialized value back to the parameter
               Select Case x
                  Case 1: reqP1 = val
                  Case 2: reqP2 = val
                  Case 3: reqP3 = val
                  Case 4: reqP4 = val
                  Case 5: reqP5 = val
               End Select
               SourceURL = SourceURL + "&" + CSTR(x) + "=" + val
               x = x + 1
               
               'if we getting report data (mode 2+), validate the parameters
               If reqMode >= 2 Then
                  req = oItem.getAttribute("required")
                  If req > 0 Then
                     If Len(val) = 0 Then
                        reqMode = 1  'reset mode to get parameters
                        DoError -2147220490, "", "Oops, entry is required for {" + nam + "}"
                     End If
                  End If
               End If
            Next
            'If there are no user provided parameters, get report data (mode 2)
            If parms = 0 Then reqMode = 2
         End If

         If reqMode >= 2 Then
            If reqTest = 1 Then response.write "<BR>Data Source: " + SourceURL
            
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", SourceURL
               oHTTP.send
               xmlReport = oHTTP.responseXML.xml
            End If
            Set oHTTP = Nothing
            
            'Check for an error from the Data Source
            If InStr(xmlReport, "<ERROR>") > 0 Then
               'strip error tags for output
               xmlReport = Replace (xmlReport, "<ERROR>", "")
               xmlReport = Replace (xmlReport, "</ERROR>", "")
               Response.Write xmlReport
               Response.End
            End If
            
               'check for a file
              tmpFile = oReport.getAttribute("file")
            
            'check for a chart
            tmpChart = oReport.getAttribute("chart")
         
            'check for a chart
            tmpChart = oReport.getAttribute("chart")
            
            'Get data count and report totals               
            Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
            oData.loadXML xmlReport

            'get total rows in data
            Set oRows = oData.selectNodes("/REPORT/DATA") 
            reqCount = oRows.length
            
            'calculate each report total
            For Each oItem In oReport.selectNodes("TOTAL")
            typ = oItem.getAttribute("type")
            Select Case LCASE(typ)
               Case "count"
                  oItem.setAttribute("value") = reqCount
               Case "sum", "avg"
                  total = 0
                  If Len(tmpChart) > 0 Then
                     total = 0
                     For Each oRow In oRows
                     val = oRow.text
                     If IsNumeric(val) Then total = total + CLng(val)
                     Next
                     oItem.setAttribute("value") = total
                  Else
                     fld = oItem.getAttribute("name")
                     total = 0.0
                     For Each oRow In oRows
                        val = oRow.getAttribute(fld)
                        If IsNumeric(val) Then 
                        total = total + CCUR(val)
                        End If   
                     Next
                     'calculate average
                     If LCASE(typ) = "avg" Then total = (total / reqCount)
                           
                     'format total with decimal precision
                     fmt = oItem.getAttribute("format")
                     dec = oItem.getAttribute("decimal")
                     If IsNull(dec) Then dec = 0
                     Select Case fmt
                        Case "number"
                           oItem.setAttribute("value") = FormatNumber(total,dec)
                        Case "currency"
                           oItem.setAttribute("value") = FormatCurrency(total,dec)
                        Case Else   
                           oItem.setAttribute("value") = FormatNumber(total,0)
                     End Select      
                  End If
            End Select   
            Next

            'format data
            'check how many columns need formatting
            Set oFmts = oReport.selectNodes("COLUMN[@format]") 
            Fmts = oFmts.length
            Set oFmts = Nothing
            'if any columns need formatting
            If Fmts > 0 Then
               'walk through all the rows of data
               For Each oRow In oRows
                  'get each formatted column
                  For Each oItem In oReport.selectNodes("COLUMN[@format]")
                     fld = oItem.getAttribute("name")
                     fmt = oItem.getAttribute("format")
                     dec = oItem.getAttribute("decimal")
                     If IsNull(dec) Then dec = 0
                     style = oItem.getAttribute("style")
                     If IsNull(style) Then style = 0
                     'get the data from the current row for the selected column
                     val = oRow.getAttribute(fld)
                     'format data
                     Select Case fmt
                     Case "number"
                        oRow.setAttribute(fld) = FormatNumber(val,dec)
                     Case "currency"
                        oRow.setAttribute(fld) = FormatCurrency(val,dec)
                     Case "date"
                        oRow.setAttribute(fld) = FormatDateTime(val,style)
                     Case "percent"
                        oRow.setAttribute(fld) = FormatPercent(val,dec)
                     End Select
                  Next
               Next
               xmlReport = oData.xml
            End If

            'Save file
            If Len(tmpFile) > 0 And reqCount > 0 Then
               'get full filename
               tmpFilename = "sections/company/" + CSTR(reqC) + "/" + oReport.getAttribute("name") + "." + tmpFile 
               Filename = server.MapPath( tmpFilename )
               reqFile = "http://" + reqSysServerName + reqSysServerPath + tmpFilename

               If reqTest = 1 Then response.write "<BR>Filename: " + Filename

               Set oFileSys = CreateObject("Scripting.FileSystemObject")
               If oFileSys Is Nothing Then
                  Response.Write "Scripting.FileSystemObject failed to load"
                  Response.End
               End If
               Set oFile = oFileSys.CreateTextFile(Filename, True)
               If oFile Is Nothing Then
                  Response.Write "Couldn't create file: " + Filename
                  Response.End
               End If

               'create file header
               rec = ""
               For Each oItem In oReport.selectNodes("COLUMN")
                  fld = oItem.getAttribute("name")
                  rec = rec + """" + fld + """" + ","
               Next
               rec = Left(rec, len(rec)-1)
               oFile.WriteLine( Rec )

               'walk through all the rows of data
               For Each oRow In oRows
                  rec = ""
                  For Each oItem In oReport.selectNodes("COLUMN")
                     fld = oItem.getAttribute("name")
                     val = oRow.getAttribute(fld)
                     rec = rec + """" + val + """" + ","
                  Next
                  rec = Left(rec, len(rec)-1)
                  oFile.WriteLine( Rec )
               Next
               oFile.Close
               Set oFile = Nothing
               Set oFileSys = Nothing
            End If

            Set oRows = Nothing
            Set oData = Nothing

            'Process chart
            If Len(tmpChart) > 0 Then
               'Initialize chart values
               tmpHeight = 400
               tmpWidth = 750
               tmpLanguage = ""
               tmpTitle = ""
               tmpXTitle = ""
               tmpYTitle = ""

               'check for chart values defined by report
               If NOT IsNull(oReport.getAttribute("height")) Then tmpHeight = oReport.getAttribute("height")
               If NOT IsNull(oReport.getAttribute("width")) Then tmpWidth = oReport.getAttribute("width")
               If NOT IsNull(oReport.getAttribute("translate")) Then tmpLanguage = LanguageURL
               If NOT IsNull(oReport.getAttribute("title")) Then tmpTitle = oReport.getAttribute("title")
               If NOT IsNull(oReport.getAttribute("xtitle")) Then tmpXTitle = oReport.getAttribute("xtitle")
               If NOT IsNull(oReport.getAttribute("ytitle")) Then tmpYTitle = oReport.getAttribute("ytitle")

               'Convert Report Data to data and labels lists
               tmpData = ""
               tmpLabels = ""
               Set oReport = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
               oReport.loadXML xmlReport
               If oReport.parseError <> 0 Then
                  Response.Write "Load Report file failed with error code " + CStr(oLanguage.parseError)
                  Response.End
               End If
               Set oItems = oReport.selectNodes("REPORT/DATA")
               For Each oItem In oItems
                  With oItem
                     tmpLabels = tmpLabels + .getAttribute("label") + "|"
                     tmpData = tmpData + .Text + "|"
                  End With
               Next      
               Set oItems = Nothing
               Set oReport = Nothing

               'Remove last | delimiter
               If tmpData <> "" And Right(tmpData,1) = "|" Then tmpData = Left(tmpData, Len(tmpData)-1 )
               If tmpLabels <> "" And Right(tmpLabels,1) = "|" Then tmpLabels = Left(tmpLabels, Len(tmpLabels)-1 )

               If tmpLanguage <> "" Then ChartLabels tmpLanguage, tmpLabels, "", tmpTitle, tmpXTitle, tmpYTitle
               reqChartSource = "Chart.asp?type=" + tmpChart + "&width=" & tmpWidth & "&height=" & tmpHeight & "&data=" + tmpData + "&labels=" + tmpLabels + "&title=" + tmpTitle + "&xtitle=" + tmpXTitle + "&ytitle=" + tmpYTitle

               'we don't need the report data anymore for this chart
               xmlReport = ""

               If reqTest = 1 Then response.write "<BR>Chart Source: " + reqChartSource
            End If
         End If
      End If
      'save reports definition
      xmlReports = oReports.xml

      'validate reports definition   
      If reqTest = 2 Then
         '-----create a DOM object for the XSL
         xslPage = "ReportsValidate.xsl"
         Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
         oStyle.load server.MapPath(xslPage)
         If oStyle.parseError <> 0 Then
            Response.Write "Reports Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
            Response.End
         End If

         '-----create a DOM object for the Language
         Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
         oLanguage.setProperty "ServerHTTPRequest", True
         oLanguage.async = False
         oLanguage.load LanguageURL
         If oLanguage.parseError <> 0 Then
            Response.Write "Reports Load file (" + LanguageURL + ") failed with error code " + CStr(oLanguage.parseError)
            Response.End
         End If
         oLanguage.removeChild oLanguage.firstChild
         xmlLanguage = oLanguage.XML
         Set oLanguage = Nothing

         xmlValid = "<VALID>" + xmlReports + xmlLanguage + "</VALID>"  

         '-----create a DOM object for the XML
         Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
         oData.loadXML xmlValid
         If oData.parseError <> 0 Then
            Response.Write "Reports Load file (oData) failed with error code " + CStr(oData.parseError)
            Response.Write "" + xmlValid
            Response.End
         End If

         Response.Write "<BR>Validating Report Definition...<BR>"
         '-----transform the XML with the XSL
         valid = oData.transformNode(oStyle)
         Response.Write Replace( valid, "NEWLINE", "<BR>")
         Response.Write "...End of Validation<BR>"
         
         Set oData = Nothing
         Set oStyle = Nothing
      End If

      'initialize new-report-selected flag to false
      reqNewRpt = 0
      Set oReport = Nothing
      Set oReports = Nothing

End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " d=" + Chr(34) + CleanXML(reqD) + Chr(34)
xmlParam = xmlParam + " mr=" + Chr(34) + CStr(reqMR) + Chr(34)
xmlParam = xmlParam + " rpt=" + Chr(34) + CStr(reqRpt) + Chr(34)
xmlParam = xmlParam + " p1=" + Chr(34) + CleanXML(reqP1) + Chr(34)
xmlParam = xmlParam + " p2=" + Chr(34) + CleanXML(reqP2) + Chr(34)
xmlParam = xmlParam + " p3=" + Chr(34) + CleanXML(reqP3) + Chr(34)
xmlParam = xmlParam + " p4=" + Chr(34) + CleanXML(reqP4) + Chr(34)
xmlParam = xmlParam + " p5=" + Chr(34) + CleanXML(reqP5) + Chr(34)
xmlParam = xmlParam + " username=" + Chr(34) + CleanXML(reqUserName) + Chr(34)
xmlParam = xmlParam + " rpttype=" + Chr(34) + CleanXML(reqRptType) + Chr(34)
xmlParam = xmlParam + " newrpt=" + Chr(34) + CStr(reqNewRpt) + Chr(34)
xmlParam = xmlParam + " mode=" + Chr(34) + CStr(reqMode) + Chr(34)
xmlParam = xmlParam + " secure=" + Chr(34) + CStr(reqSecure) + Chr(34)
xmlParam = xmlParam + " chartsource=" + Chr(34) + CleanXML(reqChartSource) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " test=" + Chr(34) + CStr(reqTest) + Chr(34)
xmlParam = xmlParam + " date=" + Chr(34) + CleanXML(reqDate) + Chr(34)
xmlParam = xmlParam + " file=" + Chr(34) + CleanXML(reqFile) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlReports
xmlTransaction = xmlTransaction +  xmlReport
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.setProperty "ServerHTTPRequest", True
oLanguage.async = False
oLanguage.load LanguageURL
If oLanguage.parseError <> 0 Then
   Response.Write "Reports Load file (" + LanguageURL + ") failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild

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
   Response.Write "Reports Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the data XML
xmlData = "<DATA>"
xmlData = xmlData +  xmlTransaction
xmlData = xmlData +  xmlHead
xmlData = xmlData +  xmlParam
xmlData = xmlData +  xmlLanguage
xmlData = xmlData +  xmlError
xmlData = xmlData +  xmlErrorLabels
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "Reports.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "Reports Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "Reports Load file (oData) failed with error code " + CStr(oData.parseError)
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
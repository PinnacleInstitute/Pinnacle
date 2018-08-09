<!-- #include file="ChartLib.asp" -->
<%
'****************************************************************************************************
'  Lookup chart labels in language file
'****************************************************************************************************
Function ChartLabels(ByVal bvLang, ByRef brLabels, ByRef brLegend, ByRef brTitle, ByRef brXTitle, ByRef brYTitle )

On Error Resume Next

Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
fileLanguage = "Language\" + bvLang + "[" + reqSysLanguage + "].xml"
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
    Response.Write bvLang + " Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
    Response.End
End If
If brLabels <> "" Then
    tmpLabels = Split(brLabels, "|")
    tmp = ""
	For x = LBound(tmpLabels) To UBound(tmpLabels)
        Set oItem = oLanguage.selectSingleNode("LANGUAGE/LABEL[@name='" + tmpLabels(x) + "']")
        If tmp <> "" Then tmp = tmp + "|"
        If Not (oItem Is Nothing) Then tmp = tmp + oItem.Text Else tmp = tmp + tmpLabels(x)
        Set oItem = Nothing
	Next
    brLabels = tmp
End If
If brLegend <> "" Then
    tmpLegend = Split(brLegend, "|")
    tmp = ""
	For x = LBound(tmpLegend) To UBound(tmpLegend)
        Set oItem = oLanguage.selectSingleNode("LANGUAGE/LABEL[@name='" + tmpLegend(x) + "']")
        If tmp <> "" Then tmp = tmp + "|"
        If Not (oItem Is Nothing) Then tmp = tmp + oItem.Text Else tmp = tmp + tmpLegend(x)
        Set oItem = Nothing
	Next
    brLegend = tmp
End If
If brTitle <> "" Then
    Set oItem = oLanguage.selectSingleNode("LANGUAGE/LABEL[@name='" + brTitle + "']")
    If Not (oItem Is Nothing) Then brTitle = oItem.Text
    Set oItem = Nothing
End If
If brXTitle <> "" Then
    Set oItem = oLanguage.selectSingleNode("LANGUAGE/LABEL[@name='" + brXTitle + "']")
    If Not (oItem Is Nothing) Then brXTitle = oItem.Text
    Set oItem = Nothing
End If
If brYTitle <> "" Then
    Set oItem = oLanguage.selectSingleNode("LANGUAGE/LABEL[@name='" + brYTitle + "']")
    If Not (oItem Is Nothing) Then brYTitle = oItem.Text
    Set oItem = Nothing
End If

Set oLanguage = Nothing

End Function

'****************************************************************************************************
Function ChartURL(ByVal bvType, ByVal bvWidth, ByVal bvHeight, ByVal bvStartDate, ByVal bvEndDate, ByVal bvUnit, ByVal bvLang, ByVal bvData, ByVal bvTitle, ByVal bvXTitle, ByVal bvYTitle )

On Error Resume Next

	' Load the xsl stylesheet
	xslPage = "ChartURL.xsl"
	Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
	oStyle.load server.MapPath(xslPage)
	If oStyle.parseError <> 0 Then
		Response.Write "Chart Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
		Response.End
	End If

	'-----get the language XML
	xmlLabels = ""
	If bvLang <> "" Then
		Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
		If InStr(LCASE(bvLang), "http:" ) = 0 Then
			fileLanguage = "Language\" + bvLang + "[" + reqSysLanguage + "].xml"
			oLanguage.load server.MapPath(fileLanguage)
		Else		
			oLanguage.setProperty "ServerHTTPRequest", True
			oLanguage.async = False
			oLanguage.load bvLang
		End If	
		If oLanguage.parseError <> 0 Then
			Response.Write bvLang + " Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
			Response.End
		End If
		Set oLabels = oLanguage.selectNodes("LANGUAGE/LABEL")
		For Each oLabel In oLabels
			xmlLabels = xmlLabels + "<LABEL name=""" & oLabel.getAttribute("name") & """>" & oLabel.Text & "</LABEL>"
		Next
		Set oLabels = Nothing
		Set oLanguage = Nothing
	End If
	xmlData = "<?xml version='1.0' encoding='windows-1252'?>"
	xmlData = xmlData + "<CHART type=""" & bvType & """ width=""" & bvWidth & """ height=""" & bvHeight
	If bvTitle <> "" Then xmlData = xmlData + """ title=""" & bvTitle
	If bvXTitle <> "" Then xmlData = xmlData + """ xtitle=""" & bvXTitle
	If bvYTitle <> "" Then xmlData = xmlData + """ ytitle=""" & bvYTitle
	xmlData = xmlData + """ startdate=""" & bvStartDate & """ enddate=""" & bvEndDate & """ unit=""" & bvUnit & """>"
	xmlData = xmlData + bvChart + bvData + xmlLabels + "</CHART>"

	'-----create a DOM object for the XML
	Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
	oData.loadXML xmlData
	'TEST oData.load server.MapPath("ChartData.xml")
	If oData.parseError <> 0 Then
		Response.Write "Chart Load file (oData) failed with error code " + CStr(oData.parseError)
		Response.End
	End If

	ChartURL = oData.transformNode(oStyle)
	ChartURL = Replace( ChartURL, "amp;", "" )
		            
	Set oData = Nothing
	Set oStyle = Nothing
End Function

'this is a workaround until an alternative xsl page is built to transform the language stuff
'****************************************************************************************************
Function ChartImageMap(	ByVal bvType, _
						ByVal bvWidth, _
						ByVal bvHeight, _
						ByVal bvStartDate, _
						ByVal bvEndDate, _
						ByVal bvUnit, _
						ByVal bvData, _
						ByVal bvLabels, _
						ByVal bvTitle, _
						ByVal bvXTitle, _
						ByVal bvYTitle, _
						ByVal bvExtraField, _
						ByRef brImageMap, _
						ByVal bvImageMapURL )
	On Error Resume Next
	
'	Dim url, params
	
'	url = Split(ChartURL(bvType, bvWidth, bvHeight, bvStartDate, bvEndDate, bvUnit, bvLang, bvData, bvTitle, bvXTitle, bvYTitle ), "?")

'	params = Split(url(UBound(url)), "&")
		
	Dim tmpData, tmpData2, tmpData3, tmpLegend, tmpLabels, tmpXTitle, tmpYTitle, tmpTitle, tmpUnit

'	tmpData = bvData
	tmpData = Split(bvData, "|")
	tmpLabels = Split(bvLabels, "|")
	tmpData2 = Array()
	tmpData3 = Array()
	tmpLegend = Array()
	tmpXTitle = bvXTitle
	tmpYTitle = bvYTitle
	tmpTitle = bvTitle
	tmpUnit = bvUnit
		
'	For Each item In params
'		param = Split(item, "=")
'		name = param(LBound(param))
'		value = param(UBound(param))
'		
'		Select Case name
'		Case "data":
'			tmpData = Split(value, "|")
'		Case "labels":	
'			tmpLabels = Split(value, "|")
'		Case "xtitle":
'			tmpXTitle = value
'		Case "ytitle":
'			tmpYTitle = value
'		Case "title":
'			tmpTitle = value
'		Case "unit":
'			tmpUnit = value
'		End Select
'	Next
			
	If tmpUnit <> "" Then
		'Initialize the x axis title if its blank
		If tmpXTitle = "" Then
			If tmpUnit = "week" Then
				tmpXTitle = "Week of:"
			Else
				tmpXTitle = tmpUnit
			End If
		End If

		'initialize the unit settings
		GroupByDateUnit tmpLabels, tmpData, tmpUnit, bvStartDate, bvEndDate
	End If
		
	'Space the labels out (as in one label every x items) to prevent
	'the labels from overlapping - this loses data and there may be a 
	'better way to do this, such as using multiple rows to display labels
	SpaceLabels tmpLabels, (bvWidth*0.90)

	'if no chart height was specified, estimate it
	Dim dataSize
	dataSize = UBound(tmpData) - LBound(tmpData)
	If bvHeight = 0 Then
		bvHeight = (dataSize * 20)
	End If
			
	Dim chart, filename, html					
	'create the chart object and initialize it	

	Set chart = CreateChart(tmpData, tmpData2, tmpData3, tmpLegend, tmpLabels, bvType, bvWidth, bvHeight, tmpTitle, tmpXTitle, tmpYTitle) 
	
	Call chart.addExtraField(bvExtraField)
	
	filename = chart.makeTmpFile(Server.MapPath("Images/charts"))

	brImageMap = chart.getHTMLImageMap(bvImageMapURL,"IDField={field0}", "onclick=""w=window.open(this.href,this.target);if (window.focus) {w.focus();};return false;"" target=ReportDetail")
	
'	onclick="w=window.open(this.href,this.target);if (window.focus) {w.focus();};return false;"
	
	'html = "<IMG src=""include/charts/" & filename & """ usemap=""#map1"">"
	'html = html & "<map name=map1>" & chart.getHTMLImageMap("0461.asp","ID={field0}") & "</map>"
		
	Set chart = Nothing
	
	ChartImageMap = filename
End Function
%>


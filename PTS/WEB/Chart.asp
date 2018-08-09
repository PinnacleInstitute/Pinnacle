<!--#include file="include/ChartLib.asp" -->
<% 
'declare input parameters

'The Chart data, separated by a vertical bar "|"
Dim reqChartData
Dim reqChartData2
Dim reqChartData3
Dim reqChartLegend

'The Chart labels (or x data, or dates), separated by a vertical bar "|"
Dim reqChartLabels

'The Chart Type, currently supports:
' "bar": a vertical bar chart
' "hbar": a horizontal bar chart
' "line": a line graph (default)
' "pie": a pie chart
' "area": an area graph (filled in under the line)
Dim reqChartType

'The Chart Unit, if the labels represent dates
'accepted values are:
' "Day"
' "Week"
' "Month"
' "Quarter"
' "Year"
Dim reqChartUnit

'Specifies the total dimensions of the image to return (default is 600x400)
Dim reqChartWidth
Dim reqChartHeight

'Specifies the total date range to display.  If not provided,
'the dates are assumed to be the max and min date provided
'in the label array
Dim reqStartDate
Dim reqEndDate

'The titles for the X and Y axis on the chart (blank for none)
Dim reqXTitle
Dim reqYTitle

'The title for the chart
Dim reqChartTitle

'Arrays for storing and manipulating the data and labels
Dim data
Dim labels

'ChartDirector ActiveX chart object
Dim chart

'pull parameters from request
reqStartDate = Request.Item("StartDate")
If (IsDate(reqStartDate)) Then reqStartDate = CDate(reqStartDate) Else reqStartDate = Date()
reqEndDate = Request.Item("EndDate")
If (IsDate(reqEndDate)) Then reqEndDate = CDate(reqEndDate) Else reqEndDate = Date()
reqChartUnit = LCase(Request.Item("Unit"))
reqChartData = Request.Item("Data")
reqChartData2 = Request.Item("Data2")
reqChartData3 = Request.Item("Data3")
reqChartLegend = Request.Item("Legend")
reqChartLabels = Request.Item("Labels")
reqXTitle = Request.Item("XTitle")
reqYTitle = Request.Item("YTitle")
reqChartTitle = Request.Item("Title")
reqChartType = LCase(Request.Item("Type"))
reqChartWidth = Request.Item("Width")
If (IsNumeric(reqChartWidth)) Then reqChartWidth = CLng(reqChartWidth) Else reqChartWidth = CLng(600)
reqChartHeight = Request.Item("Height")
If (IsNumeric(reqChartHeight)) Then reqChartHeight = CLng(reqChartHeight) Else reqChartHeight = CLng(0)

data = Split(reqChartData,"|")
data2 = Split(reqChartData2,"|")
data3 = Split(reqChartData3,"|")
legend = Split(reqChartLegend,"|")
labels = Split(reqChartLabels,"|")

If reqChartUnit <> "" Then
	'Initialize the x axis title if its blank
	If reqXTitle = "" Then
		If reqChartUnit = "week" Then
			reqXTitle = "Week of:"
		Else
			reqXTitle = reqChartUnit
		End If
	End If

	'initialize the unit settings
	GroupByDateUnit labels, data, reqChartUnit, reqStartDate, reqEndDate
End If

'Space the labels out (as in one label every x items) to prevent
'the labels from overlapping - this loses data and there may be a 
'better way to do this, such as using multiple rows to display labels
SpaceLabels labels, (reqChartWidth*0.90)

'if no chart height was specified, estimate it
Dim dataSize
dataSize = UBound(data) - LBound(data)
If reqChartHeight = 0 Then
	reqChartHeight = (dataSize * 20)
End If
						
'create the chart object and initialize it		
Set chart = CreateChart(data, data2, data3, legend, labels, reqChartType, reqChartWidth, reqChartHeight, reqChartTitle, reqXTitle, reqYTitle) 

'output the chart in PNG format

Response.ContentType = "image/png"
Response.BinaryWrite chart.makeChart2(0)
Response.End

Set chart = nothing
%>  
<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

bargap = CInt(Request("img")) * 0.25 - 0.25

'The data for the bar chart
data = Array(100, 125, 245, 147, 67)

'The labels for the bar chart
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 150 x 150 pixels
Set c = cd.XYChart(150, 150)

'Set the plotarea at (27, 20) and of size 120 x 100 pixels
Call c.setPlotArea(27, 20, 120, 100)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

If bargap >= 0 Then
    'Add a title to display to bar gap using 8 pts Arial font
    Call c.addTitle("      Bar Gap = " & bargap, "arial.ttf", 8)
Else
    'Use negative value to mean TouchBar
    Call c.addTitle("      Bar Gap = TouchBar", "arial.ttf", 8)
    bargap = cd.TouchBar
End If

'Add a bar chart layer using the given data and set the bar gap
Call c.addBarLayer(data).setBarGap(bargap)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

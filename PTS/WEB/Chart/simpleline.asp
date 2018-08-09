<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the line chart
data = Array(30, 28, 40, 55, 75, 68, 54, 60, 50, 62, 75, 65, 75, 91, 60, 55, _
    53, 35, 50, 66, 56, 48, 52, 65, 62)

'The labels for the line chart
labels = Array("0", "", "", "3", "", "", "6", "", "", "9", "", "", "12", "", _
    "", "15", "", "", "18", "", "", "21", "", "", "24")

'Create a XYChart object of size 250 x 250 pixels
Set c = cd.XYChart(250, 250)

'Set the plotarea at (30, 20) and of size 200 x 200 pixels
Call c.setPlotArea(30, 20, 200, 200)

'Add a line chart layer using the given data
Call c.addLineLayer(data)

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

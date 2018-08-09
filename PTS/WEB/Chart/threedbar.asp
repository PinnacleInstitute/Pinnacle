<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data = Array(85, 156, 179.5, 211, 123)

'The labels for the bar chart
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 300 x 280 pixels
Set c = cd.XYChart(300, 280)

'Set the plotarea at (45, 30) and of size 200 x 200 pixels
Call c.setPlotArea(45, 30, 200, 200)

'Add a title to the chart
Call c.addTitle("Weekly Server Load")

'Add a title to the y axis
Call c.yAxis().setTitle("MBytes")

'Add a title to the x axis
Call c.xAxis().setTitle("Work Week 25")

'Add a bar chart layer with green (0x00ff00) bars using the given data
Call c.addBarLayer(data, &Hff00).set3D()

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

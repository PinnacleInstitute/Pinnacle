<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data = Array(85, 156, 179.5, 211, 123)

'The labels for the bar chart
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 250 x 250 pixels
Set c = cd.XYChart(250, 250)

'Set the plotarea at (30, 20) and of size 200 x 200 pixels
Call c.setPlotArea(30, 20, 200, 200)

'Add a bar chart layer using the given data
Call c.addBarLayer(data)

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

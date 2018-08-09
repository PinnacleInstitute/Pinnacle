<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(90, 60, 65, 75, 40)

'The labels for the chart
labels = Array("Speed", "Reliability", "Comfort", "Safety", "Efficiency")

'Create a PolarChart object of size 450 x 350 pixels
Set c = cd.PolarChart(450, 350)

'Set center of plot area at (225, 185) with radius 150 pixels
Call c.setPlotArea(225, 185, 150)

'Add an area layer to the polar chart
Call c.addAreaLayer(data, &H9999ff)

'Set the labels to the angular axis as spokes
Call c.angularAxis().setLabels(labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

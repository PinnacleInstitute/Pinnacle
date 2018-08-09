<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the area chart
data0 = Array(42, 49, 33, 38, 51, 46, 29, 41, 44, 57, 59, 52, 37, 34, 51, 56, _
    56, 60, 70, 76, 63, 67, 75, 64, 51)
data1 = Array(50, 55, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84, 89)
data2 = Array(87, 89, 85, 66, 53, 39, 24, 21, 37, 56, 37, 22, 21, 33, 13, 17, _
    4, 23, 16, 25, 9, 10, 5, 7, 6)
labels = Array("0", "-", "2", "-", "4", "-", "6", "-", "8", "-", "10", "-", _
    "12", "-", "14", "-", "16", "-", "18", "-", "20", "-", "22", "-", "24")

'Create a XYChart object of size 350 x 230 pixels
Set c = cd.XYChart(350, 230)

'Set the plotarea at (50, 30) and of size 250 x 150 pixels.
Call c.setPlotArea(50, 30, 250, 150)

'Add a legend box at (55, 0) (top of the chart) using 8 pts Arial Font. Set
'background and border to Transparent.
Call c.addLegend(55, 0, False, "", 8).setBackground(cd.Transparent)

'Add a title to the x axis
Call c.xAxis().setTitle("Network Load for Jun 12")

'Add a title to the y axis
Call c.yAxis().setTitle("MBytes")

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add three area layers, each representing one data set. The areas are drawn in
'semi-transparent colors.
Call c.addAreaLayer(data2, &H808080ff, "Server #1", 3)
Call c.addAreaLayer(data0, &H80ff0000, "Server #2", 3)
Call c.addAreaLayer(data1, &H8000ff00, "Server #3", 3)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

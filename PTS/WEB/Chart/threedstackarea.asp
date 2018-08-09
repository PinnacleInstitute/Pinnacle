<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the area chart
data0 = Array(42, 49, 33, 38, 51, 46, 29, 41, 44, 57, 59, 52, 37, 34, 51, 56, _
    56, 60, 70, 76, 63, 67, 75, 64, 51)
data1 = Array(50, 45, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84, 89)
data2 = Array(61, 79, 85, 66, 53, 39, 24, 21, 37, 56, 37, 22, 21, 33, 13, 17, _
    4, 23, 16, 25, 9, 10, 5, 7, 16)
labels = Array("0", "-", "2", "-", "4", "-", "6", "-", "8", "-", "10", "-", _
    "12", "-", "14", "-", "16", "-", "18", "-", "20", "-", "22", "-", "24")

'Create a XYChart object of size 500 x 300 pixels
Set c = cd.XYChart(500, 300)

'Set the plotarea at (90, 30) and of size 300 x 240 pixels.
Call c.setPlotArea(90, 30, 300, 240)

'Add a legend box at (405, 100)
Call c.addLegend(405, 100)

'Add a title to the chart
Call c.addTitle("Daily System Load")

'Add a title to the y axis. Draw the title upright (font angle = 0)
Call c.yAxis().setTitle("Database<*br*>Queries<*br*>(per sec)").setFontAngle(0)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add an area layer
Set layer = c.addAreaLayer()

'Draw the area layer in 3D
Call layer.set3D()

'Add the three data sets to the area layer
Call layer.addDataSet(data0, -1, "Server # 1")
Call layer.addDataSet(data1, -1, "Server # 2")
Call layer.addDataSet(data2, -1, "Server # 3")

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

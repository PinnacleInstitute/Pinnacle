<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data0 = Array(100, 125, 245, 147, 67)
data1 = Array(85, 156, 179, 211, 123)
data2 = Array(97, 87, 56, 267, 157)

'The labels for the bar chart
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 500 x 320 pixels
Set c = cd.XYChart(500, 320)

'Set the plotarea at (100, 40) and of size 280 x 240 pixels
Call c.setPlotArea(100, 40, 280, 240)

'Add a legend box at (405, 100)
Call c.addLegend(405, 100)

'Add a title to the chart
Call c.addTitle("Weekday Network Load")

'Add a title to the y axis. Draw the title upright (font angle = 0)
Call c.yAxis().setTitle("Average<*br*>Workload<*br*>(MBytes<*br*>Per Hour)" _
    ).setFontAngle(0)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add three bar layers, each representing one data set. The bars are drawn in
'semi-transparent colors.
Call c.addBarLayer(data0, &H808080ff, "Server # 1", 5)
Call c.addBarLayer(data1, &H80ff0000, "Server # 2", 5)
Call c.addBarLayer(data2, &H8000ff00, "Server # 3", 5)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

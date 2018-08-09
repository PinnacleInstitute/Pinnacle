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

'Add a legend box at (400, 100)
Call c.addLegend(400, 100)

'Add a title to the chart using 14 points Times Bold Itatic font
Call c.addTitle("Weekday Network Load", "timesbi.ttf", 14)

'Add a title to the y axis. Draw the title upright (font angle = 0)
Call c.yAxis().setTitle("Average<*br*>Workload<*br*>(MBytes<*br*>Per Hour)" _
    ).setFontAngle(0)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a stacked bar layer and set the layer 3D depth to 8 pixels
Set layer = c.addBarLayer2(cd.Stack, 8)

'Add the three data sets to the bar layer
Call layer.addDataSet(data0, &Hff8080, "Server # 1")
Call layer.addDataSet(data1, &H80ff80, "Server # 2")
Call layer.addDataSet(data2, &H8080ff, "Server # 3")

'Enable bar label for the whole bar
Call layer.setAggregateLabelStyle()

'Enable bar label for each segment of the stacked bar
Call layer.setDataLabelStyle()

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data0 = Array(100, 125, 245, 147, 67)
data1 = Array(85, 156, 179, 211, 123)
data2 = Array(97, 87, 56, 267, 157)
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 300 x 240 pixels
Set c = cd.XYChart(300, 240)

'Add a title to the chart using 10 pt Arial font
Call c.addTitle("         Average Weekday Network Load", "", 10)

'Set the plot area at (45, 25) and of size 239 x 180. Use two alternative
'background colors (0xffffc0 and 0xffffe0)
Call c.setPlotArea(45, 25, 239, 180).setBackground(&Hffffc0, &Hffffe0)

'Add a legend box at (45, 20) using horizontal layout. Use 8 pt Arial font, with
'transparent background
Call c.addLegend(45, 20, False, "", 8).setBackground(cd.Transparent)

'Add a title to the y-axis
Call c.yAxis().setTitle("Throughput (MBytes Per Hour)")

'Reserve 20 pixels at the top of the y-axis for the legend box
Call c.yAxis().setTopMargin(20)

'Set the x axis labels
Call c.xAxis().setLabels(labels)

'Add a multi-bar layer with 3 data sets
Set layer = c.addBarLayer2(cd.Side, 3)
Call layer.addDataSet(data0, &Hff8080, "Server #1")
Call layer.addDataSet(data1, &H80ff80, "Server #2")
Call layer.addDataSet(data2, &H8080ff, "Server #3")

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(42, 49, 33, 38, 51, 46, 29, 41, 44, 57, 59, 52, 37, 34, 51, 56, _
    56, 60, 70, 76, 63, 67, 75, 64, 51)
data1 = Array(50, 55, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84, 98)

'The labels for the bottom x axis. Note the "-" means a minor tick.
label0 = Array("0<*br*>Jun 4", "-", "-", "3", "-", "-", "6", "-", "-", "9", _
    "-", "-", "12", "-", "-", "15", "-", "-", "18", "-", "-", "21", "-", "-", _
    "0<*br*>Jun 5")

'The labels for the top x axis. Note that "-" means a minor tick.
label1 = Array("Jun 3<*br*>12", "-", "-", "15", "-", "-", "18", "-", "-", _
    "21", "-", "-", "Jun 4<*br*>0", "-", "-", "3", "-", "-", "6", "-", "-", _
    "9", "-", "-", "12")

'Create a XYChart object of size 310 x 310 pixels
Set c = cd.XYChart(310, 310)

'Set the plotarea at (50, 50) and of size 200 x 200 pixels
Call c.setPlotArea(50, 50, 200, 200)

'Add a title to the primary (left) y axis
Call c.yAxis().setTitle("US Dollars")

'Set the tick length to -4 pixels (-ve means ticks inside the plot area)
Call c.yAxis().setTickLength(-4)

'Add a title to the secondary (right) y axis
Call c.yAxis2().setTitle("HK Dollars (1 USD = 7.8 HKD)")

'Set the tick length to -4 pixels (-ve means ticks inside the plot area)
Call c.yAxis2().setTickLength(-4)

'Synchronize the y-axis such that y2 = 7.8 x y1
Call c.syncYAxis(7.8)

'Add a title to the bottom x axis
Call c.xAxis().setTitle("Hong Kong Time")

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(label0)

'Set the major tick length to -4 pixels and minor tick length to -2 pixels (-ve
'means ticks inside the plot area)
Call c.xAxis().setTickLength2(-4, -2)

'Set the distance between the axis labels and the axis to 6 pixels
Call c.xAxis().setLabelGap(6)

'Add a title to the top x-axis
Call c.xAxis2().setTitle("New York Time")

'Set the x-axis labels using the given labels
Call c.xAxis2().setLabels(label1)

'Set the major tick length to -4 pixels and minor tick length to -2 pixels (-ve
'means ticks inside the plot area)
Call c.xAxis2().setTickLength2(-4, -2)

'Set the distance between the axis labels and the axis to 6 pixels
Call c.xAxis2().setLabelGap(6)

'Add a line layer to the chart with a line width of 2 pixels
Call c.addLineLayer(data0, -1, "Server Load").setLineWidth(2)

'Add an area layer to the chart with no area boundary line
Call c.addAreaLayer(data1, -1, "Transaction").setLineWidth(0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

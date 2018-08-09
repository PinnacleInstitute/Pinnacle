<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(0.05, 0.06, 0.48, 0.1, 0.01, 0.05)
data1 = Array(100, 125, 265, 147, 67, 105)
labels = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun")

'Create a XYChart object of size 300 x 180 pixels
Set c = cd.XYChart(300, 180)

'Set the plot area at (50, 20) and of size 200 x 130 pixels
Call c.setPlotArea(50, 20, 200, 130)

'Add a title to the chart using 8 pts Arial Bold font
Call c.addTitle("Independent Y-Axis Demo", "arialbd.ttf", 8)

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'Add a title to the primary (left) y axis
Call c.yAxis().setTitle("Packet Drop Rate (pps)")

'Set the axis, label and title colors for the primary y axis to red (0xc00000)
'to match the first data set
Call c.yAxis().setColors(&Hc00000, &Hc00000, &Hc00000)

'Add a title to the secondary (right) y axis
Call c.yAxis2().setTitle("Throughtput (MBytes)")

'set the axis, label and title colors for the primary y axis to green (0x008000)
'to match the second data set
Call c.yAxis2().setColors(&H8000, &H8000, &H8000)

'Add a line layer to for the first data set using red (0xc00000) color with a
'line width to 3 pixels
Call c.addLineLayer(data0, &Hc00000).setLineWidth(3)

'Add a bar layer to for the second data set using green (0x00C000) color. Bind
'the second data set to the secondary (right) y axis
Call c.addBarLayer().addDataSet(data1, &Hc000).setUseYAxis2()

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

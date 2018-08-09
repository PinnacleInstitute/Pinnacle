<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(50, 55, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84, 89)

'The error data representing the error band around the data points
errData = Array(5, 6, 5.1, 6.5, 6.6, 8, 5.4, 5.1, 4.6, 5.0, 5.2, 6.0, 4.9, _
    5.6, 4.8, 6.2, 7.4, 7.1, 6.5, 9.6, 12.1, 15.3, 18.5, 20.9, 24.1)

'The labels for the chart
labels = Array("Jan 01", "-", "-", "Apr", "-", "-", "Jul", "-", "-", "Oct", _
    "-", "-", "Jan 02", "-", "-", "Apr", "-", "-", "Jul", "-", "-", "Oct", _
    "-", "-", "Jan 03")

'Create a XYChart object of size 550 x 220 pixels
Set c = cd.XYChart(550, 220)

'Set the plot area at (50, 5) and of size 480 x 180 pixels. Enabled both
'vertical and horizontal grids by setting their colors to light grey (0xc0c0c0)
Call c.setPlotArea(50, 5, 480, 180).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a legend box (50, 5) (top of plot area) using horizontal layout. Use 8 pts
'Arial font. Disable bounding box (set border to transparent).
Set legendBox = c.addLegend(50, 5, False, "", 8)
Call legendBox.setBackground(cd.Transparent)

'Add keys to the legend box to explain the color zones
Call legendBox.addKey("Historical", &H9999ff)
Call legendBox.addKey("Forecast", &Hff9966)

'Add a title to the y axis.
Call c.yAxis().setTitle("Energy Consumption")

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a line layer to the chart
Set layer = c.addLineLayer2()

'Create the color to draw the data line. The line is blue (0x333399) to the left
'of x = 18, and become a red (0xd04040) dash line to the right of x = 18.
lineColor = layer.xZoneColor(18, &H333399, c.dashLineColor(&Hd04040, _
    cd.DashLine))

'Add the data line
Call layer.addDataSet(data, lineColor)

'Create the color to draw the err zone. The color is semi-transparent blue
'(0x809999ff) to the left of x = 18, and become semi-transparent red
'(0x80ff9966) to the right of x = 18.
errColor = layer.xZoneColor(18, &H809999ff, &H80ff9966)

'Add the upper border of the err zone
Call layer.addDataSet(cd.ArrayMath(data).add(errData).result(), errColor)

'Add the lower border of the err zone
Call layer.addDataSet(cd.ArrayMath(data).subtract(errData).result(), errColor)

'Set the default line width to 2 pixels
Call layer.setLineWidth(2)

'Color the region between the err zone lines
Call c.addInterLineLayer(layer.getLine(1), layer.getLine(2), errColor)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

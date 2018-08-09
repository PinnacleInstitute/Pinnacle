<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the line chart
data0 = Array(60.2, 51.7, 81.3, 48.6, 56.2, 68.9, 52.8)
data1 = Array(30.0, 32.7, 33.9, 29.5, 32.2, 28.4, 29.8)
labels = Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")

'Create a XYChart object of size 300 x 180 pixels, with a pale yellow (0xffffc0)
'background, a black border, and 1 pixel 3D border effect.
Set c = cd.XYChart(300, 180, &Hffffc0, &H0, 1)

'Set the plotarea at (45, 35) and of size 240 x 120 pixels, with white
'background. Turn on both horizontal and vertical grid lines with light grey
'color (0xc0c0c0)
Call c.setPlotArea(45, 35, 240, 120, &Hffffff, -1, -1, &Hc0c0c0, -1)

'Add a legend box at (45, 12) (top of the chart) using horizontal layout and 8
'pts Arial font Set the background and border color to Transparent.
Call c.addLegend(45, 12, False, "", 8).setBackground(cd.Transparent)

'Add a title to the chart using 9 pts Arial Bold/white font. Use a 1 x 2 bitmap
'pattern as the background.
Call c.addTitle("Server Load (Jun 01 - Jun 07)", "arialbd.ttf", 9, &Hffffff _
    ).setBackground(c.patternColor(Array(&H4000, &H8000), 2))

'Set the y axis label format to nn%
Call c.yAxis().setLabelFormat("{value}%")

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a line layer to the chart
Set layer = c.addLineLayer()

'Add the first line. Plot the points with a 7 pixel square symbol
Call layer.addDataSet(data0, &Hcf4040, "Peak").setDataSymbol(cd.SquareSymbol,7)

'Add the second line. Plot the points with a 9 pixel dismond symbol
Call layer.addDataSet(data1, &H40cf40, "Average").setDataSymbol( _
    cd.DiamondSymbol, 9)

'Enable data label on the data points. Set the label format to nn%.
Call layer.setDataLabelFormat("{value|0}%")

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

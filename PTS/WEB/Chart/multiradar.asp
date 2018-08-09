<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(90, 60, 85, 75, 55)
data1 = Array(60, 80, 70, 80, 85)

'The labels for the chart
labels = Array("Speed", "Reliability", "Comfort", "Safety", "Efficiency")

'Create a PolarChart object of size 480 x 380 pixels
Set c = cd.PolarChart(480, 380)

'Set background color to gold (goldGradient), with 1 pixel 3D border effect
Call c.setBackground(c.gradientColor(cd.goldGradient, 90, 2), cd.Transparent,1)

'Add a title to the chart using 12 pts Arial Bold Italic font. The title text is
'white (0xffffff) on a black background
Call c.addTitle("Space Travel Vehicles Compared", "arialbi.ttf", 12, &Hffffff _
    ).setBackground(&H0)

'Set center of plot area at (240, 210) with radius 150 pixels
Call c.setPlotArea(240, 210, 150)

'Add a legend box at (5, 30) using 10 pts Arial Bold font. Set the background to
'silver (silverGradient), with a black border, and 1 pixel 3D border effect.
Call c.addLegend(5, 30, True, "arialbd.ttf", 10).setBackground( _
    c.gradientColor(cd.silverGradient, 90, 0.5), 1, 1)

'Add an area layer to the chart using semi-transparent blue (0x806666cc). Add a
'blue (0x6666cc) line layer using the same data with 3 pixel line width to
'highlight the border of the area.
Call c.addAreaLayer(data0, &H806666cc, "Ultra Speed")
Call c.addLineLayer(data0, &H6666cc).setLineWidth(3)

'Add an area layer to the chart using semi-transparent red (0x80cc6666). Add a
'red (0xcc6666) line layer using the same data with 3 pixel line width to
'highlight the border of the area.
Call c.addAreaLayer(data1, &H80cc6666, "Super Economy")
Call c.addLineLayer(data1, &Hcc6666).setLineWidth(3)

'Set the labels to the angular axis as spokes.
Call c.angularAxis().setLabels(labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(22, 27.4, 22, 17, 13, 27, 26, 20.2, 23, 28, 27, 24)

'The circular data points used to represent the zones
zone0 = Array(15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15)
zone1 = Array(25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25)

'The labels for the chart
labels = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", _
    "Oct", "Nov", "Dec")

'Create a PolarChart object of size 400 x 420 pixels
Set c = cd.PolarChart(400, 420)

'Set background color to a 2 pixel pattern color, with a black border and 1
'pixel 3D border effect
Call c.setBackground(c.patternColor(Array(&Hffffff, &He0e0e0), 2), 0, 1)

'Add a title to the chart using 16 pts Arial Bold Italic font. The title text is
'white (0xffffff) on 2 pixel pattern background
Call c.addTitle("Chemical Concentration", "arialbi.ttf", 16, &Hffffff _
    ).setBackground(c.patternColor(Array(&H0, &H80), 2))

'Set center of plot area at (200, 240) with radius 145 pixels. Set background
'color to 0xffcccc
Call c.setPlotArea(200, 240, 145, &Hffcccc)

'Set the grid style to circular grid
Call c.setGridStyle(False)

'Set the radial axis label format
Call c.radialAxis().setLabelFormat("{value} ppm")

'Add a legend box at (200, 30) top center aligned, using 9 pts Arial Bold font.
'with a black border, and 1 pixel 3D border effect.
Set legendBox = c.addLegend(200, 30, False, "arialbd.ttf", 9)
Call legendBox.setAlignment(cd.TopCenter)

'Add a legend key to represent the red (0xffcccc) zone
Call legendBox.addKey("Over-Absorp", &Hffcccc)

'Add a spline area layer using circular data to represent the green (0xaaffaa)
'and blue (0xccccff) zones
Call c.addSplineAreaLayer(zone1, &Haaffaa, "Normal")
Call c.addSplineAreaLayer(zone0, &Hccccff, "Under-Absorp")

'Add a blue (0x80) spline line layer with line width set to 3 pixels
Call c.addSplineLineLayer(data0, &H80).setLineWidth(3)

'Set the labels to the angular axis as spokes. Set the font size to 10 pts
'fonts.
Call c.angularAxis().setLabels(labels).setFontSize(10)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

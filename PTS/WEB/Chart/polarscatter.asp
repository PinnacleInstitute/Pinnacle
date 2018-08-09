<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(43, 89, 76, 64, 48, 18, 92, 68, 44, 79, 71, 85)
angles0 = Array(45, 96, 169, 258, 15, 30, 330, 260, 60, 75, 110, 140)

data1 = Array(50, 91, 26, 29, 80, 53, 62, 87, 19, 40)
angles1 = Array(230, 210, 240, 310, 179, 250, 244, 199, 89, 160)

data2 = Array(88, 65, 76, 49, 80, 53)
angles2 = Array(340, 310, 340, 210, 30, 300)

'The labels on the angular axis (spokes)
labels = Array("North", "North<*br*>East", "East", "South<*br*>East", "South", _
    "South<*br*>West", "West", "North<*br*>West")

'Create a PolarChart object of size 460 x 460 pixels
Set c = cd.PolarChart(460, 460)

'Add a title to the chart at the top left corner using 15pts Arial Bold Italic
'font
Call c.addTitle2(cd.TopLeft, "<*underline=2*>Plants in Wonderland", _
    "arialbi.ttf", 15)

'Set center of plot area at (230, 240) with radius 180 pixels
Call c.setPlotArea(230, 240, 180)

'Set the grid style to circular grid
Call c.setGridStyle(False)

'Add a legend box at the top right corner of the chart using 9 pts Arial Bold
'font
Call c.addLegend(459, 0, True, "arialbd.ttf", 9).setAlignment(cd.TopRight)

'Set angular axis as 0 - 360, either 8 spokes
Call c.angularAxis().setLinearScale2(0, 360, labels)

'Set the radial axis label format
Call c.radialAxis().setLabelFormat("{value} km")

'Add a blue (0xff) polar line layer to the chart using (data0, angle0)
Set layer0 = c.addLineLayer(data0, &Hff, "Immortal Weed")
Call layer0.setAngles(angles0)

Call layer0.setLineWidth(0)
Call layer0.setDataSymbol(cd.TriangleSymbol, 11)

'Add a red (0xff0000) polar line layer to the chart using (data1, angles1)
Set layer1 = c.addLineLayer(data1, &Hff0000, "Precious Flower")
Call layer1.setAngles(angles1)

'Disable the line by setting its width to 0, so only the symbols are visible
Call layer1.setLineWidth(0)

'Use a 11 pixel diamond data point symbol
Call layer1.setDataSymbol(cd.DiamondSymbol, 11)

'Add a green (0x00ff00) polar line layer to the chart using (data2, angles2)
Set layer2 = c.addLineLayer(data2, &Hff00, "Magical Tree")
Call layer2.setAngles(angles2)

'Disable the line by setting its width to 0, so only the symbols are visible
Call layer2.setLineWidth(0)

'Use a 9 pixel square data point symbol
Call layer2.setDataSymbol(cd.SquareSymbol, 9)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

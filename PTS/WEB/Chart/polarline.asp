<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(90, 25, 40, 55, 68, 44, 79, 85, 50)
angles0 = Array(15, 60, 110, 180, 230, 260, 260, 310, 340)

data1 = Array(80, 91, 66, 80, 92, 87)
angles1 = Array(40, 65, 88, 110, 150, 200)

'Create a PolarChart object of size 460 x 460 pixels
Set c = cd.PolarChart(460, 460)

'Add a title to the chart at the top left corner using 15pts Arial Bold Italic
'font
Call c.addTitle2(cd.TopLeft, "<*underline=2*>Polar Line Chart Demo", _
    "arialbi.ttf", 15)

'Set center of plot area at (230, 240) with radius 180 pixels
Call c.setPlotArea(230, 240, 180)

'Set the grid style to circular grid, with grids below the chart layers
Call c.setGridStyle(False, False)

'Add a legend box at the top right corner of the chart using 9 pts Arial Bold
'font
Call c.addLegend(459, 0, True, "arialbd.ttf", 9).setAlignment(cd.TopRight)

'Set angular axis as 0 - 360, either spoke every 30 units
Call c.angularAxis().setLinearScale(0, 360, 30)

'Add a blue (0xff) line layer to the chart using (data0, angle0)
Set layer0 = c.addLineLayer(data0, &Hff, "Close Loop Line")
Call layer0.setAngles(angles0)

'Set the line width to 2 pixels
Call layer0.setLineWidth(2)

'Use 11 pixel triangle symbols for the data points
Call layer0.setDataSymbol(cd.TriangleSymbol, 11)

'Enable data label and set its format
Call layer0.setDataLabelFormat("({value},{angle})")

'Set the data label text box with light blue (0x9999ff) backgruond color and 1
'pixel 3D border effect
Call layer0.setDataLabelStyle().setBackground(&H9999ff, cd.Transparent, 1)

'Add a red (0xff0000) line layer to the chart using (data1, angle1)
Set layer1 = c.addLineLayer(data1, &Hff0000, "Open Loop Line")
Call layer1.setAngles(angles1)

'Set the line width to 2 pixels
Call layer1.setLineWidth(2)

'Use 11 pixel diamond symbols for the data points
Call layer1.setDataSymbol(cd.DiamondSymbol, 11)

'Set the line to open loop
Call layer1.setCloseLoop(False)

'Enable data label and set its format
Call layer1.setDataLabelFormat("({value},{angle})")

'Set the data label text box with light red (0xff9999) backgruond color and 1
'pixel 3D border effect
Call layer1.setDataLabelStyle().setBackground(&Hff9999, cd.Transparent, 1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(6, 12.5, 18.2, 15)
angles0 = Array(45, 96, 169, 258)
size0 = Array(41, 105, 12, 20)

data1 = Array(18, 16, 11, 14)
angles1 = Array(30, 210, 240, 310)
size1 = Array(30, 45, 12, 90)

'Create a PolarChart object of size 460 x 460 pixels
Set c = cd.PolarChart(460, 460)

'Add a title to the chart at the top left corner using 15pts Arial Bold Italic
'font
Call c.addTitle2(cd.TopLeft, "<*underline=2*>EM Field Strength", _
    "arialbi.ttf", 15)

'Set center of plot area at (230, 240) with radius 180 pixels
Call c.setPlotArea(230, 240, 180)

'Set the grid style to circular grid
Call c.setGridStyle(False)

'Add a legend box at the top right corner of the chart using 9 pts Arial Bold
'font
Call c.addLegend(459, 0, True, "arialbd.ttf", 9).setAlignment(cd.TopRight)

'Set angular axis as 0 - 360, either spoke every 30 units
Call c.angularAxis().setLinearScale(0, 360, 30)

'Set the radial axis label format
Call c.radialAxis().setLabelFormat("{value} km")

'Add a blue (0x9999ff) line layer to the chart using (data0, angle0)
Set layer0 = c.addLineLayer(data0, &H9999ff, "Cold Spot")
Call layer0.setAngles(angles0)

'Disable the line by setting its width to 0, so only the symbols are visible
Call layer0.setLineWidth(0)

'Use a circular data point symbol
Call layer0.setDataSymbol(cd.CircleSymbol, 11)

'Modulate the symbol size by size0 to produce a bubble chart effect
Call layer0.setSymbolScale(size0)

'Add a red (0xff9999) line layer to the chart using (data1, angle1)
Set layer1 = c.addLineLayer(data1, &Hff9999, "Hot Spot")
Call layer1.setAngles(angles1)

'Disable the line by setting its width to 0, so only the symbols are visible
Call layer1.setLineWidth(0)

'Use a circular data point symbol
Call layer1.setDataSymbol(cd.CircleSymbol, 11)

'Modulate the symbol size by size1 to produce a bubble chart effect
Call layer1.setSymbolScale(size1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

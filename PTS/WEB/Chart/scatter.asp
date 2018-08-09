<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The XY points for the scatter chart
dataX0 = Array(10, 15, 6, 12, 14, 8, 13, 13, 16, 12, 10.5)
dataY0 = Array(130, 150, 80, 110, 110, 105, 130, 115, 170, 125, 125)

dataX1 = Array(6, 12, 4, 3.5, 7, 8, 9, 10, 12, 11, 8)
dataY1 = Array(65, 80, 40, 45, 70, 80, 80, 90, 100, 105, 60)

'Create a XYChart object of size 450 x 420 pixels
Set c = cd.XYChart(450, 420)

'Set the plotarea at (55, 65) and of size 350 x 300 pixels, with a light grey
'border (0xc0c0c0). Turn on both horizontal and vertical grid lines with light
'grey color (0xc0c0c0)
Call c.setPlotArea(55, 65, 350, 300, -1, -1, &Hc0c0c0, &Hc0c0c0, -1)

'Add a legend box at (50, 30) (top of the chart) with horizontal layout. Use 12
'pts Times Bold Italic font. Set the background and border color to Transparent.
Call c.addLegend(50, 30, False, "timesbi.ttf", 12).setBackground( _
    cd.Transparent)

'Add a title to the chart using 18 pts Times Bold Itatic font.
Call c.addTitle("Genetically Modified Predator", "timesbi.ttf", 18)

'Add a title to the y axis using 12 pts Arial Bold Italic font
Call c.yAxis().setTitle("Length (cm)", "arialbi.ttf", 12)

'Add a title to the x axis using 12 pts Arial Bold Italic font
Call c.xAxis().setTitle("Weight (kg)", "arialbi.ttf", 12)

'Set the axes line width to 3 pixels
Call c.xAxis().setWidth(3)
Call c.yAxis().setWidth(3)

'Add an orange (0xff9933) scatter chart layer, using 13 pixel diamonds as
'symbols
Call c.addScatterLayer(dataX0, dataY0, "Genetically Engineered", _
    cd.DiamondSymbol, 13, &Hff9933)

'Add a green (0x33ff33) scatter chart layer, using 11 pixel triangles as symbols
Call c.addScatterLayer(dataX1, dataY1, "Natural", cd.TriangleSymbol, 11, _
    &H33ff33)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

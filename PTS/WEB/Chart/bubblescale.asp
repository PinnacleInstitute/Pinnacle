<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The XY points for the bubble chart. The bubble chart has independent bubble
'size on the X and Y direction.
dataX0 = Array(1000, 1500, 1700)
dataY0 = Array(25, 20, 65)
dataZX0 = Array(500, 200, 600)
dataZY0 = Array(15, 30, 20)

dataX1 = Array(500, 1000, 1300)
dataY1 = Array(35, 50, 75)
dataZX1 = Array(800, 300, 500)
dataZY1 = Array(8, 27, 25)

dataX2 = Array(150, 300)
dataY2 = Array(20, 60)
dataZX2 = Array(160, 400)
dataZY2 = Array(30, 20)

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
Call c.addTitle("Plasma Battery Comparison", "timesbi.ttf", 18)

'Add titles to the axes using 12 pts Arial Bold Italic font
Call c.yAxis().setTitle("Operating Current", "arialbi.ttf", 12)
Call c.xAxis().setTitle("Operating Voltage", "arialbi.ttf", 12)

'Set the axes line width to 3 pixels
Call c.xAxis().setWidth(3)
Call c.yAxis().setWidth(3)

'Add (dataX0, dataY0) as a standard scatter layer, and also as a "bubble"
'scatter layer, using circles as symbols. The "bubble" scatter layer has symbol
'size modulated by (dataZX0, dataZY0) using the scale on the x and y axes.
Call c.addScatterLayer(dataX0, dataY0, "Vendor A", cd.CircleSymbol, 9, _
    &Hff3333, &Hff3333)
Call c.addScatterLayer(dataX0, dataY0, "", cd.CircleSymbol, 9, &H80ff3333, _
    &H80ff3333).setSymbolScale(dataZX0, cd.XAxisScale, dataZY0, cd.YAxisScale)

'Add (dataX1, dataY1) as a standard scatter layer, and also as a "bubble"
'scatter layer, using squares as symbols. The "bubble" scatter layer has symbol
'size modulated by (dataZX1, dataZY1) using the scale on the x and y axes.
Call c.addScatterLayer(dataX1, dataY1, "Vendor B", cd.SquareSymbol, 7, _
    &H3333ff, &H3333ff)
Call c.addScatterLayer(dataX1, dataY1, "", cd.SquareSymbol, 9, &H803333ff, _
    &H803333ff).setSymbolScale(dataZX1, cd.XAxisScale, dataZY1, cd.YAxisScale)

'Add (dataX2, dataY2) as a standard scatter layer, and also as a "bubble"
'scatter layer, using diamonds as symbols. The "bubble" scatter layer has symbol
'size modulated by (dataZX2, dataZY2) using the scale on the x and y axes.
Call c.addScatterLayer(dataX2, dataY2, "Vendor C", cd.DiamondSymbol, 9, _
    &Hff00, &Hff00)
Call c.addScatterLayer(dataX2, dataY2, "", cd.DiamondSymbol, 9, &H8033ff33, _
    &H8033ff33).setSymbolScale(dataZX2, cd.XAxisScale, dataZY2, cd.YAxisScale)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

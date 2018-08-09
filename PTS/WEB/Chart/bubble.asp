<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The XYZ points for the bubble chart
dataX0 = Array(150, 300, 1000, 1700)
dataY0 = Array(12, 60, 25, 65)
dataZ0 = Array(20, 50, 50, 85)

dataX1 = Array(500, 1000, 1300)
dataY1 = Array(35, 50, 75)
dataZ1 = Array(30, 55, 95)

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
Call c.addTitle("Product Comparison Chart", "timesbi.ttf", 18)

'Add a title to the y axis using 12 pts Arial Bold Italic font
Call c.yAxis().setTitle("Capacity (tons)", "arialbi.ttf", 12)

'Add a title to the x axis using 12 pts Arial Bold Italic font
Call c.xAxis().setTitle("Range (miles)", "arialbi.ttf", 12)

'Set the axes line width to 3 pixels
Call c.xAxis().setWidth(3)
Call c.yAxis().setWidth(3)

'Add (dataX0, dataY0) as a scatter layer with semi-transparent red (0x80ff3333)
'circle symbols, where the circle size is modulated by dataZ0. This creates a
'bubble effect.
Call c.addScatterLayer(dataX0, dataY0, "Technology AAA", cd.CircleSymbol, 9, _
    &H80ff3333, &H80ff3333).setSymbolScale(dataZ0)

'Add (dataX1, dataY1) as a scatter layer with semi-transparent green
'(0x803333ff) circle symbols, where the circle size is modulated by dataZ1. This
'creates a bubble effect.
Call c.addScatterLayer(dataX1, dataY1, "Technology BBB", cd.CircleSymbol, 9, _
    &H803333ff, &H803333ff).setSymbolScale(dataZ1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

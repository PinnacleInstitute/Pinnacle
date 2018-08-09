<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The XY data of the first data series
dataX0 = Array(50, 55, 37, 24, 42, 49, 63, 72, 83, 59)
dataY0 = Array(3.6, 2.8, 2.5, 2.3, 3.8, 3.0, 3.8, 5.0, 6.0, 3.3)

'The XY data of the second data series
dataX1 = Array(50, 55, 37, 24, 42, 49, 63, 72, 83, 59)
dataY1 = Array(1.6, 1.8, 0.8, 0.5, 1.3, 1.5, 2.3, 2.4, 2.9, 1.5)

'Create a XYChart object of size 450 x 420 pixels
Set c = cd.XYChart(450, 420)

'Set the plotarea at (55, 65) and of size 350 x 300 pixels, with white
'background and a light grey border (0xc0c0c0). Turn on both horizontal and
'vertical grid lines with light grey color (0xc0c0c0)
Call c.setPlotArea(55, 65, 350, 300, &Hffffff, -1, &Hc0c0c0, &Hc0c0c0, -1)

'Add a legend box at (50, 30) (top of the chart) with horizontal layout. Use 12
'pts Times Bold Italic font. Set the background and border color to Transparent.
Call c.addLegend(50, 30, False, "timesbi.ttf", 12).setBackground( _
    cd.Transparent)

'Add a title to the chart using 18 point Times Bold Itatic font.
Call c.addTitle("Server Performance", "timesbi.ttf", 18)

'Add a title to the y axis using 12 pts Arial Bold Italic font
Call c.yAxis().setTitle("Response Time (sec)", "arialbi.ttf", 12)

'Set the y axis line width to 3 pixels
Call c.yAxis().setWidth(3)

'Set the y axis label format to show 1 decimal point
Call c.yAxis().setLabelFormat("{value|1}")

'Add a title to the x axis using 12 pts Arial Bold Italic font
Call c.xAxis().setTitle("Server Load (TPS)", "arialbi.ttf", 12)

'Set the x axis line width to 3 pixels
Call c.xAxis().setWidth(3)

'Add a scatter layer using (dataX0, dataY0)
Call c.addScatterLayer(dataX0, dataY0, "Server AAA", cd.DiamondSymbol, 11, _
    &H8000)

'Add a trend line layer for (dataX0, dataY0)
Call c.addTrendLayer2(dataX0, dataY0, &H8000).setLineWidth(3)

'Add a scatter layer for (dataX1, dataY1)
Call c.addScatterLayer(dataX1, dataY1, "Server BBB", cd.TriangleSymbol, 9, _
    &H6666ff)

'Add a trend line layer for (dataX1, dataY1)
Call c.addTrendLayer2(dataX1, dataY1, &H6666ff).setLineWidth(3)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

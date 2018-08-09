<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
dataY0 = Array(4, 4.5, 5, 5.25, 5.75, 5.25, 5, 4.5, 4, 3, 2.5, 2.5)
dataX0 = Array(DateSerial(1997, 1, 1), DateSerial(1998, 6, 25), DateSerial( _
    1999, 9, 6), DateSerial(2000, 2, 6), DateSerial(2000, 9, 21), DateSerial( _
    2001, 3, 4), DateSerial(2001, 6, 8), DateSerial(2002, 2, 4), DateSerial( _
    2002, 5, 19), DateSerial(2002, 8, 16), DateSerial(2002, 12, 1), _
    DateSerial(2003, 1, 1))

dataY1 = Array(7, 6.5, 6, 5, 6.5, 7, 6, 5.5, 5, 4, 3.5, 3.5)
dataX1 = Array(DateSerial(1997, 1, 1), DateSerial(1997, 7, 1), DateSerial( _
    1997, 12, 1), DateSerial(1999, 1, 15), DateSerial(1999, 6, 9), DateSerial( _
    2000, 3, 3), DateSerial(2000, 8, 13), DateSerial(2001, 5, 5), DateSerial( _
    2001, 9, 16), DateSerial(2002, 3, 16), DateSerial(2002, 6, 1), DateSerial( _
    2003, 1, 1))

'Create a XYChart object of size 500 x 270 pixels, with a pale blue (0xe0e0ff)
'background, a light blue (0xccccff) border, and 1 pixel 3D border effect.
Set c = cd.XYChart(500, 270, &He0e0ff, &Hccccff, 1)

'Set the plotarea at (50, 50) and of size 420 x 180 pixels, using white
'(0xffffff) as the plot area background color. Turn on both horizontal and
'vertical grid lines with light grey color (0xc0c0c0)
Call c.setPlotArea(50, 50, 420, 180, &Hffffff).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a legend box at (55, 25) (top of the chart) with horizontal layout. Use 10
'pts Arial Bold Italic font. Set the background and border color to Transparent.
Call c.addLegend(55, 25, False, "arialbi.ttf", 10).setBackground( _
    cd.Transparent)

'Add a title to the chart using 14 points Times Bold Itatic font, using blue
'(0x9999ff) as the background color
Call c.addTitle("Interest Rates", "timesbi.ttf", 14).setBackground(&H9999ff)

'Set the y axis label format to display a percentage sign
Call c.yAxis().setLabelFormat("{value}%")

'Add a red (0xff0000) step line layer to the chart and set the line width to 2
'pixels
Set layer0 = c.addStepLineLayer(dataY0, &Hff0000, "Country AAA")
Call layer0.setXData(dataX0)
Call layer0.setLineWidth(2)

'Add a blue (0x0000ff) step line layer to the chart and set the line width to 2
'pixels
Set layer1 = c.addStepLineLayer(dataY1, &Hff, "Country BBB")
Call layer1.setXData(dataX1)
Call layer1.setLineWidth(2)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

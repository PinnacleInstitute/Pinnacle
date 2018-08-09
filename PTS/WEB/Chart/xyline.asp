<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The (x, y) data for the first line
dataX0 = Array(20, 90, 40, 30, 12)
dataY0 = Array(10, 40, 75, 54, 20)

'The (x, y) data for the second line
dataX1 = Array(10, 40, 75, 54, 60)
dataY1 = Array(50, 90, 40, 30, 10)

'Create a XYChart object of size 450 x 450 pixels
Set c = cd.XYChart(450, 450)

'Set the plotarea at (55, 65) and of size 350 x 300 pixels, with white
'background and a light grey border (0xc0c0c0). Turn on both horizontal and
'vertical grid lines with light grey color (0xc0c0c0)
Call c.setPlotArea(55, 65, 350, 300, &Hffffff, -1, &Hc0c0c0, &Hc0c0c0, -1)

'Add a legend box at (50, 30) (top of the chart) with horizontal layout. Use 12
'pts Times Bold Italic font. Set the background and border color to Transparent.
Call c.addLegend(50, 30, False, "timesbi.ttf", 12).setBackground( _
    cd.Transparent)

'Add a title to the chart using 18 pts Times Bold Itatic font
Call c.addTitle("Reaction Path", "timesbi.ttf", 18)

'Add a title to the y axis using 12 pts Arial Bold Italic font
Call c.yAxis().setTitle("Temperature (Celcius)", "arialbi.ttf", 12)

'Set the y axis line width to 3 pixels
Call c.yAxis().setWidth(3)

'Add a title to the x axis using 12 pts Arial Bold Italic font
Call c.xAxis().setTitle("Pressure (Pa)", "arialbi.ttf", 12)

'Set the x axis line width to 3 pixels
Call c.xAxis().setWidth(3)

'Add a red (0xff3333) line layer using dataX0 and dataY0
Set layer1 = c.addLineLayer(dataY0, &Hff3333, "Compound AAA")
Call layer1.setXData(dataX0)

'Set the line width to 3 pixels
Call layer1.setLineWidth(3)

'Use 9 pixel square symbols for the data points
Call layer1.getDataSet(0).setDataSymbol(cd.SquareSymbol, 9)

'Add custom text labels to the first and last point on the scatter plot using
'Arial Bold font
Call layer1.addCustomDataLabel(0, 0, "Start", "arialbd.ttf")
Call layer1.addCustomDataLabel(0, 4, "End", "arialbd.ttf")

'Add a green (0x33ff33) line layer using dataX1 and dataY1
Set layer2 = c.addLineLayer(dataY1, &H33ff33, "Compound BBB")
Call layer2.setXData(dataX1)

'Set the line width to 3 pixels
Call layer2.setLineWidth(3)

'Use 11 pixel diamond symbols for the data points
Call layer2.getDataSet(0).setDataSymbol(cd.DiamondSymbol, 11)

'Add custom text labels to the first and last point on the scatter plot using
'Arial Bold font
Call layer2.addCustomDataLabel(0, 0, "Start", "arialbd.ttf")
Call layer2.addCustomDataLabel(0, 4, "End", "arialbd.ttf")

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

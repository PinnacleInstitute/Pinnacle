<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The XY data of the first data series
dataX = Array(50, 55, 37, 24, 42, 49, 63, 72, 83, 59)
dataY = Array(3.6, 2.8, 2.5, 2.3, 3.8, 3.0, 3.8, 5.0, 6.0, 3.3)

'Create a XYChart object of size 450 x 420 pixels
Set c = cd.XYChart(450, 420)

'Set the plotarea at (55, 65) and of size 350 x 300 pixels, with white
'background and a light grey border (0xc0c0c0). Turn on both horizontal and
'vertical grid lines with light grey color (0xc0c0c0)
Call c.setPlotArea(55, 65, 350, 300, &Hffffff, -1, &Hc0c0c0, &Hc0c0c0, -1)

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

'Add a scatter layer using (dataX, dataY)
Call c.addScatterLayer(dataX, dataY, "", cd.DiamondSymbol, 11, &H8000)

'Add a trend line layer for (dataX, dataY)
Set layer = c.addTrendLayer2(dataX, dataY, &H8000)

'Set the line width to 3 pixels
Call layer.setLineWidth(3)

'Add a 95% confidence band for the line
Call layer.addConfidenceBand(0.95, &H806666ff)

'Add a 95% confidence band (prediction band) for the points
Call layer.addPredictionBand(0.95, &H8066ff66)

'Add a legend box at (50, 30) (top of the chart) with horizontal layout. Use 10
'pts Arial Bold Italic font. Set the background and border color to Transparent.
Set legendBox = c.addLegend(50, 30, False, "arialbi.ttf", 10)
Call legendBox.setBackground(cd.Transparent)

'Add entries to the legend box
Call legendBox.addKey("95% Line Confidence", &H806666ff)
Call legendBox.addKey("95% Point Confidence", &H8066ff66)

'Display the trend line parameters as a text table formatted using CDML
Set textbox = c.addText(56, 65, _
    "<*block*>Slope<*br*>Intercept<*br*>Correlation<*br*>Std Error<*/*>   " & _
    "<*block*>" & FormatNumber(layer.getSlope(), 4) & " sec/tps<*br*>" & _
    FormatNumber(layer.getIntercept(), 4) & " sec<*br*>" & FormatNumber( _
    layer.getCorrelation(), 4) & "<*br*>" & FormatNumber(layer.getStdError(), _
    4) & " sec<*/*>", "arialbd.ttf", 8)

'Set the background of the text box to light grey, with a black border, and 1
'pixel 3D border
Call textbox.setBackground(&Hc0c0c0, 0, 1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

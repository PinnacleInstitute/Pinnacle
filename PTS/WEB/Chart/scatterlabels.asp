<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The XY points for the scatter chart
dataX = Array(150, 400, 300, 1500, 800)
dataY = Array(0.6, 8, 5.4, 2, 4)

'The labels for the points
labels = Array("Nano<*br*>100", "SpeedTron<*br*>200 Lite", _
    "SpeedTron<*br*>200", "Marathon<*br*>Extra", "Marathon<*br*>2000")

'Create a XYChart object of size 450 x 400 pixels
Set c = cd.XYChart(450, 400)

'Set the plotarea at (55, 40) and of size 350 x 300 pixels, with a light grey
'border (0xc0c0c0). Turn on both horizontal and vertical grid lines with light
'grey color (0xc0c0c0)
Call c.setPlotArea(55, 40, 350, 300, &Hffffff, -1, &Hc0c0c0, &Hc0c0c0, -1)

'Add a title to the chart using 18 pts Times Bold Itatic font.
Call c.addTitle("Product Comparison Chart", "timesbi.ttf", 18)

'Add a title to the y axis using 12 pts Arial Bold Italic font
Call c.yAxis().setTitle("Capacity (tons)", "arialbi.ttf", 12)

'Add a title to the x axis using 12 pts Arial Bold Italic font
Call c.xAxis().setTitle("Range (miles)", "arialbi.ttf", 12)

'Set the axes line width to 3 pixels
Call c.xAxis().setWidth(3)
Call c.yAxis().setWidth(3)

'Add the data as a scatter chart layer, using a 15 pixel circle as the symbol
Set layer = c.addScatterLayer(dataX, dataY, "Server BBB", cd.CircleSymbol, 15, _
    &Hff3333, &Hff3333)

'Add labels to the chart as an extra field
Call layer.addExtraField(labels)

'Set the data label format to display the extra field
Call layer.setDataLabelFormat("{field0}")

'Use 8pts Arial Bold to display the labels
Set textbox = layer.setDataLabelStyle("arialbd.ttf", 8)

'Set the background to purple with a 1 pixel 3D border
Call textbox.setBackground(&Hcc99ff, cd.Transparent, 1)

'Put the text box 4 pixels to the right of the data point
Call textbox.setAlignment(cd.Left)
Call textbox.setPos(4, 0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data0 = Array(100, 125, 245, 147, 67)
data1 = Array(85, 156, 179, 211, 123)
data2 = Array(97, 87, 56, 267, 157)

'The labels for the bar chart
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 500 x 280 pixels, using 0xffffcc as background
'color, with a black border, and 1 pixel 3D border effect
Set c = cd.XYChart(500, 280, &Hffffcc, 0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (50, 45) and of size 320 x 200 pixels. Use white (0xffffff)
'color as background.
Call c.setPlotArea(50, 45, 320, 200, &Hffffff)

'Add a legend box at (370, 45) using vertical layout and 8 points Arial Bold
'font.
Set legendBox = c.addLegend(370, 45, True, "arialbd.ttf", 8)

'Set the legend box background and border to transparent
Call legendBox.setBackground(cd.Transparent, cd.Transparent)

'Set the legend box icon size to 16 x 32 pixels to match with custom icon size
Call legendBox.setKeySize(16, 32)

'Add a title to the chart using 14 points Times Bold Itatic font and white font
'color, and 0x804020 as the background color
Call c.addTitle("Weekly Product Sales", "timesbi.ttf", 14, &Hffffff _
    ).setBackground(&H804020)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a percentage bar layer and set the layer 3D depth to 8 pixels
Set layer = c.addBarLayer2(cd.Percentage)

'Add the three data sets to the bar layer, using icons images with labels as
'data set names
Call layer.addDataSet(data0, &Hddaa77, _
    "<*block,valign=absmiddle*><*img=service.png*> Service<*/*>")
Call layer.addDataSet(data1, &Haadd77, _
    "<*block,valign=absmiddle*><*img=software.png*> Software<*/*>")
Call layer.addDataSet(data2, &Haa77dd, _
    "<*block,valign=absmiddle*><*img=computer.png*> Hardware<*/*>")

'Disable bar borders by setting their colors to transparent
Call layer.setBorderColor(cd.Transparent)

'Enable data label at the middle of the the bar
Call layer.setDataLabelStyle().setAlignment(cd.Center)

'For a vertical stacked chart with positive data only, the last data set is
'always on top. However, in a vertical legend box, the last data set is at the
'bottom. This can be reversed by using the setLegend method.
Call layer.setLegend(cd.ReverseLegend)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the area chart
data0 = Array(42, 49, 33, 38, 51, 46, 29, 41, 44, 57, 59, 52, 37, 34, 51, 56, _
    56, 60, 70, 76, 63, 67, 75, 64, 51)
data1 = Array(50, 55, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84, 98)
data2 = Array(87, 89, 85, 66, 53, 39, 24, 21, 37, 56, 37, 23, 21, 33, 13, 17, _
    14, 23, 16, 25, 29, 30, 45, 47, 46)

'The labels for the area chart
labels = Array("1996", "-", "-", "-", "1997", "-", "-", "-", "1998", "-", "-", _
    "-", "1999", "-", "-", "-", "2000", "-", "-", "-", "2001", "-", "-", "-", _
    "2002")

'Create a XYChart object of size 500 x 280 pixels, using 0xffffcc as background
'color, with a black border, and 1 pixel 3D border effect
Set c = cd.XYChart(500, 280, &Hffffcc, 0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (50, 45) and of size 320 x 200 pixels with white
'background. Enable horizontal and vertical grid lines using the grey (0xc0c0c0)
'color.
Call c.setPlotArea(50, 45, 320, 200, &Hffffff).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a legend box at (370, 45) using vertical layout and 8 points Arial Bold
'font.
Set legendBox = c.addLegend(370, 45, True, "arialbd.ttf", 8)

'Set the legend box background and border to transparent
Call legendBox.setBackground(cd.Transparent, cd.Transparent)

'Set the legend box icon size to 16 x 32 pixels to match with custom icon size
Call legendBox.setKeySize(16, 32)

'Add a title to the chart using 14 points Times Bold Itatic font and white font
'color, and 0x804020 as the background color
Call c.addTitle("Quarterly Product Sales", "timesbi.ttf", 14, &Hffffff _
    ).setBackground(&H804020)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a percentage area layer to the chart
Set layer = c.addAreaLayer2(cd.Percentage)

'Add the three data sets to the area layer, using icons images with labels as
'data set names
Call layer.addDataSet(data0, &H40ddaa77, _
    "<*block,valign=absmiddle*><*img=service.png*> Service<*/*>")
Call layer.addDataSet(data1, &H40aadd77, _
    "<*block,valign=absmiddle*><*img=software.png*> Software<*/*>")
Call layer.addDataSet(data2, &H40aa77dd, _
    "<*block,valign=absmiddle*><*img=computer.png*> Hardware<*/*>")

'For a vertical stacked chart with positive data only, the last data set is
'always on top. However, in a vertical legend box, the last data set is at the
'bottom. This can be reversed by using the setLegend method.
Call layer.setLegend(cd.ReverseLegend)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

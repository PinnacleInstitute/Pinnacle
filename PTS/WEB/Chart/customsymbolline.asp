<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(600, 800, 1200, 1500, 1800, 1900, 2000, 1950)
data1 = Array(300, 450, 500, 1000, 1500, 1600, 1650, 1600)

'The labels for the chart
labels = Array("1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002")

'Create a XYChart object of size 450 x 250 pixels, with a pale yellow (0xffffc0)
'background, a black border, and 1 pixel 3D border effect.
Set c = cd.XYChart(450, 250, &Hffffc0, 0, 1)

'Set the plotarea at (60, 45) and of size 360 x 170 pixels, using white
'(0xffffff) as the plot area background color. Turn on both horizontal and
'vertical grid lines with light grey color (0xc0c0c0)
Call c.setPlotArea(60, 45, 360, 170, &Hffffff, -1, -1, &Hc0c0c0, -1)

'Add a legend box at (60, 20) (top of the chart) with horizontal layout. Use 8
'pts Arial Bold font. Set the background and border color to Transparent.
Call c.addLegend(60, 20, False, "arialbd.ttf", 8).setBackground(cd.Transparent)

'Add a title to the chart using 12 pts Arial Bold/white font. Use a 1 x 2 bitmap
'pattern as the background.
Call c.addTitle("Information Resource Usage", "arialbd.ttf", 12, &Hffffff _
    ).setBackground(c.patternColor(Array(&H40, &H80), 2))

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Reserve 8 pixels margins at both side of the x axis to avoid the first and last
'symbols drawing outside of the plot area
Call c.xAxis().setMargin(8, 8)

'Add a title to the y axis
Call c.yAxis().setTitle("Population")

'Add a line layer to the chart
Set layer = c.addLineLayer2()

'Add the first line using small_user.png as the symbol.
Call layer.addDataSet(data0, &Hcf4040, "Users").setDataSymbol2(Server.MapPath( _
    "small_user.png"))

'Add the first line using small_computer.png as the symbol.
Call layer.addDataSet(data1, &H40cf40, "Computers").setDataSymbol2( _
    Server.MapPath("small_computer.png"))

'Set the line width to 3 pixels
Call layer.setLineWidth(3)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

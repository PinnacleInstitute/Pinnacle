<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data0 = Array(44, 55, 100)
data1 = Array(97, 87, 167)
data2 = Array(156, 78, 147)
data3 = Array(125, 118, 211)

'The labels for the bar chart. The labels contains embedded images as icons.
labels = Array("<*img=service.png*><*br*>Service", _
    "<*img=software.png*><*br*>Software", "<*img=computer.png*><*br*>Hardware")

'Create a XYChart object of size 600 x 350 pixels, using 0xe0e0ff as the
'background color, 0xccccff as the border color, with 1 pixel 3D border effect.
Set c = cd.XYChart(600, 350, &He0e0ff, &Hccccff, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Add a title to the chart using 14 points Times Bold Itatic font and light blue
'(0x9999ff) as the background color
Call c.addTitle("Business Results 2001 vs 2002", "timesbi.ttf", 14 _
    ).setBackground(&H9999ff)

'Set the plotarea at (60, 45) and of size 500 x 210 pixels, using white
'(0xffffff) as the background
Call c.setPlotArea(60, 45, 500, 210, &Hffffff)

'Swap the x and y axes to create a horizontal bar chart
Call c.swapXY()

'Add a title to the y axis using 11 pt Times Bold Italic as font
Call c.yAxis().setTitle("Revenue (millions)", "timesbi.ttf", 11)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Disable x-axis ticks by setting the tick length to 0
Call c.xAxis().setTickLength(0)

'Add a stacked bar layer to the chart
Set layer = c.addBarLayer2(cd.Stack)

'Add the first two data sets to the chart as a stacked bar group
Call layer.addDataGroup("2001")
Call layer.addDataSet(data0, &Haaaaff, "Local")
Call layer.addDataSet(data1, &H6666ff, "International")

'Add the remaining data sets to the chart as another stacked bar group
Call layer.addDataGroup("2002")
Call layer.addDataSet(data2, &Hffaaaa, "Local")
Call layer.addDataSet(data3, &Hff6666, "International")

'Set the sub-bar gap to 0, so there is no gap between stacked bars with a group
Call layer.setBarGap(0.2, 0)

'Set the bar border to transparent
Call layer.setBorderColor(cd.Transparent)

'Set the aggregate label format
Call layer.setAggregateLabelFormat( _
    "Year {dataGroupName}<*br*>{value} millions")

'Set the aggregate label font to 8 point Arial Bold Italic
Call layer.setAggregateLabelStyle("arialbi.ttf", 8)

'Reverse 20% space at the right during auto-scaling to allow space for the
'aggregate bar labels
Call c.yAxis().setAutoScale(0.2)

'Add a legend box at (300, 300) using TopCenter alignment, with horizontal
'layout, and using 8 pt Arial Bold Italic as the font
Set legendBox = c.addLegend(300, 300, False, "arialbi.ttf", 8)
Call legendBox.setAlignment(cd.TopCenter)

'Set the legend box width to 500 pixels (height = automatic)
Call legendBox.setSize(500, 0)

'Set the format of the text displayed in the legend box
Call legendBox.setText("Year {dataGroupName} {dataSetName} Revenue")

'Set the background and border of the legend box to transparent
Call legendBox.setBackground(cd.Transparent, cd.Transparent)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

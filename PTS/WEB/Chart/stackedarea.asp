<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the area chart
data0 = Array(42, 49, 33, 38, 51, 46, 29, 41, 44, 57, 59, 52, 37, 34, 51, 56, _
    56, 60, 70, 76, 63, 67, 75, 64, 51)
data1 = Array(50, 45, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84, 89)
data2 = Array(61, 79, 85, 66, 53, 39, 24, 21, 37, 56, 37, 22, 21, 33, 13, 17, _
    4, 23, 16, 25, 9, 10, 5, 7, 16)
labels = Array("0", "-", "2", "-", "4", "-", "6", "-", "8", "-", "10", "-", _
    "12", "-", "14", "-", "16", "-", "18", "-", "20", "-", "22", "-", "24")

'Create a XYChart object of size 300 x 210 pixels. Set the background to pale
'yellow (0xffffc0) with a black border (0x0)
Set c = cd.XYChart(300, 210, &Hffffc0, &H0)

'Set the plotarea at (50, 30) and of size 240 x 140 pixels. Use white (0xffffff)
'background.
Call c.setPlotArea(50, 30, 240, 140).setBackground(&Hffffff)

'Add a legend box at (50, 185) (below of plot area) using horizontal layout. Use
'8 pts Arial font with Transparent background.
Call c.addLegend(50, 185, False, "", 8).setBackground(cd.Transparent)

'Add a title box to the chart using 8 pts Arial Bold font, with yellow
'(0xffff40) background and a black border (0x0)
Call c.addTitle("Sales Volume", "arialbd.ttf", 8).setBackground(&Hffff40, 0)

'Set the y axis label format to US$nnnn
Call c.yAxis().setLabelFormat("US${value}")

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'Add an stack area layer with three data sets
Set layer = c.addAreaLayer2(cd.Stack)
Call layer.addDataSet(data0, &H4040ff, "Store #1")
Call layer.addDataSet(data1, &Hff4040, "Store #2")
Call layer.addDataSet(data2, &H40ff40, "Store #3")

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

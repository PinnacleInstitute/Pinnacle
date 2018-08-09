<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(40, 45, 37, 24, 32, 39, 53, 52, 63, 49, 46, 40, 54, 50, 57, 57, _
    48, 49, 63, 67, 74, 72, 70, 89, 74)
labels = Array("0<*br*>Jun 4", "-", "-", "3", "-", "-", "6", "-", "-", "9", _
    "-", "-", "12", "-", "-", "15", "-", "-", "18", "-", "-", "21", "-", "-", _
    "0<*br*>Jun 5")

'Create a XYChart object of size 400 x 270 pixels
Set c = cd.XYChart(400, 270)

'Set the plotarea at (80, 60) and of size 300 x 200 pixels. Turn off the grid
'lines by setting their colors to Transparent.
Call c.setPlotArea(80, 28, 300, 200).setGridColor(cd.Transparent)

'Add a title to the y axis
Set textbox = c.yAxis().setTitle("Temperature")

'Set the y axis title upright (font angle = 0)
Call textbox.setFontAngle(0)

'Put the y axis title on top of the axis
Call textbox.setAlignment(cd.Top)

'Move the y axis title by (-36, 8) (36 pixels left, 8 pixels up)
Call textbox.setPos(-36, 8)

'Add green (0x99ff99), yellow (0xffff99) and red (0xff9999) zones to the y axis
'to represent the ranges 0 - 50, 50 - 80, and 80 - max.
Call c.yAxis().addZone(0, 50, &H99ff99)
Call c.yAxis().addZone(50, 80, &Hffff99)
Call c.yAxis().addZone(80, 9999, &Hff9999)

'Add a purple (0x800080) mark at y = 70 using a line width of 2.
Call c.yAxis().addMark(70, &H800080, "Alert = 70").setLineWidth(2)

'Add a green (0x008000) mark at y = 40 using a line width of 2.
Call c.yAxis().addMark(40, &H8000, "Watch = 40").setLineWidth(2)

'Add a legend box at (165, 0) (top right of the chart) using 8 pts Arial font.
'and horizontal layout.
Set legend = c.addLegend(165, 0, False, "arialbd.ttf", 8)

'Disable the legend box boundary by setting the colors to Transparent
Call legend.setBackground(cd.Transparent, cd.Transparent)

'Add 3 custom entries to the legend box to represent the 3 zones
Call legend.addKey("Normal", &H80ff80)
Call legend.addKey("Warning", &Hffff80)
Call legend.addKey("Critical", &Hff8080)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a 3D bar layer with the given data
Set layer = c.addBarLayer(data, &Hbbbbff)

'Set the bar gap to 0 so that the bars are packed tightly
Call layer.setBarGap(0)

'Set the border color of the bars same as the fill color, with 1 pixel 3D border
'effect.
Call layer.setBorderColor(cd.SameAsMainColor, 1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the area chart
data = Array(3.0, 2.8, 4.0, 5.5, 7.5, 6.8, 5.4, 6.0, 5.0, 6.2, 7.5, 6.5, 7.5, _
    8.1, 6.0, 5.5, 5.3, 3.5, 5.0, 6.6, 5.6, 4.8, 5.2, 6.5, 6.2)

'The labels for the area chart
labels = Array("0", "", "", "3", "", "", "6", "", "", "9", "", "", "12", "", _
    "", "15", "", "", "18", "", "", "21", "", "", "24")

'Create a XYChart object of size 300 x 180 pixels. Set the background to pale
'yellow (0xffffa0) with a black border (0x0)
Set c = cd.XYChart(300, 180, &Hffffa0, &H0)

'Set the plotarea at (45, 35) and of size 240 x 120 pixels. Set the background
'to white (0xffffff). Set both horizontal and vertical grid lines to black
'(&H0&) dotted lines (pattern code 0x0103)
Call c.setPlotArea(45, 35, 240, 120, &Hffffff, -1, -1, c.dashLineColor(&H0, _
    &H103), c.dashLineColor(&H0, &H103))

'Add a title to the chart using 10 pts Arial Bold font. Use a 1 x 2 bitmap
'pattern as the background. Set the border to black (0x0).
Call c.addTitle("Snow Percipitation (Dec 12)", "arialbd.ttf", 10 _
    ).setBackground(c.patternColor(Array(&Hb0b0f0, &He0e0ff), 2), &H0)

'Add a title to the y axis
Call c.yAxis().setTitle("mm per hour")

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'Add an area layer to the chart
Set layer = c.addAreaLayer()

'Load a snow pattern from an external file "snow.png".
snowPattern = c.patternColor(Server.MapPath("snow.png"))

'Add a data set to the area layer using the snow pattern as the fill color. Use
'deep blue (0x0000ff) as the area border line color (&H0000ff&)
Call layer.addDataSet(data).setDataColor(snowPattern, &Hff)

'Set the line width to 2 pixels to highlight the line
Call layer.setLineWidth(2)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

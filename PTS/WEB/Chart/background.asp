<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(85, 156, 179.5, 211, 123)
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 270 x 270 pixels
Set c = cd.XYChart(270, 270)

'Set the plot area at (40, 32) and of size 200 x 200 pixels
Set plotarea = c.setPlotArea(40, 32, 200, 200)

'Set the background style based on the input parameter
If Request("img") = "0" Then
    'Has wallpaper image
    Call c.setWallpaper(Server.MapPath("tile.gif"))
ElseIf Request("img") = "1" Then
    'Use a background image as the plot area background
    Call plotarea.setBackground2(Server.MapPath("bg.png"))
ElseIf Request("img") = "2" Then
    'Use white (0xffffff) and grey (0xe0e0e0) as two alternate plotarea
    'background colors
    Call plotarea.setBackground(&Hffffff, &He0e0e0)
Else
    'Use a dark background palette
    Call c.setColors(cd.whiteOnBlackPalette)
End If

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a color bar layer using the given data. Use a 1 pixel 3D border for the
'bars.
Call c.addBarLayer3(data).setBorderColor(-1, 1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

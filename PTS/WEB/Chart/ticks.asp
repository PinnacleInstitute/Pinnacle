<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(100, 125, 265, 147, 67, 105)

'Create a XYChart object of size 250 x 250 pixels
Set c = cd.XYChart(250, 250)

'Set the plot area at (27, 25) and of size 200 x 200 pixels
Call c.setPlotArea(27, 25, 200, 200)

If Request("img") = "1" Then
    'High tick density, uses 10 pixels as tick spacing
    Call c.addTitle("Tick Density = 10 pixels")
    Call c.yAxis().setTickDensity(10)
Else
    'Normal tick density, just use the default setting
    Call c.addTitle("Default Tick Density")
End If

'Add a color bar layer using the given data. Use a 1 pixel 3D border for the
'bars.
Call c.addBarLayer3(data).setBorderColor(-1, 1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

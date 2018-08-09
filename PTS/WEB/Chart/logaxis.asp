<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(100, 125, 260, 147, 67)
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'Create a XYChart object of size 200 x 180 pixels
Set c = cd.XYChart(200, 180)

'Set the plot area at (30, 10) and of size 140 x 130 pixels
Call c.setPlotArea(30, 10, 140, 130)

'Ise log scale axis if required
If Request("img") = "1" Then
    Call c.yAxis().setLogScale3()
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

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(5.5, 3.5, -3.7, 1.7, -1.4, 3.3)
labels = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun")

'Create a XYChart object of size 200 x 180 pixels
Set c = cd.XYChart(200, 180)

'Set the plot area at (30, 20) and of size 140 x 130 pixels
Call c.setPlotArea(30, 20, 140, 130)

'Configure the axis as according to the input parameter
If Request("img") = "0" Then
    Call c.addTitle("No Axis Extension", "arial.ttf", 8)
ElseIf Request("img") = "1" Then
    Call c.addTitle("Top/Bottom Extensions = 0/0", "arial.ttf", 8)
    'Reserve 20% margin at top of plot area when auto-scaling
    Call c.yAxis().setAutoScale(0, 0)
ElseIf Request("img") = "2" Then
    Call c.addTitle("Top/Bottom Extensions = 0.2/0.2", "arial.ttf", 8)
    'Reserve 20% margin at top and bottom of plot area when auto-scaling
    Call c.yAxis().setAutoScale(0.2, 0.2)
ElseIf Request("img") = "3" Then
    Call c.addTitle("Axis Top Margin = 15", "arial.ttf", 8)
    'Reserve 15 pixels at top of plot area
    Call c.yAxis().setMargin(15)
Else
    Call c.addTitle("Manual Scale -5 to 10", "arial.ttf", 8)
    'Set the y axis to scale from -5 to 10, with ticks every 5 units
    Call c.yAxis().setLinearScale(-5, 10, 5)
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

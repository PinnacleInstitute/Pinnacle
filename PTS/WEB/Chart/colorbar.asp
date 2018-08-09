<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data = Array(85, 156, 179.5, 211, 123)

'The labels for the bar chart
labels = Array("Mon", "Tue", "Wed", "Thu", "Fri")

'The colors for the bar chart
colors = Array(&Hb8bc9c, &Ha0bdc4, &H999966, &H333366, &Hc3c3e6)

'Create a XYChart object of size 260 x 220 pixels
Set c = cd.XYChart(260, 220)

'Set the background color of the chart to gold (goldGradient). Use a 2 pixel 3D
'border.
Call c.setBackground(c.gradientColor(cd.goldGradient), -1, 2)

'Add a title box using 10 point Arial Bold font. Set the background color to
'blue metallic (blueMetalGradient). Use a 1 pixel 3D border.
Call c.addTitle("Daily Network Load", "arialbd.ttf", 10).setBackground( _
    c.gradientColor(cd.blueMetalGradient), -1, 1)

'Set the plotarea at (40, 40) and of 200 x 150 pixels in size
Call c.setPlotArea(40, 40, 200, 150)

'Add a multi-color bar chart layer using the given data and colors. Use a 1
'pixel 3D border for the bars.
Call c.addBarLayer3(data, colors).setBorderColor(-1, 1)

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

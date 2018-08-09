<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Create a PieChart object of size 300 x 230 pixels
Set c = cd.PieChart(300, 230)

'Set the background color of the chart to gold (goldGradient). Use a 2 pixel 3D
'border.
Call c.setBackground(c.gradientColor(cd.goldGradient), -1, 2)

'Set the center of the pie at (150, 115) and the radius to 80 pixels
Call c.setPieSize(150, 115, 80)

'Add a title box using 10 point Arial Bold font. Set the background color to red
'metallic (redMetalGradient). Use a 1 pixel 3D border.
Call c.addTitle("Pie Chart Coloring Demo", "arialbd.ttf", 10).setBackground( _
    c.gradientColor(cd.redMetalGradient), -1, 1)

'Draw the pie in 3D
Call c.set3D()

'Set the pie data and the pie labels
Call c.setData(data, labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

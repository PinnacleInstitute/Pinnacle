<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Create a PieChart object of size 360 x 300 pixels
Set c = cd.PieChart(360, 300)

'Set the center of the pie at (180, 140) and the radius to 100 pixels
Call c.setPieSize(180, 140, 100)

'Set the pie data and the pie labels
Call c.setData(data, labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

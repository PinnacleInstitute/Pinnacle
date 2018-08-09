<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Create a PieChart object of size 500 x 230 pixels
Set c = cd.PieChart(500, 230)

'Set the center of the pie at (250, 120) and the radius to 100 pixels
Call c.setPieSize(250, 120, 100)

'Add a title box using 14 points Times Bold Italic as font
Call c.addTitle("Project Cost Breakdown", "timesbi.ttf", 14)

'Draw the pie in 3D
Call c.set3D()

'Use the side label layout method
Call c.setLabelLayout(cd.SideLayout)

'Set the pie data and the pie labels
Call c.setData(data, labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'the tilt angle of the pie
depth = CInt(Request("img")) * 5 + 5

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'Create a PieChart object of size 100 x 110 pixels
Set c = cd.PieChart(100, 110)

'Set the center of the pie at (50, 55) and the radius to 38 pixels
Call c.setPieSize(50, 55, 38)

'Set the depth of the 3D pie
Call c.set3D(depth)

'Add a title showing the depth
Call c.addTitle("Depth = " & depth & " pixels", "arial.ttf", 8)

'Set the pie data
Call c.setData(data)

'Disable the sector labels by setting the color to Transparent
Call c.setLabelStyle("", 8, cd.Transparent)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

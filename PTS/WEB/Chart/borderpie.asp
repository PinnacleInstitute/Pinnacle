<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Create a PieChart object of size 360 x 280 pixels
Set c = cd.PieChart(360, 280)

'Set the background color of the chart to silver (silverGradient), and the
'border color to black, with 1 pixel 3D border effect.
Call c.setBackground(c.gradientColor(cd.silverGradient), 0, 1)

'Set the center of the pie at (180, 140) and the radius to 100 pixels
Call c.setPieSize(180, 140, 100)

'Add a title to the pie chart, using light grey (0xc0c0c0) background and black
'border
Call c.addTitle("Project Cost Breakdown").setBackground(&Hc0c0c0, &H0)

'Draw the pie in 3D
Call c.set3D()

'Set the border color of the sectors to black (0x0)
Call c.setLineColor(&H0)

'Set the background color of the sector label to the same color as the sector.
'Use a black border.
Call c.setLabelStyle().setBackground(cd.SameAsMainColor, &H0)

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Explode the 1st sector (index = 0)
Call c.setExplode(0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

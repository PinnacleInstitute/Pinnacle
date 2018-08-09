<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(35, 30, 25, 7, 6, 5, 4, 3, 2, 1)

'The labels for the pie chart
labels = Array("Labor", "Production", "Facilities", "Taxes", "Misc", "Legal", _
    "Insurance", "Licenses", "Transport", "Interest")

'Create a PieChart object of size 500 x 230 pixels, with a light blue (0xccccff)
'background and a 1 pixel 3D border
Set c = cd.PieChart(500, 230, &Hccccff, -1, 1)

'Add a title box using Times Bold Italic/14 points as font and 0x9999ff as
'background color
Call c.addTitle("Project Cost Breakdown", "timesbi.ttf", 14).setBackground( _
    &H9999ff)

'Set the center of the pie at (250, 120) and the radius to 100 pixels
Call c.setPieSize(250, 120, 100)

'Draw the pie in 3D
Call c.set3D()

'Use the side label layout method
Call c.setLabelLayout(cd.SideLayout)

'Set the label box the same color as the sector with a 1 pixel 3D border
Call c.setLabelStyle().setBackground(cd.SameAsMainColor, cd.Transparent, 1)

'Set the border color of the sector the same color as the fill color. Set the
'line color of the join line to black (0x0)
Call c.setLineColor(cd.SameAsMainColor, &H0)

'Set the start angle to 135 degrees may improve layout when there are many small
'sectors at the end of the data array (that is, data sorted in descending
'order). It is because this makes the small sectors position near the horizontal
'axis, where the text label has the least tendency to overlap. For data sorted
'in ascending order, a start angle of 45 degrees can be used instead.
Call c.setStartAngle(135)

'Set the pie data and the pie labels
Call c.setData(data, labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Create a PieChart object of size 450 x 240 pixels
Set c = cd.PieChart(450, 240)

'Set the center of the pie at (150, 100) and the radius to 80 pixels
Call c.setPieSize(150, 100, 80)

'Add a title at the bottom of the chart using Arial Bold Italic font
Call c.addTitle2(cd.Bottom, "Project Cost Breakdown", "arialbi.ttf")

'Draw the pie in 3D
Call c.set3D()

'add a legend box where the top left corner is at (330, 40)
Call c.addLegend(330, 40)

'modify the label format for the sectors to $nnnK (pp.pp%)
Call c.setLabelFormat("{label} ${value}K<*br*>({percent}%)")

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Explode the 1st sector (index = 0)
Call c.setExplode(0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

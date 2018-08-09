<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Create a PieChart object of size 480 x 300 pixels
Set c = cd.PieChart(480, 300)

'Set the center of the pie at (150, 150) and the radius to 100 pixels
Call c.setPieSize(150, 150, 100)

'Add a title to the pie chart using Monotype Corsiva ("mtcorsva")/20 points/deep
'blue (0x000080) as font
Call c.addTitle("Project Cost Breakdown", "mtcorsva.ttf", 20, 128)

'Draw the pie in 3D
Call c.set3D()

'Add a legend box using 12 points Times New Romans Bold ("timesbd.ttf") font.
'Set background color to light grey (0xd0d0d0), with a 1 pixel 3D border.
Call c.addLegend(340, 80, True, "timesbd.ttf", 12).setBackground(&Hd0d0d0, _
    &Hd0d0d0, 1)

'Set the default font for all sector labels to Impact/8 points/dark green
'(0x008000).
Call c.setLabelStyle("impact.ttf", 8, &H8000)

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Explode the 3rd sector
Call c.setExplode(2, 40)

'Use Impact/12 points/red as label font for the 3rd sector
Call c.sector(2).setLabelStyle("impact.ttf", 12, &Hff0000)

'Use Arial/8 points/deep blue as label font for the 5th sector. Add a background
'box using the sector fill color (SameAsMainColor), with a black (0x000000) edge
'and 2 pixel 3D border.
Call c.sector(4).setLabelStyle("", 8, &H80).setBackground(cd.SameAsMainColor, _
    &H0, 2)

'Use Times New Romans/8 points/light red (0xff9999) as label font for the 6th
'sector. Add a dark blue (0x000080) background box with a 2 pixel 3D border.
Call c.sector(0).setLabelStyle("times.ttf", 8, &Hff9999).setBackground(&H80, _
    cd.Transparent, 2)

'Use Impact/8 points/deep green (0x008000) as label font for 7th sector. Add a
'yellow (0xFFFF00) background box with a black (0x000000) edge.
Call c.sector(6).setLabelStyle("impact.ttf", 8, &H8000).setBackground( _
    &Hffff00, &H0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

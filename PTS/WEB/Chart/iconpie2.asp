<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(28, 45, 5, 1, 12)

'The labels for the pie chart
labels = Array("Excellent", "Good", "Bad", "Very Bad", "Neutral")

'The icons for the sectors
icons = Array("laugh.png", "smile.png", "sad.png", "angry.png", _
    "nocomment.png")

'Create a PieChart object of size 560 x 300 pixels, using 0xe0e0ff as the
'background color, 0xccccff as the border color, with 1 pixel 3D border effect
Set c = cd.PieChart(560, 300, &He0e0ff, &Hccccff, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the center of the pie at (280, 140) and the radius to 100 pixels
Call c.setPieSize(280, 140, 120)

'Add a title box with title written in CDML
Call c.addTitle( _
    "<*block,valign=absmiddle*><*img=doc.png*><*font=timesbi.ttf,size=15*> " & _
    "Customer Survey : <*font=timesi.ttf*>Do you like our " & _
    "<*block,valign=top*><*font=mtcorsva.ttf,color=dd0000,size=17*>Hyper" & _
    "<*block*><*font=arial.ttf,size=8*> TM<*/*><*/*> molecules?<*/*>" _
    ).setBackground(&Hccccff)

'Add a logo to the chart written in CDML as the bottom title aligned to the
'bottom right
Call c.addTitle2(cd.BottomRight, _
    "<*block,valign=absmiddle*><*img=molecule.png*> <*block*><*color=FF*>" & _
    "<*font=mtcorsva.ttf,size=15*>Molecular Engineering<*br*>" & _
    "<*font=verdana.ttf,size=9*>Creating better molecules<*/*>")

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Set 3D style
Call c.set3D()

'Use the side label layout method
Call c.setLabelLayout(cd.SideLayout)

'Set the label background color to transparent
Call c.setLabelStyle().setBackground(cd.Transparent)

'Set the join line color to black
Call c.setJoinLine(0)

'Add icons to the chart as a custom field
Call c.addExtraField(icons)

'Configure the sector labels using CDML to include the icon images
Call c.setLabelFormat( _
    "<*block,valign=absmiddle*><*img={field0}*> {label} ({percent|0}%)")

'Explode the 3rd and 4th sectors as a group (index = 2 and 3)
Call c.setExplodeGroup(2, 3)

'Set the start angle to 135 degrees may improve layout when there are many small
'sectors at the end of the data array (that is, data sorted in descending
'order). It is because this makes the small sectors position near the horizontal
'axis, where the text label has the least tendency to overlap. For data sorted
'in ascending order, a start angle of 45 degrees can be used instead.
Call c.setStartAngle(135)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

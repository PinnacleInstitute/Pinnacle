<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(72, 18, 15, 12)

'The depths for the sectors
depths = Array(30, 20, 10, 10)

'The labels for the pie chart
labels = Array("Sunny", "Cloudy", "Rainy", "Snowy")

'The icons for the sectors
icons = Array("sun.png", "cloud.png", "rain.png", "snowy.png")

'Create a PieChart object of size 400 x 300 pixels, with 0xffeecc as the
'background color, a black border, and 1 pixel 3D border effect
Set c = cd.PieChart(400, 300, &Hffeecc, 0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the center of the pie at (200, 175) and the radius to 100 pixels
Call c.setPieSize(200, 175, 100)

'Add a title box using Times Bold Italic/14 points as font and 0xffcccc as
'background color
Call c.addTitle("Weather Profile in Wonderland", "timesbi.ttf", 14 _
    ).setBackground(&Hffcccc)

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Add icons to the chart as a custom field
Call c.addExtraField(icons)

'Configure the sector labels using CDML to include the icon images
Call c.setLabelFormat( _
    "<*block,valign=absmiddle*><*img={field0}*> <*block*>{label}<*br*>" & _
    "{percent}%<*/*><*/*>")

'Draw the pie in 3D
Call c.set3D2(depths)

'Set the start angle to 225 degrees may improve layout when the depths of the
'sector are sorted in descending order, because it ensures the tallest sector is
'at the back.
Call c.setStartAngle(225)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

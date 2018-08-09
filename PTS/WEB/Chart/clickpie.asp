<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'Get the selected year and month
selectedYear = CInt(Request("year"))
selectedMonth = CInt(Request("x")) + 1

'Get the monthly revenue
monthlyRevenue = CDbl(Request("value"))

'
'  In this demo, we just split the total revenue into 3 parts using random
'  numbers. In real life, the data probably can come from a database.
'
Call Randomize(selectedMonth * 2000 + selectedYear)
ReDim data(2)
data(0) = (Rnd * 0.1 + 0.5) * monthlyRevenue
data(1) = (Rnd * 0.1 + 0.2) * monthlyRevenue
data(2) = monthlyRevenue - data(0) - data(1)

'The labels for the pie chart
labels = Array("Services", "Hardware", "Software")

'Create a PieChart object of size 360 x 260 pixels
Set c = cd.PieChart(360, 260)

'Set the center of the pie at (180, 140) and the radius to 100 pixels
Call c.setPieSize(180, 130, 100)

'Add a title to the pie chart using 13 pts Times Bold Italic font
Call c.addTitle("Revenue Breakdown for " & selectedMonth & "/" & selectedYear, _
    "timesbi.ttf", 13)

'Draw the pie in 3D
Call c.set3D()

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Create the image and save it in a temporary location
chart1URL = c.makeSession(Session, "chart1")

'Create an image map for the chart
imageMap = c.getHTMLImageMap("piestub.asp", "", _
    "title='{label}:USD {value|0}K'")
%>
<html>
<body>
<h1>Simple Clickable Pie Chart</h1>
<p><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
View Source Code
</a></p>

<img src="myimage.asp?<%=chart1URL%>" border="0" usemap="#map1">
<map name="map1">
<%=imageMap%>
</map>
</body>
</html>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'Get the selected year.
selectedYear = Request("xLabel")

'Get the total revenue
totalRevenue = CDbl(Request("value"))

'
'  In this demo, we just split the total revenue into 12 months using random
'  numbers. In real life, the data can come from a database.
'
Call Randomize(CInt(selectedYear))
ReDim data(11)
For i = 0 To 10
    data(i) = totalRevenue * (Rnd * 0.6 + 0.6) / (12 - i)
    totalRevenue = totalRevenue - data(i)
Next
data(11) = totalRevenue

'
'  Now we obtain the data into arrays, we can start to draw the chart using
'  ChartDirector
'

'Create a XYChart object of size 450 x 200 pixels
Set c = cd.XYChart(450, 200)

'Add a title to the chart
Call c.addTitle("Month Revenue for Star Tech for " & selectedYear, _
    "timesbi.ttf")

'Set the plotarea at (60, 5) and of size 350 x 150 pixels. Enable both
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c.setPlotArea(60, 25, 350, 150).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a line chart layer using the data
Set dataSet = c.addLineLayer().addDataSet(data, &H993399)

'Set the line width to 3 pixels
Call dataSet.setLineWidth(3)

'Use a 11 point triangle symbol to plot the data points
Call dataSet.setDataSymbol(cd.TriangleSymbol, 11)

'Set the x axis labels. In this example, the labels must be Jan - Dec.
labels = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", _
    "Oct", "Nov", "Dec")
Call c.xAxis().setLabels(labels)

'Add a title to the x axis to reflect the selected year
Call c.xAxis().setTitle("Year " & selectedYear)

'Add a title to the y axis
Call c.yAxis().setTitle("USD (K)")

'Reserve 10% margin at the top of the plot area just to make sure the line does
'not go too near the top of the plot area
Call c.yAxis().setAutoScale(0.1)

'Create the image and save it in a temporary location
chart1URL = c.makeSession(Session, "chart1")

'Create an image map for the chart
imageMap = c.getHTMLImageMap("clickpie.asp?year=" & selectedYear, "", _
    "title='{xLabel}: USD {value|0}K'")
%>
<html>
<body>
<h1>Simple Clickable Line Chart</h1>
<p><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
View Source Code
</a></p>

<img src="myimage.asp?<%=chart1URL%>" border="0" usemap="#map1">
<map name="map1">
<%=imageMap%>
</map>
</body>
</html>

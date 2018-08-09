<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'
'Get the revenue for the last 10 years
'
SQL = "Select Sum(Software + Hardware + Services), Year(TimeStamp) " & _
	"From Revenue Where TimeStamp >= DateSerial(1991, 1, 1) " & _
	"And TimeStamp < DateSerial(2001, 12, 31) " & _
	"Group By Year(TimeStamp) Order By Year(TimeStamp)"

'
'Read in the revenue data into arrays
'
Set rs = CreateObject("ADODB.RecordSet")
Call rs.Open(SQL, "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & _
	Server.MapPath("sample.mdb"))
Set dbTable = cd.DBTable(rs)
rs.Close()

'
'Now we obtain the data into arrays, we can start to draw the chart 
'using ChartDirector
'	
	
'Create a XYChart of size 420 pixels x 240 pixels
Set c = cd.XYChart(420, 240)

'Set the chart background to pale yellow (0xffffc0) with a 2 pixel 3D border
Call c.setBackground(&Hffffc0, &Hffffc0, 2)

'Set the plotarea at (70, 50) and of size 320 x 150 pixels. Set background
'color to white (0xffffff). Enable both horizontal and vertical grids by
'setting their colors to light grey (0xc0c0c0)
Call c.setPlotArea(70, 50, 320, 150, &Hffffff, &Hffffff, &Hc0c0c0, &Hc0c0c0)

'Add a title to the chart
Call c.addTitle("Revenue for Last 10 Years", "timesbi.ttf" _
	).setBackground(&Hffff00)

'Add a legend box at the top of the plotarea
Call c.addLegend(70, 30, 0, "", 8).setBackground(cd.Transparent)

'Add a multi-color bar chart layer using the supplied data
Set layer = c.addBarLayer3(dbTable.getCol(0))
Call layer.setBorderColor(cd.Transparent, 1)
	
'Set the x-axis labels using the supplied labels
Call c.xAxis().setLabels(dbTable.getCol(1))

'Set the x-axis width to 2 pixels
Call c.xAxis().setWidth(2)

'Set the y axis title
Call c.yAxis().setTitle("USD (K)")

'Set the y-axis width to 2 pixels
Call c.yAxis().setWidth(2)

'Create the image and save it in a session variable
chart1URL = c.makeSession(Session, "chart1")

'Create an image map for the chart
imageMap = c.getHTMLImageMap("dbdemo3a.asp", "", _
    "title='{xLabel}: USD {value|0}K'")
%>
<html>
<body>
<h1>Database Clickable Charts</h1>
<p style="width:500px;">The example demonstrates creating a clickable chart
using data from a database. Click on a bar below to "drill down" onto a 
particular year.</p>

<p><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
	View source code
</a></p>

<img src="myimage.asp?<%=chart1URL%>" border="0" usemap="#map1">
<map name="map1">
<%=imageMap%>
</map>

</body>
</html>

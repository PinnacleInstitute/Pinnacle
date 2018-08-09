<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'
'Displays the monthly revenue for the selected year. The selected year
'should be passed in as a query parameter called "year"
'
SelectedYear = Request("year")
if SelectedYear = "" Then SelectedYear = 2001

'
'Create an SQL statement to get the revenues of each month for the
'selected year. The ArrayIndex will be from 0 - 11, representing Jan - Dec.
'
SQL = "Select Month(TimeStamp) - 1 As ArrayIndex, " & _
      "Software, Hardware, Services " & _
      "From Revenue Where Year(TimeStamp)=" & SelectedYear

'
'Read in the revenue data and pass it to the DBTable object for
'easy conversion into arrays
'
Set rs = CreateObject("ADODB.RecordSet")
Call rs.Open(SQL, "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & _
	Server.MapPath("sample.mdb"))
Set dbTable = cd.DBTable(rs, "ArrayIndex", 12)
rs.Close()

'
'Now we obtain the data into dbTable, we can start to draw the chart 
'using ChartDirector
'	
	
'Create a XYChart of size 420 pixels x 240 pixels, with pale yellow 
'(0xffffc0) background and 2 pixel 3D border
Set c = cd.XYChart(420, 240, &Hffffc0, &Hffffc0, 2)
	
'Set the plotarea at (70, 50) and of size 320 x 150 pixels. Set background
'color to white (0xffffff). Enable both horizontal and vertical grids by
'setting their colors to light grey (0xc0c0c0)
Call c.setPlotArea(70, 50, 320, 150, &Hffffff, &Hffffff, &Hc0c0c0, &Hc0c0c0)

'Add a title to the chart
Call c.addTitle("Revenue for " & SelectedYear, "timesbi.ttf" _
	).setBackground(&Hffff00)

'Add a legend box at the top of the plotarea
Call c.addLegend(70, 30, 0, "", 8).setBackground(cd.Transparent)

'Add a stacked bar chart layer using the supplied data
Set layer = c.addBarLayer2(cd.Stack)
Call layer.addDataSet(dbTable.getCol(1), -1, "Software")
Call layer.addDataSet(dbTable.getCol(2), -1, "Hardware")
Call layer.addDataSet(dbTable.getCol(3), -1, "Services")
Call layer.setBorderColor(cd.Transparent, 1)
	
'Set the x axis labels. In this example, the labels must be Jan - Dec.
labels = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", _
	"Sept", "Oct", "Nov", "Dec")
Call c.xAxis().setLabels(labels)

'Set the x-axis width to 2 pixels
Call c.xAxis().setWidth(2)

'Set the y axis title
Call c.yAxis().setTitle("USD (K)")

'Set the y-axis width to 2 pixels
Call c.yAxis().setWidth(2)

'Output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

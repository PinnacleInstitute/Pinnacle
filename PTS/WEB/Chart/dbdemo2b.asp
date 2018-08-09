<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'
'Retrieve the data from the query parameters
'
SelectedYear = Request("year")
if SelectedYear = "" Then SelectedYear = 2001

software = Split(Request("software"), ",")
hardware = Split(Request("hardware"), ",")
services = Split(Request("services"), ",")

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
Call c.setPlotArea(70, 50, 320, 150, &Hffffff, &Hffffff, &Hc0c0c0, &Hc0c0c0, &Hc0c0c0)

'Add a title to the chart
Call c.addTitle("Revenue for " & SelectedYear, "timesbi.ttf" _
	).setBackground(&Hffff00)

'Add a legend box at the top of the plotarea
Call c.addLegend(70, 30, 0, "", 8).setBackground(cd.Transparent)

'Add a line chart layer using the supplied data
Set layer = c.addLineLayer2()
Call layer.addDataSet(software, -1, "Software").setLineWidth(3)
Call layer.addDataSet(hardware, -1, "Hardware").setLineWidth(3)
Call layer.addDataSet(services, -1, "Services").setLineWidth(3)
	
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

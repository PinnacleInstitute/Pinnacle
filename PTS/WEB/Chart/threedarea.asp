<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the area chart
data = Array(30, 28, 40, 55, 75, 68, 54, 60, 50, 62, 75, 65, 75, 89, 60, 55, _
    53, 35, 50, 66, 56, 48, 52, 65, 62)

'The labels for the area chart
labels = Array("0", "", "", "3", "", "", "6", "", "", "9", "", "", "12", "", _
    "", "15", "", "", "18", "", "", "21", "", "", "24")

'Create a XYChart object of size 300 x 300 pixels
Set c = cd.XYChart(300, 300)

'Set the plotarea at (45, 30) and of size 200 x 200 pixels
Call c.setPlotArea(45, 30, 200, 200)

'Add a title to the chart using 12 pts Arial Bold Italic font
Call c.addTitle("Daily Server Utilization", "arialbi.ttf", 12)

'Add a title to the y axis
Call c.yAxis().setTitle("MBytes")

'Add a title to the x axis
Call c.xAxis().setTitle("June 12, 2001")

'Add a green (0x00ff00) 3D area chart layer using the give data
Call c.addAreaLayer(data, &Hff00).set3D()

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

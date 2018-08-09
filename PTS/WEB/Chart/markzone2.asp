<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(50, 55, 47, 34, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84, 89)

'The labels for the chart. Note the "-" means a minor tick.
labels = Array("0<*br*>Jun 4", "-", "-", "3", "-", "-", "6", "-", "-", "9", _
    "-", "-", "12", "-", "-", "15", "-", "-", "18", "-", "-", "21", "-", "-", _
    "0<*br*>Jun 5")

'Create a XYChart object of size 400 x 270 pixels
Set c = cd.XYChart(400, 270)

'Set the plotarea at (80, 25) and of size 300 x 200 pixels. Use alternate color
'background (0xe0e0e0) and (0xffffff). Set border and grid colors to grey
'(0xc0c0c0).
Call c.setPlotArea(50, 25, 300, 200, &He0e0e0, &Hffffff, &Hc0c0c0, &Hc0c0c0, _
    &Hc0c0c0)

'Add a title to the chart using 14 pts Times Bold Italic font
Call c.addTitle("Server Monitor", "timesbi.ttf", 14)

'Add a title to the y axis
Call c.yAxis().setTitle("Server Load (MBytes)")

'Set the y axis width to 2 pixels
Call c.yAxis().setWidth(2)

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Set the x axis width to 2 pixels
Call c.xAxis().setWidth(2)

'Add a horizontal red (0x800080) mark line at y = 80
Set yMark = c.yAxis().addMark(80, &Hff0000, "Critical Threshold Set Point")

'Set the mark line width to 2 pixels
Call yMark.setLineWidth(2)

'Put the mark label at the top center of the mark line
Call yMark.setAlignment(cd.TopCenter)

'Add an orange (0xffcc66) zone from x = 18 to x = 20
Call c.xAxis().addZone(18, 20, &Hffcc66)

'Add a vertical brown (0x995500) mark line at x = 18
Set xMark1 = c.xAxis().addMark(18, &H995500, "Backup Start")

'Set the mark line width to 2 pixels
Call xMark1.setLineWidth(2)

'Put the mark label at the left of the mark line
Call xMark1.setAlignment(cd.Left)

'Rotate the mark label by 90 degrees so it draws vertically
Call xMark1.setFontAngle(90)

'Add a vertical brown (0x995500) mark line at x = 20
Set xMark2 = c.xAxis().addMark(20, &H995500, "Backup End")

'Set the mark line width to 2 pixels
Call xMark2.setLineWidth(2)

'Put the mark label at the right of the mark line
Call xMark2.setAlignment(cd.Right)

'Rotate the mark label by 90 degrees so it draws vertically
Call xMark2.setFontAngle(90)

'Add a green (0x00cc00) line layer with line width of 2 pixels
Call c.addLineLayer(data, &Hcc00).setLineWidth(2)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

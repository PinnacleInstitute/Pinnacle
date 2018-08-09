<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'query string to determine the starting angle and direction
angle = 0
clockwise = True
If Request("img") <> "0" Then
    angle = 90
    clockwise = False
End If

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Create a PieChart object of size 280 x 240 pixels
Set c = cd.PieChart(280, 240)

'Set the center of the pie at (140, 130) and the radius to 80 pixels
Call c.setPieSize(140, 130, 80)

'Add a title to the pie to show the start angle and direction
If clockwise Then
    Call c.addTitle("Start Angle = " & angle & _
        " degrees<*br*>Direction = Clockwise")
Else
    Call c.addTitle("Start Angle = " & angle & _
        " degrees<*br*>Direction = AntiClockwise")
End If

'Set the pie start angle and direction
Call c.setStartAngle(angle, clockwise)

'Draw the pie in 3D
Call c.set3D()

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Explode the 1st sector (index = 0)
Call c.setExplode(0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

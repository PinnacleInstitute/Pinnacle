<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Facilities", _
    "Production")

'Create a PieChart object of size 300 x 300 pixels
Set c = cd.PieChart(300, 300)

If Request("img") = "0" Then
'============================================================
'    Draw a pie chart where the label is on top of the pie
'============================================================

    'Set the center of the pie at (150, 150) and the radius to 120 pixels
    Call c.setPieSize(150, 150, 120)

    'Set the label position to -40 pixels from the perimeter of the pie (-ve
    'means label is inside the pie)
    Call c.setLabelPos(-40)

Else
'============================================================
'    Draw a pie chart where the label is outside the pie
'============================================================

    'Set the center of the pie at (150, 150) and the radius to 80 pixels
    Call c.setPieSize(150, 150, 80)

    'Set the sector label position to be 20 pixels from the pie. Use a join line
    'to connect the labels to the sectors.
    Call c.setLabelPos(20, cd.LineColor)

End If

'Set the label format to three lines, showing the sector name, value, and
'percentage. The value 999 will be formatted as US$999K.
Call c.setLabelFormat("{label}<*br*>US${value}K<*br*>({percent}%)")

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Explode the 1st sector (index = 0)
Call c.setExplode(0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

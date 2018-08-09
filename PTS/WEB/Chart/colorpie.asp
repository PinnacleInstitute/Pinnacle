<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the pie chart
data = Array(25, 18, 15, 12, 8, 30, 35)

'The labels for the pie chart
labels = Array("Labor", "Licenses", "Taxes", "Legal", "Insurance", _
    "Facilities", "Production")

'Colors of the sectors if custom coloring is used
colors = Array(&Hb8bc9c, &Hecf0b9, &H999966, &H333366, &Hc3c3e6, &H594330, _
    &Ha0bdc4)

'Create a PieChart object of size 280 x 240 pixels
Set c = cd.PieChart(280, 240)

'Set the center of the pie at (140, 120) and the radius to 80 pixels
Call c.setPieSize(140, 120, 80)

'Draw the pie in 3D
Call c.set3D()

'Set the coloring schema
If Request("img") = "0" Then
    Call c.addTitle("Custom Colors")
    'set the LineColor to light gray
    Call c.setColor(cd.LineColor, &Hc0c0c0)
    'use given color array as the data colors (sector colors)
    Call c.setColors2(cd.DataColor, colors)
ElseIf Request("img") = "1" Then
    Call c.addTitle("Dark Background Colors")
    'use the standard white on black palette
    Call c.setColors(cd.whiteOnBlackPalette)
ElseIf Request("img") = "2" Then
    Call c.addTitle("Wallpaper As Background")
    Call c.setWallpaper(Server.MapPath("bg.png"))
Else
    Call c.addTitle("Transparent Colors")
    Call c.setWallpaper(Server.MapPath("bg.png"))
    'use semi-transparent colors to allow the background to be seen
    Call c.setColors(cd.transparentPalette)
End If

'Set the pie data and the pie labels
Call c.setData(data, labels)

'Explode the 1st sector (index = 0)
Call c.setExplode(0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

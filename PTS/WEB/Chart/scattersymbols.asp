<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The XY points for the scatter chart
dataX = Array(200, 400, 300, 250, 500)
dataY = Array(40, 100, 50, 150, 250)

'The custom symbols for the points
symbols = Array("robot1.png", "robot2.png", "robot3.png", "robot4.png", _
    "robot5.png")

'Create a XYChart object of size 450 x 400 pixels
Set c = cd.XYChart(450, 400)

'Set the plotarea at (55, 40) and of size 350 x 300 pixels, with a light grey
'border (0xc0c0c0). Turn on both horizontal and vertical grid lines with light
'grey color (0xc0c0c0)
Call c.setPlotArea(55, 40, 350, 300, -1, -1, &Hc0c0c0, &Hc0c0c0, -1)

'Add a title to the chart using 18 pts Times Bold Itatic font.
Call c.addTitle("Battle Robots", "timesbi.ttf", 18)

'Add a title to the y axis using 12 pts Arial Bold Italic font
Call c.yAxis().setTitle("Speed (km/s)", "arialbi.ttf", 12)

'Add a title to the y axis using 12 pts Arial Bold Italic font
Call c.xAxis().setTitle("Range (km)", "arialbi.ttf", 12)

'Set the axes line width to 3 pixels
Call c.xAxis().setWidth(3)
Call c.yAxis().setWidth(3)

'Add each point of the data as a separate scatter layer, so that they can have a
'different symbol
For i = 0 To UBound(dataX)
    Call c.addScatterLayer(Array(dataX(i)), Array(dataY(i))).getDataSet(0 _
        ).setDataSymbol(Server.MapPath(symbols(i)))
Next

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

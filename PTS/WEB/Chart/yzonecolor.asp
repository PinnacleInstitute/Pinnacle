<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(30, 28, 40, 55, 75, 68, 54, 60, 50, 62, 75, 65, 75, 89, 60, 55, _
    53, 35, 50, 66, 56, 48, 52, 65, 62)

'The labels for the chart
labels = Array("0", "", "", "3", "", "", "6", "", "", "9", "", "", "12", "", _
    "", "15", "", "", "18", "", "", "21", "", "", "24")

'Create a XYChart object of size 500 x 300 pixels, with a pale yellow (0xffffc0)
'background, a black border, and 1 pixel 3D border effect
Set c = cd.XYChart(500, 300, &Hffffc0, &H0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (55, 50) and of size 420 x 205 pixels, with white
'background. Turn on both horizontal and vertical grid lines with light grey
'color (0xc0c0c0)
Call c.setPlotArea(55, 50, 420, 205, &Hffffff).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a legend box at (55, 25) (top of the chart) with horizontal layout. Use 8
'pts Arial font. Set the background and border color to Transparent.
Set legendBox = c.addLegend(55, 25, False, "", 8)
Call legendBox.setBackground(cd.Transparent)

'Add keys to the legend box to explain the color zones
Call legendBox.addKey("Normal Zone", &H8033ff33)
Call legendBox.addKey("Alert Zone", &H80ff3333)

'Add a title box to the chart using 13 pts Arial Bold Italic font. The title is
'in CDML and includes embedded images for highlight. The text is white
'(0xffffff) on a black background, with a 1 pixel 3D border.
Call c.addTitle( _
    "<*block,valign=absmiddle*><*img=star.png*><*img=star.png*> Y Zone " & _
    "Color Demo <*img=star.png*><*img=star.png*><*/*>", "arialbi.ttf", 13, _
    &Hffffff).setBackground(&H0, -1, 1)

'Add a title to the y axis
Call c.yAxis().setTitle("Energy Concentration (KJ per liter)")

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Add a title to the x axis using CDML
Call c.xAxis().setTitle( _
    "<*block,valign=absmiddle*><*img=clock.png*>  Elapsed Time (hour)<*/*>")

'Set the axes width to 2 pixels
Call c.xAxis().setWidth(2)
Call c.yAxis().setWidth(2)

'Add an area layer to the chart. The area is using a y zone color, where the
'color is semi-transparent green below 60, and semi-transparent red above 60.
Set layer = c.addAreaLayer2()
Call layer.addDataSet(data, layer.yZoneColor(60, &H8033ff33, &H80ff3333))

'Add a custom CDML text at the bottom right of the plot area as the logo
Call c.addText(475, 255, _
    "<*block,valign=absmiddle*><*img=small_molecule.png*> <*block*>" & _
    "<*font=timesbi.ttf,size=10,color=804040*>Molecular<*br*>Engineering<*/*>" _
    ).setAlignment(cd.BottomRight)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the area chart
data = Array(30, 28, 40, 55, 75, 68, 54, 60, 50, 62, 75, 65, 75, 89, 60, 55, _
    53, 35, 50, 66, 56, 48, 52, 65, 62)

'The labels for the area chart
labels = Array("0", "", "", "3", "", "", "6", "", "", "9", "", "", "12", "", _
    "", "15", "", "", "18", "", "", "21", "", "", "24")

'Create a XYChart object of size 500 x 300 pixels, using 0xf0e090 as background
'color, with a black border, and 1 pixel 3D border effect
Set c = cd.XYChart(500, 300, &Hf0e090, &H0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (55, 50) and of size 420 x 205 pixels, with white
'background. Set border and grid line colors to 0xa08040.
Call c.setPlotArea(55, 50, 420, 205, &Hffffff, -1, &Ha08040, &Ha08040, _
    &Ha08040)

'Add a title box to the chart using 13 pts Arial Bold Italic font. The title is
'in CDML and includes embedded images for highlight. The text is white
'(0xffffff) on a brown (0x807040) background, with a 1 pixel 3D border.
Call c.addTitle( _
    "<*block,valign=absmiddle*><*img=star.png*><*img=star.png*> " & _
    "Performance Enhancer <*img=star.png*><*img=star.png*><*/*>", _
    "arialbi.ttf", 13, &Hffffff).setBackground(&H807040, -1, 1)

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

'Add an area layer to the chart using a semi-transparent gradient color
Call c.addAreaLayer(data, c.gradientColor(0, 50, 0, 255, &H40ff8000, _
    &H40ffffff))

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

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the upper and lower bounding lines
upperY = Array(60, 60, 100, 100, 60, 60)
lowerY = Array(40, 40, 80, 80, 40, 40)
zoneX = Array(0, 2.5, 3.5, 5.5, 6.5, 10)

'The data for the spline curve
curveY = Array(50, 44, 54, 48, 58, 50, 90, 85, 104, 82, 96, 90, 74, 52, 35, _
    58, 46, 54, 48, 52, 50)
curveX = Array(0, 0.5, 1, 1.5, 2, 2.5, 3.0, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, _
    7.5, 8, 8.5, 9, 9.5, 10)

'Create a XYChart object of size 600 x 300 pixels, with a light grey (0xc0c0c0)
'background, a black border, and 1 pixel 3D border effect.
Set c = cd.XYChart(600, 300, &Hc0c0c0, 0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (55, 50) and of size 520 x 205 pixels, with white
'background. Turn on both horizontal and vertical grid lines with light grey
'color (0xc0c0c0)
Call c.setPlotArea(55, 50, 520, 205, &Hffffff, -1, -1, &Hc0c0c0, &Hc0c0c0)

'Add a legend box at (55, 25) (top of the chart) with horizontal layout. Use 8
'pts Arial font. Set the background and border color to Transparent.
Call c.addLegend(55, 25, False, "", 8).setBackground(cd.Transparent)

'Add a title box to the chart using 13 pts Arial Bold Italic font. The title is
'in CDML and includes embedded images for highlight. The text is white
'(0xffffff) on a black background, with a 1 pixel 3D border.
Call c.addTitle( _
    "<*block,valign=absmiddle*><*img=star.png*><*img=star.png*> " & _
    "Performance Enhancer <*img=star.png*><*img=star.png*><*/*>", _
    "arialbi.ttf", 13, &Hffffff).setBackground(&H0, -1, 1)

'Add a title to the y axis
Call c.yAxis().setTitle("Temperature")

'Add a title to the x axis using CMDL
Call c.xAxis().setTitle( _
    "<*block,valign=absmiddle*><*img=clock.png*>  Elapsed Time (hour)<*/*>")

'Set the axes width to 2 pixels
Call c.xAxis().setWidth(2)
Call c.yAxis().setWidth(2)

'Add a purple (0x800080) spline layer to the chart with a line width of 2 pixels
Set splineLayer = c.addSplineLayer(curveY, &H800080, "Molecular Temperature")
Call splineLayer.setXData(curveX)
Call splineLayer.setLineWidth(2)

'Add a line layer to the chart with two dark green (0x338033) data sets, and a
'line width of 2 pixels
Set lineLayer = c.addLineLayer2()
Call lineLayer.addDataSet(upperY, &H338033, "Target Zone")
Call lineLayer.addDataSet(lowerY, &H338033)
Call lineLayer.setXData(zoneX)
Call lineLayer.setLineWidth(2)

'Color the zone between the upper zone line and lower zone line as
'semi-transparent light green (0x8099ff99)
Call c.addInterLineLayer(lineLayer.getLine(0), lineLayer.getLine(1), _
    &H8099ff99, &H8099ff99)

'If the spline line gets above the upper zone line, color to area between the
'lines red (0xff0000)
Call c.addInterLineLayer(splineLayer.getLine(0), lineLayer.getLine(0), _
    &Hff0000, cd.Transparent)

'If the spline line gets below the lower zone line, color to area between the
'lines blue (0xff)
Call c.addInterLineLayer(splineLayer.getLine(0), lineLayer.getLine(1), _
    cd.Transparent, &Hff)

'Add a custom CDML text at the bottom right of the plot area as the logo
Call c.addText(575, 255, _
    "<*block,valign=absmiddle*><*img=small_molecule.png*> <*block*>" & _
    "<*font=timesbi.ttf,size=10,color=804040*>Molecular<*br*>Engineering<*/*>" _
    ).setAlignment(cd.BottomRight)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

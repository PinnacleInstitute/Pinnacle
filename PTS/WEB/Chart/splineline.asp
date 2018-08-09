<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(32, 39, 23, 28, 41, 36)
data1 = Array(50, 55, 47, 34, 47, 56)

'The labels for the chart
labels = Array("0", "1", "2", "3", "4", "5")

'Create a XYChart object of size 500 x 300 pixels, using 0xf0e090 as the
'background color, with a black border, and 1 pixel 3D border effect.
Set c = cd.XYChart(500, 300, &Hf0e090, &H0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (55, 50) and of size 420 x 205 pixels, using 0xfff0c0 as
'the plot area background color, and 0xa08040 as the grid and border colors.
'Turn on both horizontal and vertical grid lines with light grey color
'(0xc0c0c0)
Call c.setPlotArea(55, 50, 420, 205, &Hfff0c0, -1, &Ha08040, &Ha08040, _
    &Ha08040)

'Add a legend box at (55, 25) (top of the chart) with horizontal layout. Use 8
'pts Arial font. Set the background and border color to Transparent.
Call c.addLegend(55, 25, False, "", 8).setBackground(cd.Transparent)

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

'Add a title to the x axis using CMDL
Call c.xAxis().setTitle( _
    "<*block,valign=absmiddle*><*img=clock.png*>  Elapsed Time (hour)<*/*>")

'Set the axes width to 2 pixels
Call c.xAxis().setWidth(2)
Call c.yAxis().setWidth(2)

'Add a spline layer to the chart
Set layer = c.addSplineLayer()

'Set the default line width to 2 pixels
Call layer.setLineWidth(2)

'Add a data set to the spline layer, using blue (0xc0) as the line color, with
'yellow (0xffff00) circle symbols.
Call layer.addDataSet(data1, &Hc0, "Target Group").setDataSymbol( _
    cd.CircleSymbol, 9, &Hffff00)

'Add a data set to the spline layer, using brown (0x982810) as the line color,
'with pink (0xf040f0) diamond symbols.
Call layer.addDataSet(data0, &H982810, "Control Group").setDataSymbol( _
    cd.DiamondSymbol, 9, &Hf040f0)

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

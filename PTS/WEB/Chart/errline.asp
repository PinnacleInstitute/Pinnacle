<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data with error information
data = Array(42, 49, 33, 38, 51, 46, 29, 41, 44, 57, 59, 52, 37, 34, 51, 56, _
    56, 60, 70, 76, 63, 67, 75, 64, 51)
errData = Array(5, 6, 5.1, 6.5, 6.6, 8, 5.4, 5.1, 4.6, 5.0, 5.2, 6.0, 4.9, _
    5.6, 4.8, 6.2, 7.4, 7.1, 6.0, 6.6, 7.1, 5.3, 5.5, 7.9, 6.1)

'The labels for the chart
labels = Array("0", "-", "-", "3", "-", "-", "6", "-", "-", "9", "-", "-", _
    "12", "-", "-", "15", "-", "-", "18", "-", "-", "21", "-", "-", "24")

'Create a XYChart object of size 600 x 300 pixels, with a light grey (0xc0c0c0)
'background, a black border, and 1 pixel 3D border effect.
Set c = cd.XYChart(600, 300, &Hc0c0c0, 0, 1)

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (55, 45) and of size 520 x 205 pixels, with white
'background. Turn on both horizontal and vertical grid lines with light grey
'color (0xc0c0c0)
Call c.setPlotArea(55, 45, 520, 210, &Hffffff, -1, -1, &Hc0c0c0, &Hc0c0c0)

'Add a title box to the chart using 13 pts Arial Bold Italic font. The title is
'in CDML and includes embedded images for highlight. The text is white
'(0xffffff) on a black background, with a 1 pixel 3D border.
Call c.addTitle( _
    "<*block,valign=absmiddle*><*img=star.png*><*img=star.png*> Molecular " & _
    "Temperature Control <*img=star.png*><*img=star.png*><*/*>", _
    "arialbi.ttf", 13, &Hffffff).setBackground(&H0, -1, 1)

'Add a title to the y axis
Call c.yAxis().setTitle("Temperature")

'Add a title to the x axis using CMDL
Call c.xAxis().setTitle( _
    "<*block,valign=absmiddle*><*img=clock.png*>  Elapsed Time (hour)<*/*>")

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Set the axes width to 2 pixels
Call c.xAxis().setWidth(2)
Call c.yAxis().setWidth(2)

'Add a line layer to the chart
Set lineLayer = c.addLineLayer2()

'Add a blue (0xff) data set to the line layer, with yellow (0xffff80) diamond
'symbols
Call lineLayer.addDataSet(data, &Hff).setDataSymbol(cd.DiamondSymbol, 12, _
    &Hffff80)

'Set the line width to 2 pixels
Call lineLayer.setLineWidth(2)

'Add a box whisker layer to the chart. Use only the upper and lower mark of the
'box whisker layer to act as error zones. The upper and lower marks are computed
'using the ArrayMath object.
Set errLayer = c.addBoxWhiskerLayer(Null, Null, cd.ArrayMath(data).add(errData _
    ).result(), cd.ArrayMath(data).subtract(errData).result(), Null, _
    cd.Transparent, &Hbb6633)

'Set the line width to 2 pixels
Call errLayer.setLineWidth(2)

'Set the error zone to occupy half the space between the symbols
Call errLayer.setDataGap(0.5)

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

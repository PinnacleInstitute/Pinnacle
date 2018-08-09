<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'Use random table to generate a random series. The random table is set to 1 col
'x 51 rows, with 9 as the seed
Set rantable = cd.RanTable(9, 1, 51)

'Set the 1st column to start from 100, with changes between rows from -5 to +5
Call rantable.setCol(0, 100, -5, 5)

'Get the 1st column of the random table as the data set
data = rantable.getCol(0)

'Create a XYChart object of size 600 x 300 pixels
Set c = cd.XYChart(600, 300)

'Set the plotarea at (50, 35) and of size 500 x 240 pixels. Enable both the
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c.setPlotArea(50, 35, 500, 240).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a title to the chart using 18 point Times Bold Itatic font.
Call c.addTitle("LOWESS Generic Curve Fitting Algorithm", "timesbi.ttf", 18)

'Set the y axis line width to 3 pixels
Call c.yAxis().setWidth(3)

'Add a title to the x axis using 12 pts Arial Bold Italic font
Call c.xAxis().setTitle("Server Load (TPS)", "arialbi.ttf", 12)

'Set the x axis line width to 3 pixels
Call c.xAxis().setWidth(3)

'Set the x axis scale from 0 - 50, with major tick every 5 units and minor tick
'every 1 unit
Call c.xAxis().setLinearScale(0, 50, 5, 1)

'Add a blue layer to the chart
Set layer = c.addLineLayer2()

'Add a red (0x80ff0000) data set to the chart with square symbols
Call layer.addDataSet(data, &H80ff0000).setDataSymbol(cd.SquareSymbol)

'Set the line width to 2 pixels
Call layer.setLineWidth(2)

'Use lowess for curve fitting, and plot the fitted data using a spline layer
'with line width set to 3 pixels
Call c.addSplineLayer(cd.ArrayMath(data).lowess().result(), &Hff _
    ).setLineWidth(3)

'Set zero affinity to 0 to make sure the line is displayed in the most detail
'scale
Call c.yAxis().setAutoScale(0, 0, 0)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

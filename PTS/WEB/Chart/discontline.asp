<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'===================================================================
'    For demo purpose, use random numbers as data for the chart
'===================================================================

'Use a random table to create the data. The random table contains 4 cols x 31
'rows, using 9 as seed.
Set rantable = cd.RanTable(9, 4, 31)

'Set the 1st col to be the series 1, 2, 3, ....
Call rantable.setCol(0, 1, 1, 1)

'Set the 2nd, 3rd and 4th col to be random number starting from 40, 50 and 60.
'The change between rows is set to -5 to 5. The minimum value of any cell is 0.
Call rantable.setCol(1, 40, -5, 5, 0)
Call rantable.setCol(2, 50, -5, 5, 0)
Call rantable.setCol(3, 60, -5, 5, 0)

'Use the 1st col as the axis label
labels = rantable.getCol(0)

'Use the 2nd, 3rd and 4th columns for 3 lines
data0 = rantable.getCol(1)
data1 = rantable.getCol(2)
data2 = rantable.getCol(3)

'Simulate some data points have no data value
For i = 1 To 29 Step 7
    data0(i) = cd.NoValue
    data1(i) = cd.NoValue
    data2(i) = cd.NoValue
Next

'===================================================================
'    Now we have the data ready. Actually drawing the chart.
'===================================================================

'Create a XYChart object of size 600 x 220 pixels
Set c = cd.XYChart(600, 220)

'Set the plot area at (100, 25) and of size 450 x 150 pixels. Enabled both
'vertical and horizontal grids by setting their colors to light grey (0xc0c0c0)
Call c.setPlotArea(100, 25, 450, 150).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a legend box (92, 0) (top of plot area) using horizontal layout. Use 8 pts
'Arial font. Disable bounding box (set border to transparent).
Call c.addLegend(92, 0, False, "", 8).setBackground(cd.Transparent)

'Add a title to the y axis. Draw the title upright (font angle = 0)
Call c.yAxis().setTitle("Average<*br*>Utilization<*br*>(MBytes)" _
    ).setFontAngle(0)

'Use manually scaling of y axis from 0 to 100, with ticks every 10 units
Call c.yAxis().setLinearScale(0, 100, 10)

'Set the labels on the x axis
Call c.xAxis().setLabels2(labels)

'Set the title on the x axis
Call c.xAxis().setTitle("Jun - 2001")

'Add x axis (vertical) zones to indicate Saturdays and Sundays
For i = 0 To 28 Step 7
    Call c.xAxis().addZone(i, i + 2, &Hc0c0c0)
Next

'Add a line layer to the chart
Set layer = c.addLineLayer()

'Set the default line width to 2 pixels
Call layer.setLineWidth(2)

'Add the three data sets to the line layer
Call layer.addDataSet(data0, &Hcf4040, "Server #1")
Call layer.addDataSet(data1, &H40cf40, "Server #2")
Call layer.addDataSet(data2, &H4040cf, "Server #3")

'Layout the chart to fix the y axis scaling. We can then use getXCoor and
'getYCoor to determine the position of custom objects.
Call c.layout()

'Add the "week n" custom text boxes at the top of the plot area.
For i = 0 To 3
    'Add the "week n" text box using 8 pt Arial font with top center alignment.
    Set textbox = c.addText(layer.getXCoor(i * 7 + 2), 25, "Week " & i, _
        "arialbd.ttf", 8, &H0, cd.TopCenter)

    'Set the box width to cover five days
    Call textbox.setSize(layer.getXCoor(i * 7 + 7) - layer.getXCoor(i * 7 + 2) _
         + 1, 0)

    'Set box background to pale yellow 0xffff80, with a 1 pixel 3D border
    Call textbox.setBackground(&Hffff80, cd.Transparent, 1)
Next

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data = Array(40, 15, 7, 5, 2)

'The labels for the chart
labels = Array("Hard Disk", "PCB", "Printer", "CDROM", "Keyboard")

'Create a XYChart object of size 400 x 225 pixels
Set c = cd.XYChart(400, 225)

'Set the background color of the chart to gold (goldGradient). Use a 2 pixel 3D
'border.
Call c.setBackground(c.gradientColor(cd.goldGradient), -1, 2)

'Add a title box using 11 point Arial Bold font. Set the background color to
'blue metallic (blueMetalGradient). Use a 1 pixel 3D border.
Call c.addTitle("Hardware Defects", "arialbd.ttf", 11).setBackground( _
    c.gradientColor(cd.blueMetalGradient), -1, 1)

'Set the plotarea at (50, 40) and of 300 x 150 pixels in size. Use 0x80ccccff as
'the background color.
Call c.setPlotArea(50, 40, 300, 150, &H80ccccff)

'Add a line layer for the pareto line
Set layer = c.addLineLayer()

'Compute the pareto line by accumulating the data
Set lineData = cd.ArrayMath(data)
Call lineData.acc()

'Set a scaling factor such as the maximum point of the line is scaled to 100
scaleFactor = 100 / lineData.max()

'Add the pareto line using the scaled data. Use deep blue (0x80) as the line
'color, with light blue (0x9999ff) diamond symbols
Call layer.addDataSet(lineData.mul2(scaleFactor).result(), &H80 _
    ).setDataSymbol(cd.DiamondSymbol, 9, &H9999ff)

'Set the line width to 2 pixel
Call layer.setLineWidth(2)

'Add a multi-color bar layer using the given data. Bind the layer to the
'secondary (right) y-axis.
Call c.addBarLayer3(data).setUseYAxis2()

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'Set the primary y-axis scale as 0 - 100 with a tick every 20 units
Call c.yAxis().setLinearScale(0, 100, 20)

'Set the label format of the y-axis label to include a percentage sign
Call c.yAxis().setLabelFormat("{value}%")

'Add a title to the secondary y-axis
Call c.yAxis2().setTitle("Frequency")

'Set the secondary y-axis label foramt to show no decimal point
Call c.yAxis2().setLabelFormat("{value|0}")

'Set the relationship between the two y-axes, which only differ by a scaling
'factor
Call c.syncYAxis(1 / scaleFactor)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

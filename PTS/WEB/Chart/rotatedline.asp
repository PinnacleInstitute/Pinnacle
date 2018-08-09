<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'
'    We use a random table to simulate generating 12 months of data
'

'Create the random table object with 4 cols * 12 rows, using 3 as seed
Set rantable = cd.RanTable(3, 4, 12)

'Set the 1st column to be the 12 months of year 2002
Call rantable.setDateCol(0, DateSerial(2002, 1, 1), 86400 * 30)

'Set the 2nd, 3rd and 4th columns to be random numbers starting from 125, 75,
'and 100 respectively. The change between rows is set to -35 to + 35. The
'minimum value of any cell is 0.
Call rantable.setCol(1, 125, -35, 35, 0)
Call rantable.setCol(2, 75, -35, 35, 0)
Call rantable.setCol(3, 100, -35, 35, 0)

'Get the 1st column (time) as the x data
dataX = rantable.getCol(0)

'Get the 2nd, 3rd and 4th columns as 3 data sets
dataY0 = rantable.getCol(1)
dataY1 = rantable.getCol(2)
dataY2 = rantable.getCol(3)

'Create a XYChart object of size 360 x 400 pixels
Set c = cd.XYChart(360, 400)

'Add a title to the chart
Call c.addTitle("<*underline=2*>Rotated Line Chart Demo", "timesbi.ttf", 14)

'Set the plotarea at (60, 75) and of size 190 x 320 pixels. Turn on both
'horizontal and vertical grid lines with light grey color (0xc0c0c0)
Call c.setPlotArea(60, 75, 190, 320).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a legend box at (270, 75)
Call c.addLegend(270, 75)

'Swap the x and y axis to become a rotated chart
Call c.swapXY()

'Set the y axis on the top side (right + rotated = top)
Call c.setYAxisOnRight()

'Add a title to the y axis
Call c.yAxis().setTitle("Throughput (MBytes)")

'Reverse the x axis so it is pointing downwards
Call c.xAxis().setReverse()

'Add a line chart layer using the given data
Set layer = c.addLineLayer2()
Call layer.setXData(dataX)
Call layer.addDataSet(dataY0, &Hff0000, "Server A")
Call layer.addDataSet(dataY1, &H338033, "Server B")
Call layer.addDataSet(dataY2, &Hff, "Server C")

'Set the line width to 2 pixels
Call layer.setLineWidth(2)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

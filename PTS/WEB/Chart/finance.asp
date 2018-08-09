<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'Create a finance chart demo containing 100 days of data
noOfDays = 100

'To compute moving averages, we need to get data points before the first day
extraDays = 30

'We use a random table to simulate the data from a database. The random table
'contains 6 cols x (noOfDays + extraDays) rows, using 9 as the seed.
Set rantable = cd.RanTable(9, 6, noOfDays + extraDays)

'Set the 1st col to be the timeStamp, starting from Sep 4, 2002, with each row
'representing one day, and counting week days only (jump over Sat and Sun)
Call rantable.setDateCol(0, DateSerial(2002, 9, 4), 86400, True)

'Set the 2nd, 3rd, 4th and 5th columns to be high, low, open and close data. The
'open value starts from 1800, and the daily change is random from -5 to 5.
Call rantable.setHLOCCols(1, 1800, -5, 5)

'Set the 6th column as the vol data from 50 to 250
Call rantable.setCol(5, 50, 250)

'Now we read the data from the table into arrays
timeStamps = rantable.getCol(0)
highData = rantable.getCol(1)
lowData = rantable.getCol(2)
openData = rantable.getCol(3)
closeData = rantable.getCol(4)
volData = rantable.getCol(5)

'To create the date labels for the x axis, we need to trim extraDays at the
'beginning. Also, we select only the dates that represent the first date in the
'month as labels.
labels = cd.ArrayMath(timeStamps).trim(extraDays).selectStartOfMonth().result()

'Similarly, for the volume data, we need to trim extraDays at the beginning
volData = cd.ArrayMath(volData).trim(extraDays).result()

'==========================================================================
'    Create the top chart
'==========================================================================

'Create a XYChart object of size 600 x 210 pixels
Set c = cd.XYChart(600, 210, cd.Transparent)

'Set the plotarea at (50, 20) and of size 500 x 180 pixels. Enable both the
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c.setPlotArea(50, 20, 500, 180).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a horizontal legend box at (50, 15) and set its border and background
'colors to transparent
Call c.addLegend(50, 15, False, "arial.ttf", 7.5).setBackground(cd.Transparent)

'Add an HLOC layer using blue (0x80) color. We need to trim extraDays at the
'beginning as these days are just for computing moving averages.
Call c.addHLOCLayer(cd.ArrayMath(highData).trim(extraDays).result(), _
    cd.ArrayMath(lowData).trim(extraDays).result(), cd.ArrayMath(openData _
    ).trim(extraDays).result(), cd.ArrayMath(closeData).trim(extraDays _
    ).result(), &H80)

'Add line layers representing 5 days and 20 days moving averages.
Call c.addLineLayer(cd.ArrayMath(closeData).movAvg(5).trim(extraDays).result( _
    ), &Hff0000, "Moving Average (5 days)")
Call c.addLineLayer(cd.ArrayMath(closeData).movAvg(20).trim(extraDays).result( _
    ), &Hff00ff, "Moving Average (20 days)")

'Compute Bollinger Band as closeData +/- 2 * standard_deviation
stdDev2 = cd.ArrayMath(closeData).movStdDev(20).mul(2).result()
upperBand = cd.ArrayMath(closeData).add(stdDev2).trim(extraDays).result()
lowerBand = cd.ArrayMath(closeData).subtract(stdDev2).trim(extraDays).result()

'Add the upper and lower lines for the bollinger band
Set uLayer = c.addLineLayer(upperBand, &H66ff66, "Bollinger Band")
Set lLayer = c.addLineLayer(lowerBand, &H66ff66)

'Color the region between the bollinger lines with semi-transparent green
Call c.addInterLineLayer(uLayer.getLine(), lLayer.getLine(), &Hc066ff66)

'Add labels to the x axis formatted as mm/yyyy
Call c.xAxis().setLabels2(labels, "{value|mm/yyyy}")

'For the top chart, the x axis is on top
Call c.setXAxisOnTop()

'==========================================================================
'    Create the middle chart (volume chart)
'==========================================================================

'Create a XYChart object of size 600 x 80 pixels
Set c2 = cd.XYChart(600, 80, cd.Transparent)

'Set the plotarea at (50, 10) and of size 500 x 50) pixels. Enable both the
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c2.setPlotArea(50, 10, 500, 50).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a horizontal legend box at (50, 5) and set its border and background colors
'to transparent
Call c2.addLegend(50, 5, False, "arial.ttf", 7.5).setBackground(cd.Transparent)

'Compute an array to represent the closing price changes
closeChange = cd.ArrayMath(closeData).delta().trim(extraDays).result()

'Select the volume data for "up" days. An up day is a day where the closing
'price is higher than the preivous day. Use the selected data for a green bar
'layer.
Call c2.addBarLayer(cd.ArrayMath(volData).selectGTZ(closeChange).result(), _
    &Hff00, "Vol (Up days)").setBorderColor(cd.Transparent)

'Select the volume data for "down" days. An up day is a day where the closing
'price is lower than the preivous day. Use the selected data for a red bar
'layer.
Call c2.addBarLayer(cd.ArrayMath(volData).selectLTZ(closeChange).result(), _
    &Hff0000, "Vol (Down days)").setBorderColor(cd.Transparent)

'Select the volume data for days when closing prices are unchanged. Use the
'selected data for a grey bar layer.
Call c2.addBarLayer(cd.ArrayMath(volData).selectEQZ(closeChange).result(), _
    &H808080, "Vol (No change)").setBorderColor(cd.Transparent)

'Add labels to the x axis. We do not really need the label text, but we need the
'grid line associated the labels
Call c2.xAxis().setLabels2(labels)

'We set the label and tick colors to transparent as we do not need them
Call c2.xAxis().setColors(cd.LineColor, cd.Transparent, cd.Transparent, _
    cd.Transparent)

'==========================================================================
'    Create the bottom chart (RSI chart)
'==========================================================================

'Create a XYChart object of size 600 x 120 pixels
Set c3 = cd.XYChart(600, 120, cd.Transparent)

'Set the plotarea at (50, 10) and of size 500 x 50) pixels. Enable both the
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c3.setPlotArea(50, 10, 500, 50).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a horizontal legend box at (50, 5) and set its border and background colors
'to transparent
Call c3.addLegend(50, 5, False, "arial.ttf", 7.5).setBackground(cd.Transparent)

'RSI is defined as the average up changes for the last 14 days, divided by the
'average absolute changes for the last 14 days, expressed as a percentage.

'Use the delta method to get the changes between subsequent days, then use
'selectGTZ to get the up days only, and compute the 14 days moving average
upChange = cd.ArrayMath(closeData).delta().selectGTZ().movAvg(14).result()

'Similar, compute the 14 days moving average of the absolute changes
absChange = cd.ArrayMath(closeData).delta().absolute().movAvg(14).result()

'Compute RSI as the ratio of the above two moving averages, expressed as
'percentage
rsi = cd.ArrayMath(upChange).div(absChange).trim(extraDays).mul(100).result()

'Add RSI as a line layer
Set rsiLine = c3.addLineLayer(rsi, &H800080, "RSI (14 days)")

'Add a blue (0xff) mark at 30
Set mark30 = c3.yAxis().addMark(30, &Hff, "30")

'Add a red (0xff0000) mark at 70
Set mark70 = c3.yAxis().addMark(70, &Hff0000, "70")

'If the RSI line gets above the upper mark line, color the region between the
'lines as red (0xff0000)
Call c3.addInterLineLayer(rsiLine.getLine(), mark70.getLine(), &Hff0000, _
    cd.Transparent)

'If the RSI line gets below the lower mark line, color the region between the
'lines as blue (0xff)
Call c3.addInterLineLayer(rsiLine.getLine(), mark30.getLine(), cd.Transparent, _
    &Hff)

'Set the y axis scale as 0 - 100, with tick at 50
Call c3.yAxis().setLinearScale(0, 100, 50)

'We need to explicitly set the indent mode axis. By default, line layers are not
'indented, but we need it to be indented so the x axis will synchronize with the
'top and middle charts
Call c3.xAxis().setIndent(True)

'Add labels to the x axis formatted as mm/yyyy
Call c3.xAxis().setLabels2(labels, "{value|mm/yyyy}")

'==========================================================================
'    Combine the charts together using a MultiChart
'==========================================================================

'Create a MultiChart object of size 600 x 400 pixels
Set m = cd.MultiChart(600, 400)

'Add a title to the chart
Call m.addTitle("Finance Chart Demonstration")

'Add the 3 charts to the multi-chart
Call m.addChart(0, 30, c)
Call m.addChart(0, 235, c2)
Call m.addChart(0, 300, c3)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite m.makeChart2(cd.PNG)
Response.End
%>

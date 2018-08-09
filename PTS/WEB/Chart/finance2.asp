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

'Add a candle stick layer using green/red (0xff00/0xff0000) for up/down candles,
'and with data gap set to 0 to maximize the candle width. We need to trim
'extraDays at the beginning as these days are just for computing moving
'averages.
Call c.addCandleStickLayer(cd.ArrayMath(highData).trim(extraDays).result(), _
    cd.ArrayMath(lowData).trim(extraDays).result(), cd.ArrayMath(openData _
    ).trim(extraDays).result(), cd.ArrayMath(closeData).trim(extraDays _
    ).result(), &Hff00, &Hff0000).setDataGap(0)

'Add line layers representing 10 days and 20 days moving averages.
Call c.addLineLayer(cd.ArrayMath(closeData).movAvg(10).trim(extraDays).result( _
    ), &H663300, "Moving Average (10 days)")
Call c.addLineLayer(cd.ArrayMath(closeData).movAvg(20).trim(extraDays).result( _
    ), &H9900ff, "Moving Average (20 days)")

'Donchian Channel is the zone between the maximum and minimum values in the last
'20 days
upperBand = cd.ArrayMath(highData).movMax(20).trim(extraDays).result()
lowerBand = cd.ArrayMath(lowData).movMin(20).trim(extraDays).result()

'Add the upper and lower lines for the Donchian Channel
Set uLayer = c.addLineLayer(upperBand, &H9999ff, "Donchian Channel")
Set lLayer = c.addLineLayer(lowerBand, &H9999ff)

'Color the region between the bollinger lines with semi-transparent blue
Call c.addInterLineLayer(uLayer.getLine(), lLayer.getLine(), &Hc06666ff)

'Add labels to the x axis formatted as mm/yyyy
Call c.xAxis().setLabels2(labels, "{value|mm/yyyy}")

'For the top chart, the x axis is on top
Call c.setXAxisOnTop()

'==========================================================================
'    Create the volume chart (the bottom part of the top chart)
'==========================================================================

'Create a XYChart object of size 600 x 80 pixels
Set c2 = cd.XYChart(600, 80, cd.Transparent)

'Set the plotarea at (50, 10) and of size 500 x 50) pixels. Set the background,
'border and grid colors to transparent
Call c2.setPlotArea(50, 10, 500, 50, cd.Transparent, -1, cd.Transparent, _
    cd.Transparent, cd.Transparent)

'Compute an array to represent the closing price changes
closeChange = cd.ArrayMath(closeData).delta().trim(extraDays).result()

'Select the volume data for "up" days. An up day is a day where the closing
'price is higher than the preivous day. Use the selected data for a green bar
'layer.
Call c2.addBarLayer(cd.ArrayMath(volData).selectGTZ(closeChange).result(), _
    &H99ff99, "Vol (Up days)").setBorderColor(cd.Transparent)

'Select the volume data for "down" days. An up day is a day where the closing
'price is lower than the preivous day. Use the selected data for a red bar
'layer.
Call c2.addBarLayer(cd.ArrayMath(volData).selectLTZ(closeChange).result(), _
    &Hff9999, "Vol (Down days)").setBorderColor(cd.Transparent)

'Select the volume data for days when closing prices are unchanged. Use the
'selected data for a grey bar layer.
Call c2.addBarLayer(cd.ArrayMath(volData).selectEQZ(closeChange).result(), _
    &Hc0c0c0, "Vol (No change)").setBorderColor(cd.Transparent)

'Set the primary y-axis on the right side
Call c2.setYAxisOnRight()

'==========================================================================
'    Create the middle chart (MACD chart)
'==========================================================================

'Create a XYChart object of size 600 x 80 pixels
Set c3 = cd.XYChart(600, 80, cd.Transparent)

'Set the plotarea at (50, 10) and of size 500 x 50) pixels. Enable both the
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c3.setPlotArea(50, 10, 500, 50).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a horizontal legend box at (50, 5) and set its border and background colors
'to transparent
Call c3.addLegend(50, 5, False, "arial.ttf", 7.5).setBackground(cd.Transparent)

'MACD is defined as the difference between 12 days and 26 days exponential
'averages (decay factor = 0.15 and 0.075)
expAvg26 = cd.ArrayMath(closeData).expAvg(0.075).result()
macd = cd.ArrayMath(closeData).expAvg(0.15).subtract(expAvg26).result()

'Add the MACD line using blue (0xff) color
Call c3.addLineLayer(cd.ArrayMath(macd).trim(extraDays).result(), &Hff, "MACD")

'MACD histogram is defined as the MACD minus its 9 days exponential average
'(decay factor = 0.2)
macd9 = cd.ArrayMath(macd).expAvg(0.2).result()

'Add the 9 days exponential average line using purple color (0xff00ff)
Call c3.addLineLayer(cd.ArrayMath(macd9).trim(extraDays).result(), &Hff00ff)

'Add MACD histogram as a bar layer using green color (0x8000). Set bar border to
'transparent.
Call c3.addBarLayer(cd.ArrayMath(macd).subtract(macd9).trim(extraDays).result( _
    ), &H8000, "MACD Histogram").setBorderColor(cd.Transparent)

'Add labels to the x axis. We do not really need the label text, but we need the
'grid line associated the labels
Call c3.xAxis().setLabels2(labels)

'We set the label and tick colors to transparent as we do not need them
Call c3.xAxis().setColors(cd.LineColor, cd.Transparent, cd.Transparent, _
    cd.Transparent)

'==========================================================================
'    Create the bottom chart (Stochastic chart)
'==========================================================================

'Create a XYChart object of size 600 x 120 pixels
Set c4 = cd.XYChart(600, 120, cd.Transparent)

'Set the plotarea at (50, 10) and of size 500 x 50) pixels. Enable both the
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c4.setPlotArea(50, 10, 500, 50).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a horizontal legend box at (50, 5) and set its border and background colors
'to transparent
Call c4.addLegend(50, 5, False, "arial.ttf", 7.5).setBackground(cd.Transparent)

'Stochastic is defined as (close - moving_low) / (moving_high - moving_low) x
'100. We use 14 days as the period for moving computations.
movLow = cd.ArrayMath(lowData).movMin(14).result()
movRange = cd.ArrayMath(highData).movMax(14).subtract(movLow).result()
stochastic = cd.ArrayMath(closeData).subtract(movLow).div(movRange).mul(100 _
    ).result()

'Traditional, for fast Stochastic chart, we draw both the Stochastic line and
'its 3 days moving average
Call c4.addLineLayer(cd.ArrayMath(stochastic).trim(extraDays).result(), _
    &H6060, "Stochastic (14)")
Call c4.addLineLayer(cd.ArrayMath(stochastic).movAvg(3).trim(extraDays _
    ).result(), &H606000)

'Set the y axis scale as 0 - 100, with ticks every 25 units
Call c4.yAxis().setLinearScale(0, 100, 25)

'Add labels to the x axis formatted as mm/yyyy
Call c4.xAxis().setLabels2(labels, "{value|mm/yyyy}")

'We need to explicitly set the indent mode axis. By default, line layers are not
'indented, but we need it to be indented so the x axis will synchronize with the
'top and middle charts
Call c4.xAxis().setIndent(True)

'==========================================================================
'    Combine the charts together using a MultiChart
'==========================================================================

'Create a MultiChart object of size 600 x 400 pixels
Set m = cd.MultiChart(600, 400)

'Add a title to the chart
Call m.addTitle("Finance Chart Demonstration")

'Add the 4 charts to the multi-chart
Call m.addChart(0, 170, c2)
Call m.addChart(0, 30, c)
Call m.addChart(0, 235, c3)
Call m.addChart(0, 300, c4)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite m.makeChart2(cd.PNG)
Response.End
%>

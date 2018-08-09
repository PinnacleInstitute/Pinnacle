<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'
'Sample data for the HLOC chart.
'
highData = Array(2043, 2039, 2076, 2064, 2048, 2058, 2070, 2033, 2027, 2029, _
    2071, 2085, 2034, 2031, 2056, 2128, 2180, 2183, 2192, 2213, 2230, 2281, _
    2272)

lowData = Array(1931, 1921, 1985, 2028, 1986, 1994, 1999, 1958, 1943, 1944, _
    1962, 2011, 1975, 1962, 1928, 2059, 2112, 2103, 2151, 2127, 2123, 2152, _
    2212)

openData = Array(2000, 1957, 1993, 2037, 2018, 2021, 2045, 2009, 1959, 1985, _
    2008, 2048, 2006, 2010, 1971, 2080, 2116, 2137, 2170, 2172, 2171, 2191, _
    2240)

closeData = Array(1950, 1991, 2026, 2029, 2004, 2053, 2011, 1962, 1987, 2019, _
    2040, 2016, 1996, 1985, 2006, 2113, 2142, 2167, 2158, 2201, 2188, 2231, _
    2242)

'The labels for the HLOC chart
labels = Array("Mon 1", "Tue 2", "Wed 3", "Thu 4", "Fri 5", "Mon 8", "Tue 9", _
    "Wed 10", "Thu 11", "Fri 12", "Mon 15", "Tue 16", "Wed 17", "Thu 18", _
    "Fri 19", "Mon 22", "Tue 23", "Wed 24", "Thu 25", "Fri 26", "Mon 29", _
    "Tue 30", "Wed 31")

'Create a XYChart object of size 600 x 350 pixels
Set c = cd.XYChart(600, 350)

'Set the plotarea at (50, 25) and of size 500 x 250 pixels. Enable both the
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c.setPlotArea(50, 25, 500, 250).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a title to the chart
Call c.addTitle("Universal Stock Index on Jan 2001")

'Add a custom text at (50, 25) (the upper left corner of the plotarea). Use 12
'pts Arial Bold/pale green (0x40c040) as the font.
Call c.addText(50, 25, "(c) Global XYZ ABC Company", "arialbd.ttf", 12, _
    &H40c040)

'Add a title to the x axis
Call c.xAxis().setTitle("Jan 2001")

'Set the labels on the x axis. Rotate the labels by 45 degrees.
Call c.xAxis().setLabels(labels).setFontAngle(45)

'Add a title to the y axis
Call c.yAxis().setTitle("Universal Stock Index")

'Draw the y axis on the right hand side of the plot area
Call c.setYAxisOnRight(True)

'Add a HLOC layer using blue 0x0000ff color
Set layer = c.addHLOCLayer(highData, lowData, openData, closeData, &Hff)

'Set the line width to 2 pixels
Call layer.setLineWidth(2)

'
'Now we add the "High" and "Low" text labels. We first find out which are the
'highest and lowest positions.
'
highPos = cd.ArrayMath(highData).maxIndex()
lowPos = cd.ArrayMath(lowData).minIndex()

'By default, we put text at the center position. If the data point is too close
'to the right or left border of the plot area, we align the text to the right
'and left to avoid the text overflows outside the plot area
align = cd.BottomCenter
If highPos > 18 Then
    align = cd.BottomRight
ElseIf highPos < 5 Then
    align = cd.BottomLeft
End If

'Add the custom high label at the high position
Call layer.addCustomDataLabel(0, highPos, _
    "High {high}<*br*>{xLabel} Jan, 2001", "arialbd.ttf").setAlignment(align)

'Similarly, we compute the alignment for the low label based on its x position.
align = cd.TopCenter
If lowPos > 18 Then
    align = cd.TopRight
ElseIf lowPos < 5 Then
    align = cd.TopLeft
End If

'Add the custom low label at the low position
Call layer.addCustomDataLabel(0, lowPos, "Low {low}<*br*>{xLabel} Jan, 2001", _
    "arialbd.ttf").setAlignment(align)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'data for the gantt chart, representing the start date, end date and names for
'various activities
startDate = Array(DateSerial(2002, 8, 12), DateSerial(2002, 8, 19), _
    DateSerial(2002, 8, 26), DateSerial(2002, 9, 9), DateSerial(2002, 9, 23), _
    DateSerial(2002, 9, 23), DateSerial(2002, 9, 30), DateSerial(2002, 10, 14 _
    ), DateSerial(2002, 10, 14), DateSerial(2002, 10, 28), DateSerial(2002, _
    10, 28), DateSerial(2002, 11, 11))
endDate = Array(DateSerial(2002, 8, 26), DateSerial(2002, 8, 26), DateSerial( _
    2002, 9, 9), DateSerial(2002, 9, 23), DateSerial(2002, 10, 7), DateSerial( _
    2002, 10, 14), DateSerial(2002, 10, 14), DateSerial(2002, 10, 28), _
    DateSerial(2002, 11, 18), DateSerial(2002, 11, 18), DateSerial(2002, 11, _
    11), DateSerial(2002, 12, 2))
labels = Array("Market Research", "Brain-Storming", "Define Specifications", _
    "Overall Archiecture", "Project Planning", "Assemble Team", _
    "Detail Design", "Component Acquisition", "Software Development", _
    "User Documentation", "Test Plan", "Testing and QA")

'Create a XYChart object of size 620 x 280 pixels. Set background color
'0xe0e0ff, border color to 0xccccff, with 1 pixel 3D border effect.
Set c = cd.XYChart(620, 280, &He0e0ff, &Hccccff, 1)

'Set the plotarea at (140, 55) and of size 450 x 200 pixels. Use a white
'background. Enable both horizontal and vertical grids by setting their colors
'to grey (0xc0c0c0)
Call c.setPlotArea(140, 55, 450, 200, &Hffffff, -1, cd.LineColor, &Hc0c0c0, _
    &Hc0c0c0)

'swap the x and y axes to create a horziontal box-whisker chart
Call c.swapXY()

'Add a horizontal legend box at (300, 300) using 8pt Arial Bold Italic as font
Set legendBox = c.addLegend(300, 300, False, "arialbi.ttf", 8)

'Top center alignment the legend box to (300, 300)
Call legendBox.setAlignment(cd.TopCenter)

'Set the width of the legend box to 500 pixels (height = automatic)
Call legendBox.setSize(500, 0)

'Set the legend box background and border colors to transparent
Call legendBox.setBackground(cd.Transparent, cd.Transparent)

'Add a title to the chart using 14 points Times Bold Itatic font, with a pale
'blue (0x9999ff) background
Call c.addTitle("Simple Gantt Chart Demo", "timesbi.ttf", 14).setBackground( _
    &H9999ff)

'Set the y-axis scale to be date scale from Aug 12, 2002 to Dec 2, 2002, with
'ticks every 7 days (1 week)
Call c.yAxis().setDateScale(DateSerial(2002, 8, 12), DateSerial(2002, 12, 2), _
    86400 * 7)

'Set the label format to show month and day only.
Call c.yAxis().setLabelFormat("{value|mmm dd}")

'Set the y-axis to shown on the top (right + swapXY = top)
Call c.setYAxisOnRight()

'Set the labels on the x axis
Call c.xAxis().setLabels(labels)

'Reverse the x-axis scale so that it points downwards.
Call c.xAxis().setReverse()

'Disable ticks on x-axis by setting their length to 0.
Call c.xAxis().setTickLength(0)

'Add a green (0x33ff33) box-whisker layer showing the box only
Call c.addBoxWhiskerLayer(startDate, endDate, Null, Null, Null, &H33ff33)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

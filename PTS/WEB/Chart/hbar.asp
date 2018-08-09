<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data = Array(3.9, 8.1, 10.9, 14.2, 18.1, 19.0, 21.2, 23.2, 25.7, 36)

'The labels for the bar chart
labels = Array("Bastic Group", "Simpa", "YG Super", "CID", "Giga Tech", _
    "Indo Digital", "Supreme", "Electech", "THP Thunder", "Flash Light")

'Create a XYChart object of size 600 x 250 pixels
Set c = cd.XYChart(600, 250)

'Add a title to the chart using Arial Bold Italic font
Call c.addTitle("Revenue Estimation - Year 2002", "arialbi.ttf")

'Set the plotarea at (100, 30) and of size 400 x 200 pixels. Set the plotarea
'border, background and grid lines to Transparent
Call c.setPlotArea(100, 30, 400, 200, cd.Transparent, cd.Transparent, _
    cd.Transparent, cd.Transparent, cd.Transparent)

'Add a bar chart layer using the given data. Use a gradient color for the bars,
'where the gradient is from dark green (0x008000) to white (0xffffff)
Set layer = c.addBarLayer(data, c.gradientColor(100, 0, 500, 0, &H8000, _
    &Hffffff))

'Swap the axis so that the bars are drawn horizontally
Call c.swapXY(True)

'Set the bar gap to 10%
Call layer.setBarGap(0.1)

'Use the format "US$ xxx millions" as the bar label
Call layer.setAggregateLabelFormat("US$ {value} millions")

'Set the bar label font to 10 pts Times Bold Italic/dark red (0x663300)
Call layer.setAggregateLabelStyle("timesbi.ttf", 10, &H663300)

'Set the labels on the x axis
Set textbox = c.xAxis().setLabels(labels)

'Set the x axis label font to 10pt Arial Bold Italic
Call textbox.setFontStyle("arialbi.ttf")
Call textbox.setFontSize(10)

'Set the x axis to Transparent, with labels in dark red (0x663300)
Call c.xAxis().setColors(cd.Transparent, &H663300)

'Set the y axis and labels to Transparent
Call c.yAxis().setColors(cd.Transparent, cd.Transparent)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

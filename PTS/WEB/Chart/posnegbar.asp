<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the bar chart
data = Array(-6.3, 2.3, 0.7, -3.4, 2.2, -2.9, -0.1, -0.1, 3.3, 6.2, 4.3, 1.6)

'The labels for the bar chart
labels = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", _
    "Oct", "Nov", "Dec")

'Create a XYChart object of size 500 x 320 pixels
Set c = cd.XYChart(500, 320)

'Add a title to the chart using Arial Bold Italic font
Call c.addTitle("Productivity Change - Year 2001", "arialbi.ttf")

'Set the plotarea at (50, 30) and of size 400 x 250 pixels
Call c.setPlotArea(50, 30, 400, 250)

'Add a bar layer to the chart
Set layer = c.addBarLayer2()

'Add a data set to the bar using a y zone color. The color is configured to be
'orange (0xff6600) below zero, and blue (0x6666ff) above zero.
Call layer.addDataSet(data, layer.yZoneColor(0, &Hff6600, &H6666ff))

'Add labels to the top of the bar using 8 pt Arial Bold font. The font color is
'configured to be red (0xcc3300) below zero, and blue (0x3333ff) above zero.
Call layer.setAggregateLabelStyle("arialbd.ttf", 8, layer.yZoneColor(0, _
    &Hcc3300, &H3333ff))

'Set the labels on the x axis and use Arial Bold as the label font
Call c.xAxis().setLabels(labels).setFontStyle("arialbd.ttf")

'Draw the y axis on the right of the plot area
Call c.setYAxisOnRight(True)

'Use Arial Bold as the y axis label font
Call c.yAxis().setLabelStyle("arialbd.ttf")

'Add a title to the y axis
Call c.yAxis().setTitle("Percentage")

'Add a light blue (0xccccff) zone for positive part of the plot area
Call c.yAxis().addZone(0, 9999, &Hccccff)

'Add a pink (0xffffcc) zone for negative part of the plot area
Call c.yAxis().addZone(-9999, 0, &Hffcccc)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

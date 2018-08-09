<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the chart
data0 = Array(100, 125, 245, 147, 67)
data1 = Array(85, 156, 179, 211, 123)
data2 = Array(97, 87, 56, 267, 157)
labels = Array("Mon Jun 4", "Tue Jun 5", "Wed Jun 6", "Thu Jun 7", "Fri Jun 8")

'Create a XYChart object of size 540 x 350 pixels
Set c = cd.XYChart(540, 350)

'Set the plot area to start at (120, 40) and of size 280 x 240 pixels
Call c.setPlotArea(120, 40, 280, 240)

'Add a title to the chart using 20 pts Monotype Corsiva (mtcorsva.ttf) font and
'using a deep blue color (0x000080)
Call c.addTitle("Weekly Server Load", "mtcorsva.ttf", 20, &H80)

'Add a legend box at (420, 100) (right of plot area) using 12 pts Times Bold
'font. Sets the background of the legend box to light grey 0xd0d0d0 with a 1
'pixel 3D border.
Call c.addLegend(420, 100, True, "timesbd.ttf", 12).setBackground(&Hd0d0d0, _
    &Hd0d0d0, 1)

'Add a title to the y-axis using 12 pts Arial Bold/deep blue (0x000080) font.
'Set the background to yellow (0xffff00) with a 2 pixel 3D border.
Call c.yAxis().setTitle("Throughput (per hour)", "arialbd.ttf", 12, &H80 _
    ).setBackground(&Hffff00, &Hffff00, 2)

'Use 10 pts Impact/orange (0xcc6600) font for the y axis labels
Call c.yAxis().setLabelStyle("impact.ttf", 10, &Hcc6600)

'Set the axis label format to "nnn MBytes"
Call c.yAxis().setLabelFormat("{value} MBytes")

'Use 10 pts Impact/green (0x008000) font for the x axis labels. Set the label
'angle to 45 degrees.
Call c.xAxis().setLabelStyle("impact.ttf", 10, &H8000).setFontAngle(45)

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'Add a 3D stack bar layer with a 3D depth of 5 pixels
Set layer = c.addBarLayer2(cd.Stack, 5)

'Use Arial Italic as the default data label font in the bars
Call layer.setDataLabelStyle("ariali.ttf")

'Use 10 pts Times Bold Italic (timesbi.ttf) as the aggregate label font. Set the
'background to flesh (0xffcc66) color with a 1 pixel 3D border.
Call layer.setAggregateLabelStyle("timesbi.ttf", 10).setBackground(&Hffcc66, _
    cd.Transparent, 1)

'Add the first data set to the stacked bar layer
Call layer.addDataSet(data0, -1, "Server #1")

'Add the second data set to the stacked bar layer
Call layer.addDataSet(data1, -1, "Server #2")

'Add the third data set to the stacked bar layer, and set its data label font to
'Arial Bold Italic.
Set textbox = layer.addDataSet(data2, -1, "Server #3").setDataLabelStyle( _
    "arialbi.ttf")

'Set the data label font color for the third data set to yellow (0xffff00)
Call textbox.setFontColor(&Hffff00)

'Set the data label background color to the same color as the bar segment, with
'a 1 pixel 3D border.
Call textbox.setBackground(cd.SameAsMainColor, cd.Transparent, 1)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

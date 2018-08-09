<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'Sample data for the Box-Whisker chart. Represents the minimum, 1st quartile,
'medium, 3rd quartile and maximum values of some quantities
Q0Data = Array(40, 45, 40, 30, 20, 50, 25, 44)
Q1Data = Array(55, 60, 50, 40, 38, 60, 51, 60)
Q2Data = Array(62, 70, 60, 50, 48, 70, 62, 70)
Q3Data = Array(70, 80, 65, 60, 53, 78, 69, 76)
Q4Data = Array(80, 90, 75, 70, 60, 85, 80, 84)

'The labels for the chart
labels = Array("Group A", "Group B", "Group C", "Group D", "Group E", _
    "Group F", "Group G", "Group H")

'Create a XYChart object of size 550 x 250 pixels
Set c = cd.XYChart(550, 250)

'Set the plotarea at (50, 25) and of size 450 x 200 pixels. Enable both
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c.setPlotArea(50, 25, 450, 200).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a title to the chart
Call c.addTitle("Computer Vision Test Scores")

'Set the labels on the x axis and the font to Arial Bold
Call c.xAxis().setLabels(labels).setFontStyle("arialbd.ttf")

'Set the font for the y axis labels to Arial Bold
Call c.yAxis().setLabelStyle("arialbd.ttf")

'Add a Box Whisker layer using light blue 0x9999ff as the fill color and blue
'(0xcc) as the line color. Set the line width to 2 pixels
Call c.addBoxWhiskerLayer(Q1Data, Q3Data, Q4Data, Q0Data, Q2Data, &H9999ff, _
    &Hcc).setLineWidth(2)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

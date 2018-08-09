<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'Sample data for the Box-Whisker chart. Represents the minimum, 1st quartile,
'medium, 3rd quartile and maximum values of some quantities
Q0Data = Array(40, 45, 35)
Q1Data = Array(55, 60, 50)
Q2Data = Array(62, 70, 60)
Q3Data = Array(70, 80, 65)
Q4Data = Array(80, 90, 75)

'The labels for the chart
labels = Array("<*img=robot1.png*><*br*>Bipedal Type", _
    "<*img=robot2.png*><*br*>Wolf Type", "<*img=robot5.png*><*br*>Bird Type")

'Create a XYChart object of size 540 x 320 pixels
Set c = cd.XYChart(540, 320)

'swap the x and y axes to create a horizontal box-whisker chart
Call c.swapXY()

'Set default directory for loading images from current script directory
c.setSearchPath(Server.MapPath("."))

'Set the plotarea at (75, 25) and of size 440 x 270 pixels. Enable both
'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
Call c.setPlotArea(75, 25, 440, 270).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a title to the chart
Call c.addTitle("           Robot Shooting Accuracy Scores")

'Set the labels on the x axis and the font to Arial Bold
Call c.xAxis().setLabels(labels).setFontStyle("arialbd.ttf")

'Disable x axis ticks by setting the length to 0
Call c.xAxis().setTickLength(0)

'Set the font for the y axis labels to Arial Bold
Call c.yAxis().setLabelStyle("arialbd.ttf")

'Add a Box Whisker layer using light blue 0x9999ff as the fill color and blue
'(0xcc) as the line color. Set the line width to 2 pixels
Call c.addBoxWhiskerLayer(Q3Data, Q1Data, Q4Data, Q0Data, Q2Data, &H9999ff, _
    &Hcc).setLineWidth(2)

'output the chart
Response.ContentType = "image/png"
Response.BinaryWrite c.makeChart2(cd.PNG)
Response.End
%>

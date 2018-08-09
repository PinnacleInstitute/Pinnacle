<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'The data for the line chart
data0 = Array(50, 55, 47, 36, 42, 49, 63, 62, 73, 59, 56, 50, 64, 60, 67, 67, _
    58, 59, 73, 77, 84, 82, 80, 84)
data1 = Array(36, 28, 25, 33, 38, 20, 22, 30, 25, 33, 30, 24, 28, 36, 30, 45, _
    46, 42, 48, 45, 43, 52, 64, 70)

'The labels for the line chart
labels = Array("Jan-00", "Feb-00", "Mar-00", "Apr-00", "May-00", "Jun-00", _
    "Jul-00", "Aug-00", "Sep-00", "Oct-00", "Nov-00", "Dec-00", "Jan-01", _
    "Feb-01", "Mar-01", "Apr-01", "May-01", "Jun-01", "Jul-01", "Aug-01", _
    "Sep-01", "Oct-01", "Nov-01", "Dec-01")

'Create a XYChart object of size 500 x 300 pixels
Set c = cd.XYChart(500, 300)

'Use a pale yellow background (0xffff80) with a black (0x0) edge and a 1 pixel
'3D border
Call c.setBackground(&Hffff80, &H0, 1)

'Set plotarea at (55, 45) with size of 420 x 200 pixels. Use white (0xffffff)
'background. Enable both horizontal and vertical grid by setting their colors to
'light grey (0xc0c0c0)
Call c.setPlotArea(55, 45, 420, 200, &Hffffff).setGridColor(&Hc0c0c0, &Hc0c0c0)

'Add a legend box at (55, 45) (top of plot area) using 8 pts Arial Bold font
'with horizontal layout Set border and background colors of the legend box to
'Transparent
Set legendBox = c.addLegend(55, 45, False, "arialbd.ttf", 8)
Call legendBox.setBackground(cd.Transparent)

'Reserve 10% margin at the top of the plot area during auto-scaling to leave
'space for the legends.
Call c.yAxis().setAutoScale(0.1)

'Add a title to the chart using 11 pts Arial Bold Italic font. The text is white
'0xffffff on a dark red 0x800000 background.
Set title = c.addTitle("Monthly Revenue for Year 2000/2001", "arialbi.ttf", _
    11, &Hffffff)
Call title.setBackground(&H800000, -1, 1)

'Add a title to the y axis
Call c.yAxis().setTitle("Month Revenue (USD millions)")

'Set the labels on the x axis. Draw the labels vertical (angle = 90)
Call c.xAxis().setLabels(labels).setFontAngle(90)

'Add a vertical mark at x = 17 using a semi-transparent purple (0x809933ff)
'color and Arial Bold font. Attached the mark (and therefore its label) to the
'top x axis.
Set mark = c.xAxis2().addMark(17, &H809933ff, "Merge with Star Tech", _
    "arialbd.ttf")

'Set the mark line width to 2 pixels
Call mark.setLineWidth(2)

'Set the mark label font color to purple (0x9933ff)
Call mark.setFontColor(&H9933ff)

'Add a copyright message at (475, 240) (bottom right of plot area) using Arial
'Bold font
Set copyRight = c.addText(475, 240, "(c) Copyright Space Travel Ltd.", _
    "arialbd.ttf")
Call copyRight.setAlignment(cd.BottomRight)

'Add a line layer to the chart
Set layer = c.addLineLayer()

'Set the default line width to 3 pixels
Call layer.setLineWidth(3)

'Add the data sets to the line layer
Call layer.addDataSet(data0, -1, "Enterprise")
Call layer.addDataSet(data1, -1, "Consumer")

'Create the image and save it in a temporary location
chart1URL = c.makeSession(Session, "chart1")

'Create an image map for the chart
chartImageMap = c.getHTMLImageMap("xystub.asp", "", _
    "title='{dataSetName} @ {xLabel} = USD {value|0} millions'")

'Create an image map for the legend box
legendImageMap = legendBox.getHTMLImageMap("javascript:doSomething();", " ", _
    "title='This legend key is clickable!'")

'Obtain the image map coordinates for the title, mark, and copyright message.
'These will be used to define the image map inline. (See HTML code below.)
titleCoor = title.getImageCoor()
markCoor = mark.getImageCoor()
copyRightCoor = copyRight.getImageCoor()
%>
<html>
<body>
<h1>Custom Clickable Objects</h1>
<p><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
View Source Code
</a></p>

<p style="width:500px">
In the following chart, the lines, legend keys, title, copyright,
and the "Merge with Star Tech" text are all clickable!
</p>

<img src="myimage.asp?<%=chart1URL%>" border="0" usemap="#map1">
<map name="map1">
<%=chartImageMap%>
<%=legendImageMap%>
<area <%=titleCoor%>  href='javascript:doSomething();'
    title='The title is clickable!'>
<area <%=markCoor%> href='javascript:doSomething();'
    title='The "Merge with Star Tech" text is clickable!'>
<area <%=copyRightCoor%> href='javascript:doSomething();'
    title='The copyright text is clickable!'>
</map>

<SCRIPT>
function doSomething() {
    alert("This is suppose to do something meaningful, but for demo " +
          "purposes, we just pop up this message box to prove that " +
          "the object can response to mouse clicks.");
}
</SCRIPT>
</body>
</html>

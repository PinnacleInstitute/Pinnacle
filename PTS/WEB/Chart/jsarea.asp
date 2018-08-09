<%@ language="vbscript" %>
<%
Set cd = CreateObject("ChartDirector.API")

'
'For demo purpose, we use hard coded data. In real life, the following data
'could come from a database.
'
revenue = Array(4500, 5600, 6300, 8000, 12000, 14000, 16000, 20000, 24000, _
    28000)
grossMargin = Array(62, 65, 63, 60, 55, 56, 57, 53, 52, 50)
backLog = Array(563, 683, 788, 941, 1334, 1522, 1644, 1905, 2222, 2544)
receviable = Array(750, 840, 860, 1200, 2200, 2700, 2800, 3900, 4900, 6000)
labels = Array("1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", _
    "2000", "2001")

'Create a XYChart object of size 440 x 200 pixels
Set c = cd.XYChart(440, 200)

'Add a title to the chart using Times Bold Italic font
Call c.addTitle("Annual Revenue for Star Tech", "timesbi.ttf")

'Set the plotarea at (60, 5) and of size 350 x 150 pixels
Call c.setPlotArea(60, 25, 350, 150)

'Add an area chart layer for the revenue data
Call c.addAreaLayer(revenue, &H3333cc, "Revenue").setBorderColor( _
    cd.SameAsMainColor)

'Set the x axis labels using the given labels
Call c.xAxis().setLabels(labels)

'Add a title to the y axis
Call c.yAxis().setTitle("USD (K)")

'Create the image and save it in a temporary location
chart1URL = c.makeSession(Session, "chart1")

'Client side Javascript to show detail information "onmouseover"
showText = "onmouseover='setDIV(""info{x}"", ""visible"");' "

'Client side Javascript to hide detail information "onmouseout"
hideText = "onmouseout='setDIV(""info{x}"", ""hidden"");' "

'"alt" attribute to show tool tip
toolTip = "title='{xLabel}: USD {value|0}K'"

'Create an image map for the chart
imageMap = c.getHTMLImageMap("xystub.asp", "", showText & hideText & toolTip)
%>
<html>
<body>
<h1>Javascript Clickable Chart</h1>
<p><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
View Source Code
</a></p>

<p style="width:500px">
Move the mouse cursor over the area chart to see what happens!
This effect is achieved by using image maps with client side Javascript.
</p>

<img src="myimage.asp?<%=chart1URL%>" border="0" usemap="#map1">
<map name="map1">
<%=imageMap%>
</map>

<br>

<!-----------------------------------------------------
    Create the DIV layers to show detail information
-------------------------------------------------------->

<%For i = 0 To UBound(revenue)%>

    <div id="info<%=i%>"
        style="visibility:hidden;position:absolute;left:65px;">
        <b>Year <%=labels(i)%></b><br>
        Revenue : USD <%=revenue(i)%>K<br>
        Gross Margin : <%=grossMargin(i)%>%<br>
        Back Log : USD <%=backLog(i)%>K<br>
        A/C Receviable : USD <%=receviable(i)%>K<br>
    </div>

<%Next%>

<!-----------------------------------------------------
    Client side utility function to show and hide
    a layer. Works in both IE and Netscape browsers.
-------------------------------------------------------->
<SCRIPT>
function setDIV(id, cmd) {
    if (document.getElementById)
        //IE 5.x or NS 6.x or above
        document.getElementById(id).style.visibility = cmd;
    else if (document.all)
        //IE 4.x
        document.all[id].style.visibility = cmd;
    else
        //Netscape 4.x
        document[id].visibility = cmd;
}
</SCRIPT>

</body>
</html>

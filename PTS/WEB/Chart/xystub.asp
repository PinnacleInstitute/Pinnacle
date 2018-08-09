<%@ language="vbscript" %>
<html>
<body>
<h1>Simple Clickable XY Chart Handler</h1>
<p><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
View Source Code
</a></p>

<p><b>You have clicked on the following chart element :</b></p>
<ul>
    <li>Data Set : <%=Request("dataSetName")%></li>
    <li>X Position : <%=Request("x")%></li>
    <li>X Label : <%=Request("xLabel")%></li>
    <li>Data Value : <%=Request("value")%></li>
</ul>
</body>
</html>

<%@ language="vbscript" %>
<html>
<body>
<h1>Simple Clickable Pie Chart Handler</h1>
<p><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
View Source Code
</a></p>

<p><b>You have clicked on the following sector :</b></p>
<ul>
    <li>Sector Number : <%=Request("sector")%></li>
    <li>Sector Name : <%=Request("label")%></li>
    <li>Sector Value : <%=Request("value")%></li>
    <li>Sector Percentage : <%=Request("percent")%>%</li>
</ul>
</body>
</html>

<html>
<body topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">
<div style="margin:5;">
<div style="font-family:verdana; font-weight:bold; font-size:18pt;">
ChartDirector Information
</div>
<hr color="#000080">
<div style="font-family:verdana; font-size:10pt;">
<%@ language="vbscript" %>
<%
On Error Resume Next
Set cd = CreateObject("ChartDirector.API")
If Err.Number Then
%>
Error creating the "ChartDirector.API" object (Err <%=Hex(Err.Number)%> : <%=Err.Description%>)
<br><br>
ChartDirector is either not installed properly, or the security settings on your 
computer do not allow your web server anonymous user to have read and execute access 
to the ChartDirector DLLs. Please refer to the ChartDirector documentation on what
DLLs the ChartDirector needs.
<%
Else
	On Error Goto 0
%>
<ul style="margin-top:0; list-style:square; font-family:verdana; font-size:10pt;">
<li>Description : <%=cd.getDescription()%><br><br>
<li>Version : <%=(cd.getVersion() And &Hff000000&) / &H1000000&%>.<%=(cd.getVersion() And &Hff0000&) / &H10000&%>.<%=cd.getVersion() And &Hffff&%><br><br>
<li>Copyright : <%=cd.getCopyright()%><br><br>
<li>Boot Log : <br><ul><li><%=Replace(cd.getBootLog(), Chr(10), "<li>")%></ul><br>
<li>Font Loading Test : <br><ul><li><%=Replace(cd.libgTTFTest(), Chr(10), "<li>")%></ul>
</ul>
<%End If%>
</div>
</body>
</html>

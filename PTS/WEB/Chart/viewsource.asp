<html>
<body topmargin="0" leftmargin="5" rightmargin="0" marginwidth="5" marginheight="0">
<%
myPath = Server.MapPath(Request("file"))
Set fso = CreateObject("Scripting.FileSystemObject")
Set myFile = fso.OpenTextFile(myPath)
%>
<p style="margin-bottom:5px"><font size="4" face="Verdana"><b><%=myPath%></b></font></p>
<a href="javascript:history.go(-1);"><font size="2" face="Verdana">Back to Chart Graphics</font></a>
<xmp>
<%=myFile.ReadAll%>
</xmp>
</body>
</html>

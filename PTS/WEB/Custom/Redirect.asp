<html>
<head>
</head>
<body>
 
<a id=aa href='<% Response.Write(Replace(Request("url"), "%26", "&"))%>' ></a>

<% Response.Write("<" & "script language=javascript>") %>
 
 window.setTimeout("document.getElementById('aa').click(),200")
 
<% Response.Write("</" & "script>") %>
</body>
</html>
 
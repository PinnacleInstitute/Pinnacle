<!--#include file="include\browserclass.asp"-->
<html>
<head><title>Check Browser</title></head>
<body>
<b>Your systems:</b><br>
Browser Details: <%=request.serverVariables("HTTP_USER_AGENT")%><br>
Browser Short Name: <%=browser.getName %><br>
Browser Full Name: <%=browser.getFullName %><br>
Browser Version: <%=browser.getVersion%><br>
OS Short Name: <%=browser.getOS%><br> 
OS Full Name: <%=browser.getFullOS%><br>
<%	Set browser = Nothing %>
<br><br>
<b>Script is updated for following Browser Agents:</b><br>
&middot; Mozilla<br>
&middot; Mozilla Firebird<br>
&middot; Mozilla Firefox<br>
&middot; Mozilla K-Meleon<br>
&middot; Mozilla Phoenix<br>
&middot; Internet Explorer<br>
&middot; Crazy Browser<br>
&middot; Galeon<br>
&middot; Konqueror<br>
&middot; Opera<br>
&middot; Safari<br>
&middot; Lotus-Notes<br>
&middot; Lynx<br>
<br><br>
<b>Script is updated for following OSs:</b><br>
&middot; Windows<br>
&middot; Macintosh<br>
&middot; Unix<br>
&middot; Linux<br>
&middot; Sun Solaris<br>
&middot; FreeBSD<br>
</body>
</html>

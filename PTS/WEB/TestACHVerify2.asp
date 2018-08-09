<!--#include file="Include\System.asp"-->
<!--#include file="Include\ACHVerify.asp"-->
<% Response.Buffer=true

Dim Reference
result = VerifyACH( 7, 5, "124085024", "21727100077223108", 1, 1, Reference )

response.Write "<BR>Result: " & result
response.Write "<BR>Reference: " & Reference

%>
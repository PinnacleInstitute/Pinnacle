<!--#include file="Include\coins.asp"-->

<% Response.Buffer=true
On Error Resume Next

coin = Request.Item( "c" )

If coin <> "" Then price = CoinPrice( coin, "" )

response.write FormatCurrency( price )

%>
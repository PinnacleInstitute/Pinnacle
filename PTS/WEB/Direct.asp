<!--#include file="Include\System.asp"-->
<%
'**************************************************************************
'Use this page to redirect with a specific domain and cache the referrer
' M = MerchantID of Referrer
' A = MemberID of Referrer
' S = ConsumerID of Referrer
' U = URL to redirect to (& replaced with %26)
' Ex: http://www.zazzed.com/direct.asp?a=123&u=test.asp?z=1%26y=2
'**************************************************************************
On Error Resume Next

Merchant = Request.Item("M")
Member = Request.Item("A")
Shopper = Request.Item("S")
Group = Request.Item("G")
Promo = Request.Item("P")

URL = Request.Item("U")
URL = Replace( URL, "%26", "&")

SetCache "M", Merchant
SetCache "A", Member
SetCache "S", Shopper
SetCache "GROUPID", Group
SetCache "PROMO", Promo

Response.Redirect URL

%>
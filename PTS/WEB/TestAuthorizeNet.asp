<!--#include file="Include\AuthorizeNet.asp"-->
<% Response.Buffer=true

Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
If oBilling Is Nothing Then response.Write "Unable to Create Object - ptsBillingUser.CBilling"

ClientID = "C134567890"
ClientName = "Bob Wood"
ClientEmail = "bob@pinnaclep.com"
AuthorizeNetID = 0
AuthorizeNetPayID = 0

With oBilling
	.PayType = 1
	.CardNumber = "5443426150046283"
'	.CardNumber = "5443426150046282"
	.CardMo = "9"
	.CardYr = "13"
End With

oBilling.Load 1236, 1

ClientName = "Barb Wood"
Result = CreateCustomer( ClientID, ClientName, ClientEmail, oBilling, AuthorizeNetID, AuthorizeNetPayID )
Response.write "<BR>AuthorizeNetID: " & AuthorizeNetID
Response.write "<BR>AuthorizeNetPayID: " & AuthorizeNetPayID

'AuthorizeNetID = 28765623
'ClientName = "Bill Wood"

'AuthorizeNetID = 28539399
'AuthorizeNetPayID = 26026505 

'ClientID = "54321"
'ClientName = "Bill Wood"
'ClientEmail = "bill@pinnaclep.com"
'Result = UpdateCustomer( AuthorizeNetID, ClientID, ClientName, ClientEmail )
'Result = GetPaymentInfo( AuthorizeNetID, AuthorizeNetPayID, oBilling )
'Result = UpdatePaymentInfo( AuthorizeNetID, AuthorizeNetPayID, oBilling )

'With oBilling
'response.Write "<BR>CardNumber: " + .CardNumber
'response.Write "<BR>CardMo: " + .CardMo
'response.Write "<BR>CardYr: " + .CardYr 
'End With

'Result = DeleteCustomer( AuthorizeNetID )
'Result = CreatePaymentInfo( AuthorizeNetID, oBilling, AuthorizeNetPayID )
'Result = ValidatePaymentInfo( AuthorizeNetID, AuthorizeNetPayID  )
'Result = UpdatePaymentInfo( AuthorizeNetID, AuthorizeNetPayID, oBilling )
'Result = DeletePaymentInfo( byval bvAuthorizeNetID, byval bvAuthorizeNetPayID )
'Result = CreatePayment( AuthorizeNetID, AuthorizeNetPayID, Amount  )
'Result = SetProcessor( Processor )

Response.write "<BR>Result: " & Result

Set oBilling = Nothing
%>
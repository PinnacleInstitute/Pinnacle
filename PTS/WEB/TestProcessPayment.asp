<!--#include file="Include\System.asp"-->
<!--#include file="Include\ProcessPayment.asp"-->
<% Response.Buffer=true

On Error Resume Next

Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
If oPayment Is Nothing Then
	Response.Write "Error Creating  - ptsPaymentUser.CPayment"
	Response.End
Else
	With oPayment
		.PaymentID = 0
		.CompanyID = 1
		.Amount = 0.02
		.Purpose = "TEST"
		.PayType = 2
		.Description = "Charged:[2; 4111111111111111; 6/12; 123; Robert A. Wood; 1716 Azurite Trail; ; Plano; TX; 75075]"

		RetCode = ProcessPayment( oPayment, 12, "TEST", 0, "" ) 

		Response.write "<BR>Return: " + CStr(RetCode)
		Response.write "<BR>Status: " + CStr(.Status)
		Response.write "<BR>Reference: " + .Reference
		Response.write "<BR>Notes: " + .Notes

	End With

End If
Set oPayment = Nothing

%>
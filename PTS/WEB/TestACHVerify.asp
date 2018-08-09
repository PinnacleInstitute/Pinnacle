<!--#include file="Include\System.asp"-->
<!--#include file="Include\ACHVerify.asp"-->
<% Response.Buffer=true

On Error Resume Next

Dim A, Reference

Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
If oMembers Is Nothing Then
	Response.Write "Error Creating Member"
	Response.End
End If
Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
If oBilling Is Nothing Then
	Response.Write "Error Creating Billing"
	Response.End
End If

oMembers.CustomList 7, 1000, 0

For Each oItem in oMembers
	With oItem
		A = Split( .Signature, "|" )
		MemberID = A(0)
		BillingID = A(1)
		CheckRoute = A(2)
		CheckAccount = A(3)
		CheckAcctType = A(4)

		result = VerifyACH( 7, MemberID, CheckRoute, CheckAccount, CheckAcctType, 1, Reference )

		With oBilling
			.Load 1, BillingID
			If result = "POS" Then .Verified =2 Else .Verified = 1	
			.Street2 = .Street1 + reference
			.Save 1
		End With
	End With
Next 

Set oBilling = Nothing
Set oMembers = Nothing



'Good
'result = VerifyACH( 7, 5, "311079474", "42008007", 1, 1, Reference ) 'A01: APPROVED

'Bad
'result = VerifyACH( 7, 5, "311079475", "42008007", 1, 1, Reference ) 'U19: INVALID TRN
'result = VerifyACH( 7, 5, "021409169", "4104891362175258", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "261171587", "10002579000714", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "063104668", "0119719183", 1, 1, Reference ) 'U80: PREAUTH DECLINE
'result = VerifyACH( 7, 5, "261171587", "122121750", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "253177049", "50092695", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "542805255", "2000045937835", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "522006508", "7810716881", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "124085024", "4470917629524057", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "061000052", "334003540437", 1, 1, Reference ) 'U80: PREAUTH DECLINE
'result = VerifyACH( 7, 5, "121000358", "02770017008060", 1, 1, Reference ) 'U80: PREAUTH DECLINE
'result = VerifyACH( 7, 5, "121000358", "138408610", 1, 1, Reference ) 'U80: PREAUTH DECLINE
'result = VerifyACH( 7, 5, "021409169", "4104891362175258", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "065303784", "77400014953", 1, 1, Reference ) 'A01: APPROVED
'result = VerifyACH( 7, 5, "124085024", "41814700846184806", 1, 1, Reference ) 'A01: APPROVED


'response.Write "<BR>Result: " & result
'response.Write "<BR>Reference: " & Reference

%>
<!--#include file="AuthorizeNet.asp"-->
<%
Function GetProcessor()
	'Set to PowerPay
	GetProcessor = 1
End Function

Function BillingTokens()
On Error Resume Next
	'response.Write "<BR>Start: " & Date()

	Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
	If oMembers Is Nothing Then
		Response.write "Error Creating Object - ptsMemberUser.CMembers"
	End If
	Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
	If oBilling Is Nothing Then
		Response.write "Error Creating Object - ptsBillingUser.CBilling"
	End If

	Set oNote = server.CreateObject("ptsNoteUser.CNote")
	If oNote Is Nothing Then
		Response.write "Error Creating Object - ptsNoteUser.CNote"
	End If

	'Set to PowerPay
	Processor = GetProcessor()
	AuthorizeNetID = 0
	AuthorizeNetPayID = 0

	oMembers.CustomList 5, 1, 0
	
	good = 0
	bad = 0
	For Each oMember in oMembers
		With oMember
			tmpMemberID = .MemberID
			tmpBillingID = .Status
			aValues = Split(.Signature, "|")
			tmpName = aValues(0)
			tmpEmail = aValues(1)
		End With
		
		oBilling.Load tmpBillingID, 1

		Result = CreateCustomer( Processor, tmpMemberID, tmpName, tmpEmail, oBilling, AuthorizeNetID, AuthorizeNetPayID )

		IF Result = "OK" Then
			good = good + 1
			With oBilling
				.TokenType = Processor
				.Token = AuthorizeNetPayID
				.Verified = 2
				.Save 1
			End With    
			With oMember
				.Load tmpMemberID, 1
				.Reference = CStr(Processor) + "-" + CStr(AuthorizeNetID)
				.Save 1
			End With   
		Else	 
			bad = bad + 1
			With oBilling
				.TokenType = Processor
				.Verified = 1
				.Save 1
			End With    
			With oNote
				.Load 0, 1
				.Notes = "Billing Info Failed Verification: " + Result
				.AuthUserID = 1
				.NoteDate = Now
				.OwnerType = 4
				.OwnerID = tmpMemberID
				.Add(1)
			End With
		End If
	Next
	      
	Set oNote = Nothing
	Set oBilling = Nothing
	Set oMembers = Nothing
	'response.Write "<BR>End: " & Date()

	BillingTokens = CStr(good) + "|" + CStr(bad)

End Function

Function ProcessPayments()
On Error Resume Next

'response.Write "<BR>Start: " & Date()

	Set oCloudZows = server.CreateObject("ptsCloudZowUser.CCloudZows")
	If oCloudZows Is Nothing Then
		Response.write "Error Creating Object - ptsCloudZowUser.CCloudZows"
	End If
	Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
	If oPayment Is Nothing Then
		Response.write "Error Creating Object - ptsPaymentUser.CPayment"
	End If

	oCloudZows.CustomList 1, 0, 0, 0

	good = 0
	bad = 0
	For Each oItem in oCloudZows

		'PaymentID,PayType,Amount,Reference,TokenType,Token
		aResult = Split(oItem.Result, "|")
		tmpPaymentID = aResult(0)
		tmpPayType = aResult(1)
		tmpAmount = aResult(2)
		tmpReference = aResult(3)
		Processor = aResult(4)
		tmpToken = aResult(5)
		aReference = Split(tmpReference,"-")
		if(UBOUND(aReference) = 1) Then tmpMemberToken = aReference(1) Else tmpMemberToken = 0 

		If Processor = 1 And tmpPayType <= 4 And tmpMemberToken > 0 And tmpToken > 0 Then
			Result = CreatePayment( Processor, tmpMemberToken, tmpToken, tmpAmount )
		Else
			If Proceesor > 1 Then Result = "Invalid Processor"
			If tmpPayType <> 1 Then Result = "Invalid Payment Type"
			If tmpMemberToken = 0 Then Result = "Missing Member Token"
			If tmpToken = 0 Then Result = "Missing Billing Token"
		End If

		With oPayment
			.Load tmpPaymentID, 1
		
			IF Result = "OK" Then
				good = good + 1
				.Status = 3
				.PaidDate = reqSysDate
			Else	 
				bad = bad + 1
				.Status = 4
				.Notes = .Notes + " " + Result
			End If
			.Save 1
		End With
	Next
	      
	Set oPayment = Nothing
	Set oCloudZow = Nothing

'response.Write "<BR>End: " & Date()

	ProcessPayments = CStr(good) + "|" + CStr(bad)

End Function

Function UpdateAllTokens()
	Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
	If oMembers Is Nothing Then
		Response.write "Error Creating Object - ptsMemberUser.CMembers"
	End If
	Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
	If oBilling Is Nothing Then
		Response.write "Error Creating Object - ptsBillingUser.CBilling"
	End If

	oMembers.CustomList 5, 2, 0
	cnt = 0
	For Each oMember in oMembers
		cnt = cnt + 1
		With oMember
			tmpMemberID = .MemberID
			tmpBillingID = .Status
			aValues = Split(.Signature, "-")
			tmpProcessor = aValues(0)
			tmpMemberToken = aValues(1)
			tmpToken = aValues(2)
		End With
		
		oBilling.Load tmpBillingID, 1
		Result = UpdatePaymentInfo( tmpProcessor, tmpMemberToken, tmpToken, oBilling )
	Next
	      
	Set oBilling = Nothing
	Set oMembers = Nothing

	UpdateAllTokens = CStr(cnt)

End Function

%>
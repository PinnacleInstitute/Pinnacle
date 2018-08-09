<%
'Requires Include\Note.asp
'****************************************************************************************
Function GetToken( byval bvMemberID, byval bvBillingID, byval bvName, byval bvEmail, byref brProcessor, byref brMemberToken, byref brToken, byref brPayDesc)
	On Error Resume Next

	Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
	If oBilling Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
	Else
		With oBilling
			.SysCurrentLanguage = reqSysLanguage
			.Load bvBillingID, 1
			If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
			If brMemberToken = 0 Then
				'create billing tokens
				brProcessor = GetProcessor()
				Result = CreateCustomer( brProcessor, bvMemberID, bvName, bvEmail, oBilling, brMemberToken, brToken )
			Else
				If brProcessor = 0 Then brProcessor = GetProcessor()
				'update billing token
				Result = UpdatePaymentInfo( brProcessor, brMemberToken, brToken, oBilling )
			End If  
			 
			If Result = "OK" Then
				.TokenType = CStr(brProcessor)
				.Token = CStr(brToken)
				.Verified = 2
				.Save 1
				Select Case .PayType
					Case 1
					brPayDesc = .CardType + "; " + .CardNumber + "; " + .CardMo + "/" + .CardYr + "; " + .CardCode + "; " + .CardName + "; " + .Street1 + "; " + .Street2 + "; " + .City + "; " + .State + "; " + .Zip
					Case 2 
					brPayDesc = .CheckBank + "; " + .CheckRoute + "; " + .CheckAccount + "; " + .CheckNumber + "; " + .CheckName + "; " + .CheckAcctType
				End Select
				If brPayDesc <> "" Then brPayDesc = "Charged:[" + brPayDesc + "]"
			Else
				DoError 1, "", "Payment Setup Error: " + Result
				LogMemberNote bvMemberID, "TOKEN ERROR: " + Result
			End If   
		End With
   End If
   Set oBilling = Nothing
End Function

'****************************************************************************************
Function GetPayment( byval bvMemberID, byval bvAmount, byval bvPayType, byval bvPayDesc, byval bvProcessor, byval bvMemberToken, byval bvToken)
	On Error Resume Next
   
	'create and process first payment
	Result = CreatePayment( bvProcessor, bvMemberToken, bvToken, bvAmount )
	If Result <> "OK" Then
		DoError 1, "", "Payment Processing Error: " + Result
		LogMemberNote bvMemberID, "PAYMENT ERROR: " + Result
	End If   

	If (xmlError = "") Then
		Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
		If oPayment Is Nothing Then
			DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
		Else
			With oPayment
				.SysCurrentLanguage = reqSysLanguage
				.Load 0, 1
				If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
				.OwnerType = 4
				.OwnerID = bvMemberID
				.PayDate = reqSysDate
				.PaidDate = reqSysDate
				.PayType = bvPayType
				.Amount = bvAmount
				.Total = bvAmount
				.Description = bvPayDesc
				.Status = 3
				.Notes = CSTR(reqSysDate)
				.CommStatus = 1
				.TokenType = bvProcessor
				.Token = bvToken
				reqPaymentID = CLng(.Add(CLng(reqSysUserID)))
				If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
			End With
		End If
		Set oPayment = Nothing
	End If
End Function

%>


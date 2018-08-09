<%
' ********************************************************************************************************
Function ProcessCard( byVal bvProcessor, byVal bvAcct, byVal bvAmount, byVal bvPurpose, byVal bvNumber, byVal bvMo, byVal bvYr, byVal bvName, byVal bvZip, byVal bvCode, byRef brReference, byRef brResult )
' ********************
' Return Codes
' 0 = Not Processed 
' 2 = Pending  
' 3 = Approved 
' 4 = Declined 
' ********************

	On Error Resume Next

	PaymentProcessed = False

	If bvProcessor > 0 and bvAcct <> "" Then
		Set wtPay = server.CreateObject("wtPayment.CPayment")
		If wtPay Is Nothing Then
			DoError Err.Number, Err.Source, "Unable to Create Object - wtPayment.CPayment"
		Else
			PaymentProcessed = True
			wtpay.processor = bvProcessor
			wtpay.account = bvAcct
			wtpay.Amount = bvAmount
			wtpay.description = bvPurpose
			wtpay.Card bvNumber, bvMo, bvYr, bvName, bvZip, bvCode

			result = wtpay.process

			Select Case result
				Case -1   'Pending
					brReference = Left(wtPay.Reference,30)
					brResult = "PENDING: " + wtPay.ErrMsg
					ProcessCard = 2
				Case 0    'Approved
					brReference = Left(wtPay.Reference,30)
					brResult = "APPROVED"
					ProcessCard = 3
				Case Else 'Declined
					brResult = wtPay.ErrMsg
					ProcessCard = 4
			End Select                     
		End If
		Set wtPay = Nothing
	End If         

    If PaymentProcessed = False Then ProcessCard = 0

End Function

' ********************************************************************************************************
Function ProcessCheck( byVal bvProcessor, byVal bvAcct, byVal bvAmount, byVal bvPurpose, byVal bvBank, byVal bvRoute, byVal bvCheckAcct, byVal bvCheckNumber, byVal bvCheckName, byRef brReference, byRef brResult )
' ********************
' Return Codes
' 0 = Not Processed 
' 2 = Pending  
' 3 = Approved 
' 4 = Declined 
' ********************

	On Error Resume Next

	PaymentProcessed = False

	If bvProcessor > 0 and bvAcct <> "" Then
		Set wtPay = server.CreateObject("wtPayment.CPayment")
		If wtPay Is Nothing Then
			DoError Err.Number, Err.Source, "Unable to Create Object - wtPayment.CPayment"
		Else
			PaymentProcessed = True
			wtpay.processor = bvProcessor
			wtpay.account = bvAcct
			wtpay.Amount = bvAmount
			wtpay.description = bvPurpose
			wtpay.Check bvBank, "", bvRoute, bvCheckAcct, "", bvCheckNumber, bvCheckName, "", ""

			result = wtpay.process

			Select Case result
				Case -1    'Pending
					brReference = Left(wtPay.Reference,30)
					brResult = "PENDING: " + wtPay.ErrMsg
					ProcessCheck = 2
				Case 0    'Approved
					brReference = Left(wtPay.Reference,30)
					brResult = "APPROVED"
					ProcessCheck = 3
				Case Else 'Declined
					brResult = wtPay.ErrMsg
					ProcessCheck = 4
			End Select                     
		End If
		Set wtPay = Nothing
	End If

    If PaymentProcessed = False Then ProcessCheck = 0

End Function

%>


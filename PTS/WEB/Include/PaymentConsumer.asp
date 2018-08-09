<%
' Requires Billing.asp
' Requires Wallet.asp
' Requires Comm.asp
' Optionally Requires CommissionEmail.asp
'*****************************************************************************************************

Function GetPayment( ByVal bvCompanyID, ByVal bvConsumerID, ByVal bvPaymentID, ByVal bvPayType, ByVal bvPayDesc, ByVal bvAmount, ByVal bvPurpose, ByVal bvProcessor, ByVal bvAcct, ByVal bvPostProcess, ByVal bvEmailBonuses )
On Error Resume Next
'Test = 1
Test = 0

	Set wtPay = server.CreateObject("wtPayment.CPayment")
	If wtPay Is Nothing Then
		Response.write "Error Creating Object - wtPayment.CPayment"
	End If
	Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
	If oBilling Is Nothing Then
		Response.write "Error Creating Object - ptsBillingUser.CBilling"
	End If
	Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
	If oPayment Is Nothing Then
		Response.write "Error Creating Object - ptsPaymentUser.CPayment"
	End If
	Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
	If oCompany Is Nothing Then
		Response.write "Error Creating Object - ptsCompanyUser.CCompany"
	End If

	PaymentBilling bvPayDesc, oBilling

	PaymentProcessed = False
    Result = 0 

    'Process Cash, P.O., STP and Bitcoin Payments (set pending status)
    If bvPayType = 7 Or bvPayType = 8 Or bvPayType = 13 Or bvPayType = 14 Then
		PaymentProcessed = False
'		PaymentProcessed = True
'        Result = -1
    End If

	If (bvProcessor > 0 And bvAcct <> "") Or bvPayType = 10 Then
	    With wtPay
	        .PaymentID = bvPaymentID
	        .Amount = bvAmount
	        .description = bvPurpose
	        .reference = bvConsumerID
	        .processor = bvProcessor
	        .account = bvAcct
	        .callback = "http://" + reqSysServerName + reqSysServerPath + "1000.asp"
	    End With
	    Select Case bvPayType
	    Case "1", "2", "3", "4"	'Process Credit Cards
			PaymentProcessed = True
            If bvProcessor = 14 Then 'NMI required name
                If .CardName = "" Then .CardName = "Fred Smith"
            End If
			With oBilling
				wtpay.Card .CardNumber, .CardMo, .CardYr, .CardName, .CardCode, .Zip
                wtPay.Address .Street1, .Street2, .City, .State, .Zip, .CountryCode
			End With
            If bvProcessor = 18 Then 'Chain Commerce required email address
                wtpay.Customer "", "", "", "finance@nexxusuniversity.com"
            End If
            If Test = 0 Then
                Result = wtpay.process 
                LogFile "PaymentConsumer", CStr(CompanyID) + "/#" + CStr(bvConsumerID) + "/" + CStr(bvPaymentID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " - " + CSTR(Result)
            End If
            
	    Case "5" 'Process Electronic Checks
			PaymentProcessed = True
			With oBilling
				wtpay.Check .CheckBank, .CheckRoute, .CheckAcct, .CheckAcctType, .CheckNumber, .CheckName
			End With
            If Test = 0 Then
                Result = wtpay.process 
                LogFile "PaymentConsumer", CStr(CompanyID) + "/#" + CStr(bvConsumerID) + "/" + CStr(bvPaymentID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " - " + CSTR(Result)
            End If

	    Case "11", "12", "13", "14" 'Process Wallets
   			PaymentProcessed = True
			With oBilling
				wtpay.Wallet .CardName
			End With
            If Test = 0 Then
                Result = wtpay.process 
                LogFile "PaymentConsumer", CStr(CompanyID) + "/#" + CStr(bvConsumerID) + "/" + CStr(bvPaymentID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " - " + CSTR(Result)
            End If

    	End Select
	End If

    If PaymentProcessed = True Then
	    Select Case Result
	    Case -1	'Pending
		    tmpReference = Left(wtPay.Reference,30)
		    tmpMsg = "PENDING: " + wtPay.ErrMsg
		    tmpStatus = 1
	    Case 0	'Approved
		    tmpReference = Left(wtPay.Reference,30)
		    tmpMsg = "APPROVED"
		    tmpStatus = 3
	    Case Else	'Declined
		    tmpReference = ""
		    tmpMsg = wtPay.ErrMsg
		    tmpStatus = 4
            LogFile "PaymentError", CStr(CompanyID) + "/#" + CStr(bvConsumerID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " (" + tmpMsg + ")"
	    End Select	
	Else
	    tmpStatus = 1
	    tmpMsg = "NOT PROCESSED"
	End If

    NewPaymentID = 0
    'Update new payment 
    If bvPaymentID = 0 Then
        If tmpStatus < 4 Then 'Not Declined
	        With oPayment
		        .SysCurrentLanguage = reqSysLanguage
		        .Load 0, 1
		        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
		        .CompanyID = bvCompanyID
		        .OwnerType = 151
		        .OwnerID = bvConsumerID
		        .PayDate = reqSysDate
		        If tmpStatus = 3 Then .PaidDate = reqSysDate
		        .PayType = bvPayType
		        .Status = tmpStatus
		        .Amount = bvAmount
		        .Total = bvAmount
		        .Description = bvPayDesc
		        .Purpose = bvPurpose
		        .Notes = tmpMsg
		        .Reference = tmpReference
		        .CommStatus = 1
		        NewPaymentID = CLng(.Add(CLng(reqSysUserID)))
		        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
	        End With
	    End If
    Else
        'Update existing payment
	    With oPayment
		    .Load bvPaymentID, 1
		    .Status = tmpStatus
            'Set PayType if paid with Wallet
		    .Notes = .Notes + " " + tmpMsg
		    .Reference = tmpReference
	        If tmpStatus = 3 Then .PaidDate = reqSysDate
		    .Save 1
	    End With
    End If

    'If this is a new payment
    If bvPaymentID = 0 Then
        'If the new payment was processed successfully, return the new payment ID
        If NewPaymentID > 0 Then
            bvPaymentID = NewPaymentID    
            GetPayment = CStr(NewPaymentID)
        Else
            GetPayment = tmpMsg
        End If
    Else
        If tmpStatus < 4 Then
            GetPayment = CStr(tmpStatus)
        Else
            GetPayment = tmpMsg
        End If    
    End If

    If bvPaymentID > 0 Then
        'Call custom company payment post processing
        If bvPostProcess <> 0 Then
            oCompany.Custom bvCompanyID, 99, 0, bvPaymentID, 0
            'Email Bonus Notice for approved payment created bonuses
            If bvEmailBonuses <> 0 And tmpStatus = 3 Then CommissionEmail bvCompanyID, bvPaymentID, 0, 0, tmpTotal
        End If
    End If

	Set oCompany = Nothing
	Set oPayment = Nothing
	Set oBilling = Nothing
	Set wtPay = Nothing

End Function

%>
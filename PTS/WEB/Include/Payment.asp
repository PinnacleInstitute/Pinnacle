<%
' Requires Billing.asp
' Requires Wallet.asp
' Requires Comm.asp
' Optionally Requires CommissionEmail.asp
'*****************************************************************************************************
Function ProcessPayments( ByVal bvCompanyID, ByVal bvOwnerType, ByVal bvPayDate, ByVal bvPostProcess )
On Error Resume Next
    
    Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
    If oCoption Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
    Else
        With oCoption
            .FetchCompany CLng(bvCompanyID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCardProcessor = .MerchantCardType
            tmpCardAcct = .MerchantCardAcct
            tmpCheckProcessor = .MerchantCheckType
            tmpCheckAcct = .MerchantCheckAcct
			tmpWalletType = .WalletType
			tmpWalletAcct = .WalletAcct
			EmailBonuses = InStr(.Shopping, "N")
        End With
    End If
    Set oCoption = Nothing
    
    Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
    If oPayments Is Nothing Then
	    Response.write "Error Creating Object - ptsPaymentUser.CPayments"
    End If
    
    oPayments.ListSubmittedCCCK bvCompanyID, bvOwnerType, bvPayDate
    
	good = 0
	bad = 0
	For Each oItem in oPayments
        With oItem
            tmpProcessor = ""
            tmpAcct = ""
	        Select Case .PayType
	        Case "1", "2", "3", "4"	'Process Credit Cards
	            tmpProcessor = tmpCardProcessor
	            tmpAcct = tmpCardAcct
	        Case "5" 'Process Electronic Checks
	            tmpProcessor = tmpCheckProcessor
	            tmpAcct = tmpCheckAcct
			Case 11, 12, 13, 14 'Process Wallets
				tmpProcessor = GetWalletProcessor( tmpWalletType, tmpWalletAcct, .PayType, tmpAcct )
	        End Select
            Result = GetPayment( bvCompanyID, 0, .PaymentID, .PayType, .Description, .Amount, .Purpose, tmpProcessor, tmpAcct, bvPostProcess, EmailBonuses )
            Select Case Result
            Case "0" 'Not processed
            Case "3"
                good = good + 1
            Case Else
                bad = bad + 1
            End Select
        End With
	Next
	      
	Set oPayments = Nothing

	ProcessPayments = CStr(good) + "|" + CStr(bad)

End Function

'*****************************************************************************************************
Function GetPayment( ByVal bvCompanyID, ByVal bvMemberID, ByVal bvPaymentID, ByVal bvPayType, ByVal bvPayDesc, ByVal bvAmount, ByVal bvPurpose, ByVal bvProcessor, ByVal bvAcct, ByVal bvPostProcess, ByVal bvEmailBonuses )
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

    'Process Cash, P.O., STP, Bitcoin, Nexxus Payments (set pending status)
    If bvPayType = 7 Or bvPayType = 8 Or bvPayType = 13 Or bvPayType = 14 Or bvPayType = 16 Or bvPayType = 21 Then
		PaymentProcessed = False
'		PaymentProcessed = True
'        Result = -1
    End If

	If (bvProcessor > 0 And bvAcct <> "") Or bvPayType = 10 Then
	    With wtPay
	        .PaymentID = bvPaymentID
	        .Amount = bvAmount
	        .description = bvPurpose
	        .reference = bvMemberID
	        .processor = bvProcessor
	        .account = bvAcct
	        .callback = "http://" + reqSysServerName + reqSysServerPath + "1000.asp"
	    End With
	    Select Case bvPayType
        Case "1", "2", "3", "4"	'Process Credit Cards
            PaymentProcessed = True
            With oBilling
                If bvProcessor = 14 And .CardName = "" Then .CardName = "Fred Smith" 'NMI required name
                wtpay.Card .CardNumber, .CardMo, .CardYr, .CardName, .CardCode, .Zip
                wtPay.Address .Street1, .Street2, .City, .State, .Zip, .CountryCode
                If IsNumeric(.Token) Then 
                    If Clng(.Token) > 0 Then wtPay.Data = .Token
                End If
                tmpCardNumber = .CardNumber
            End With
            If bvProcessor = 18 Then 'Chain Commerce required email address
            wtpay.Customer "", "", "", "finance@nexxusuniversity.com"
            End If
            If Test = 0 Then
                'Custom Payment Validation 
                Result = oPayment.Custom( 1, tmpCardNumber, bvCompanyID, bvPaymentID )  
                If Result > 0 Then
                    Result = 4
                    wtPay.ErrMsg = "Credit Card Number Disallowed Twice in the Same Day"
                Else
                    Result = wtpay.process 
' Disable Credit Card Processing for later
'                    Result = 0
'                    wtPay.Reference = "PENDING"
                End If
                LogFile "Payment", CStr(CompanyID) + "/#" + CStr(bvMemberID) + "/" + CStr(bvPaymentID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " - " + CSTR(Result)
            End If
            
	    Case "5" 'Process Electronic Checks
            PaymentProcessed = True
            With oBilling
                wtpay.Check .CheckBank, .CheckRoute, .CheckAcct, .CheckAcctType, .CheckNumber, .CheckName
            End With
            If Test = 0 Then
                Result = wtpay.process 
                LogFile "Payment", CStr(CompanyID) + "/#" + CStr(bvMemberID) + "/" + CStr(bvPaymentID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " - " + CSTR(Result)
            End If

	    Case "11", "12", "13", "14" 'Process Wallets
            PaymentProcessed = True
            With oBilling
                wtpay.Wallet .CardName
            End With
            If Test = 0 Then
                Result = wtpay.process 
                LogFile "Payment", CStr(CompanyID) + "/#" + CStr(bvMemberID) + "/" + CStr(bvPaymentID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " - " + CSTR(Result)
            End If

	    Case "10" 'Process Internal Pinnacle Wallet
            PaymentProcessed = True
            tmp = oCompany.Custom( bvCompanyID, 98, 0, bvPaymentID, bvMemberID )
            If tmp = 0 Then
                Result = 4
            Else
                Result = 0
                wtPay.Reference = tmp
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
            LogFile "PaymentError", CStr(CompanyID) + "/#" + CStr(bvMemberID) + " " + CStr(bvAmount) + " " + bvPurpose + " - " + bvPayDesc + " (" + tmpMsg + ")"
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
		        .OwnerType = 4
		        .OwnerID = bvMemberID
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

'*****************************************************************************************************
Function SubmitPayment( ByVal bvCompanyID, ByVal bvMemberID, ByVal bvPayType, ByVal bvPayDesc, ByVal bvAmount, ByVal bvPurpose, ByVal bvPostProcess )
    On Error Resume Next
    NewPaymentID = 0
    
	Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
	If oPayment Is Nothing Then
		Response.write "Error Creating Object - ptsPaymentUser.CPayment"
    Else
        With oPayment
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .CompanyID = bvCompanyID
            .OwnerType = 4
            .OwnerID = bvMemberID
            .PayDate = reqSysDate
            .PayType = bvPayType
            .Status = 1
            .Amount = bvAmount
            .Total = bvAmount
            .Description = bvPayDesc
            .Purpose = bvPurpose
            .CommStatus = 1
            NewPaymentID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
        End With

        If bvPostProcess <> 0 Then
	        Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
	        If oCompany Is Nothing Then
		        Response.write "Error Creating Object - ptsCompanyUser.CCompany"
		    Else    
                oCompany.Custom bvCompanyID, 99, 0, NewPaymentID, 0
	        End If
    	    Set oCompany = Nothing
        End If
    End If
	Set oPayment = Nothing
	
    SubmitPayment = NewPaymentID

End Function

'*****************************************************************************************************
Function SetVault( ByVal bvCompanyID, ByVal bvBillingID )
On Error Resume Next
    'Token = 0 ... Create 
    'Token > 0 ... Update 
    'Token < 0 ... Delete 

    Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
    If oCoption Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
    Else
        With oCoption
            .FetchCompany CLng(bvCompanyID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCardProcessor = .MerchantCardType
            tmpCardAcct = .MerchantCardAcct
        End With
    End If
    Set oCoption = Nothing

	Set wtPay = server.CreateObject("wtPayment.CPayment")
	If wtPay Is Nothing Then
		Response.write "Error Creating Object - wtPayment.CPayment"
	End If
	Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
	If oBilling Is Nothing Then
		Response.write "Error Creating Object - ptsBillingUser.CBilling"
	End If

    tmpToken = 0

    With oBilling
        .Load bvBillingID, 1
        If IsNumeric(.Token) Then tmpToken = .Token
        tmpCardName = .CardName
        tmpCardNumber = .CardNumber
        tmpCardMo = .CardMo
        tmpCardYr = .CardYr
        tmpCardCode = .CardCode
        tmpStreet1 = .Street1
        tmpStreet1 = .Street1
        tmpCity = .City
        tmpState = .State
        tmpZip = .Zip
        tmpCountryName = .CountryName
    End With

    With wtPay
        .Processor = tmpCardProcessor
        .Account = tmpCardAcct
        If Clng(tmpToken) > 0 Then .Data = tmpToken
        .Card tmpCardNumber, tmpCardMo, tmpCardYr, tmpCardName, tmpCardCode, tmpZip
        .Address tmpStreet1, tmpStreet2, tmpCity, tmpState, tmpZip, tmpCountryName
        result = .Vault
    End With

    If tmpToken = 0 And result > 0 Then
        With oBilling
            .Token = result
            .Save 1
        End With
    End If
    
	Set oBilling = Nothing
	Set wtPay = Nothing

    SetVault = result

End Function


%>
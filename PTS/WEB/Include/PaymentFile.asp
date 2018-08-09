<%
' Requires Billing.asp
'*****************************************************************************************************
Function ExportPayments( byVal CompanyID, ByVal bvOwnerType, ByVal bvPayDate, byRef reqCCTotal, byRef reqCKTotal, byRef reqCCFile, byRef reqCKFile, byRef reqError)
	On Error Resume Next
    
	Dim oFileSys, oCCFile, oCKFile, Rec
	Dim CardType, CardNumber, CardDate, CardCode, CardName
	Dim CheckBank, CheckRoute, CheckAccount, CheckNumber, CheckName, CheckAcctType
	Dim FinanceEmail, CardProcessor, CheckProcessor, CardAcct, CheckAcct, FileExt
	
    Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
    If oCoption Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
    Else
        With oCoption
            .FetchCompany CompanyID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
			CardProcessor = .MerchantCardType
			CheckProcessor = .MerchantCheckType
			CardAcct = .MerchantCardAcct
			CheckAcct = .MerchantCheckAcct
        End With
    End If
    Set oCoption = Nothing

   Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
   If oBusiness Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
   Else
      With oBusiness
         .SysCurrentLanguage = reqSysLanguage
         .Load 1, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
			FinanceEmail = .FinanceEmail
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBusiness = Nothing

	IF (CardProcessor <> 0 Or CheckProcessor <> 0) And FinanceEmail = "" Then reqError = "ERROR: Missing Finance Email Address!"
	IF CardProcessor <> 0 And CardAcct = "" Then reqError = "ERROR: Missing Credit Card - Account #!"
	IF CheckProcessor <> 0 And CheckAcct = "" Then reqError = "ERROR: Missing Bank Account - Account #!"
	FileExt = ".txt"
	SELECT CASE CardProcessor
		CASE 0   ' Default
        	FileExt = ".csv"
		CASE 6   ' Merchant Partner
		CASE 10  ' Pay Junction
		CASE ELSE
		    CardProcessor = 0
			'reqError = "ERROR: Unsupported Credit Card Processor! " & CardProcessor
	END SELECT
	SELECT CASE CheckProcessor
		CASE 0  ' Default
        	FileExt = ".csv"
		CASE 7  ' Merchant Partners
		CASE ELSE
		    CheckProcessor = 0
			'reqError = "ERROR: Unsupported Bank Account Processor! " & CheckProcessor
	END SELECT

	IF reqError = "" Then	
	
		Set oFileSys = CreateObject("Scripting.FileSystemObject")
		If oFileSys Is Nothing Then
		   Response.Write "Scripting.FileSystemObject failed to load"
		   Response.End
		End If
	    Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
	    If oBilling Is Nothing Then
		    Response.write "Error Creating Object - ptsBillingUser.CBilling"
	    End If

		Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
		If oPayments Is Nothing Then
		   DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayments"
		Else
			With oPayments
			.SysCurrentLanguage = reqSysLanguage
			.ListSubmittedCCCK CompanyID, bvOwnerType, bvPayDate
			If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

			Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Billing\" & CompanyID & "\"
			dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
			reqCCFile = "CC" + CSTR(CardProcessor) + "-" + dt + FileExt
			reqCKFile = "ACH" + CSTR(CheckProcessor) + "-" + dt + FileExt

			reqCCTotal = 0
			reqCKTotal = 0
			CKAmt = 0
			CKHsh = 0
			For Each oItem in oPayments
				With oItem

					tmpPaymentID = .PaymentID
					tmpAmount = .Amount
                	PaymentBilling .Description, oBilling

					'Process Credit Cards
					If .PayType >= 1 AND .PayType <= 4 Then
						If reqCCTotal = 0 Then
							Set oCCFile = oFileSys.CreateTextFile(Path + reqCCFile, True)
							If oCCFile Is Nothing Then
								Response.Write "Couldn't create CC file: " + Path + reqCCFile
								Response.End
							End If
							'Write File Header
							Select Case CardProcessor
							Case 0 'Default
                                Rec = "PaymentID,Amount,CardType,CardNumber,CardMo,CardYr,CardCode,CardName,Street1,Street2,City,State,Zip,CountryCode"
								oCCFile.WriteLine(Rec)
							Case 6 'Merchant Partner: RecordType, Email Addresses
								Rec = "EmailReceiptTo" & VBTAB & FinanceEmail 
								oCCFile.WriteLine(Rec)
							Case 10 'Pay Junction
							End Select
						End If
						cnt = 1
						
						With oBilling
						    'Write Transaction Record
						    Select Case CardProcessor
						    Case 0 'Default
                                Rec = tmpPaymentID & "," & tmpAmount & "," & .CardType & "," & CHR(34) & .CardNumber & CHR(34) & "," & .CardMo & "," & .CardYr & "," & .CardCode & "," & CHR(34) & .CardName & CHR(34) & "," & + CHR(34) & .Street1 & CHR(34) & "," & + CHR(34) & .Street2 & CHR(34) & "," & + CHR(34) & .City & CHR(34) & "," & + CHR(34) & .State & CHR(34) & "," & + CHR(34) & .Zip & CHR(34) & "," & + CHR(34) & .CountryCode & CHR(34)
							    oCCFile.WriteLine( Rec )
							    
						    Case 6 'Merchant Partner: TransactionID, RecordType, AcctID, Amount, CCName, CCNum, CCExpMonth, CCExpYear
							    CCExpMonth = .CardMo
							    CCExpYear = .CardYr
							    If Len(CCExpMonth) = 1 Then CCExpMonth = "0" + CCExpMonth
							    If Len(CCExpYear) = 1 Then CCExpYear = "0" + CCExpYear
							    If CCExpYear <> "" Then CCExpYear = "20" + CCExpYear

							    Rec = tmpPaymentID & VBTAB & "ns_quicksale_cc" & VBTAB & CardAcct & VBTAB & tmpAmount & VBTAB & .CardName & VBTAB & .CardNumber & VBTAB & .CCExpMonth & VBTAB & .CCExpYear 
							    'Add CVV2 field, locatred in cloumn #37
							    If CardCode <> "" Then
								    tmpCVV2 = VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB + .CardCode
							    Else
								    tmpCVV2 = ""
							    End If
							    oCCFile.WriteLine( Rec + tmpCVV2 )
							    
						    Case 10 'Pay Junction: "action", "credit_card_number", "expiration", "name", "invoice", "amount", "address", "zip", "verification" 
											      '"charge", "4444333322221111", "0104", "PayJunction", "", "1.00", "12 main st.", "90210", "123" 
							    CCExpMonth = .CardMo
							    CCExpYear = .CardYr
							    If Len(CCExpMonth) = 1 Then CCExpMonth = "0" + CCExpMonth
							    If Len(CCExpYear) = 1 Then CCExpYear = "0" + CCExpYear
							    Rec = """" + "charge" + """,""" + .CardNumber + """,""" + CCExpMonth + CCExpYear + """,""" + .CardName + """,""" + tmpPaymentID + """,""" + tmpAmount + """,""" + "" + """,""" + .CardZip  + """,""" + .CardCode  + """"  
							    oCCFile.WriteLine( Rec )
							    
						    End Select
						    reqCCTotal = reqCCTotal + 1
                        End With						
					End If

					'Process Bank Accounts
					If .PayType = 5 Then
						If reqCKTotal = 0 Then
							Set oCKFile = oFileSys.CreateTextFile(Path + reqCKFile, True)
							If oCKFile Is Nothing Then
								Response.Write "Couldn't create CK file: " + Path + reqCKFile
								Response.End
							End If
							'Write File Header
							Select Case CheckProcessor
							Case 0 'Default
                    			Rec = "PaymentID,Amount,CheckBank,CheckRoute,CheckAccount,CheckNumber,CheckName,CheckAcctType"
								oCKFile.WriteLine(Rec)
							Case 7 'Merchant Partner: RecordType, Email Addresses
								Rec = "EmailReceiptTo" & VBTAB & FinanceEmail 
								oCKFile.WriteLine(Rec)
							End Select
						End If
						cnt = 1

						With oBilling
						    'Write Transaction Record
						    Select Case CheckProcessor
						    Case 0 'Default
                    			Rec = tmpPaymentID & "," & tmpAmount & "," & CHR(34) & .CheckBank & CHR(34) & "," & + CHR(34) & .CheckRoute & CHR(34) & "," & + CHR(34) & .CheckAccount & CHR(34) & "," & + CHR(34) & .CheckNumber & CHR(34) & "," & + CHR(34) & .CheckName & CHR(34) & "," & .CheckAcctType
							    oCKFile.WriteLine(Rec)
							    
						    Case 7 'Merchant Partner: TransactionID, RecordType, AcctID, Amount, CKName, CKABA, CKAccount
							    Rec = tmpPaymentID & VBTAB & "ns_quicksale_check" & VBTAB & .CheckAcct & VBTAB & tmpAmount & VBTAB & .CheckName & VBTAB & .CheckRoute & VBTAB & .CheckAccount 
							    oCKFile.WriteLine(Rec)

						    End Select
						    reqCKTotal = reqCKTotal + 1
                        End With						
					End If

				End With
			Next

			If reqCCTotal > 0 Then
				'Write File Footer
				Select Case CardProcessor
			    Case 0 'Default
				Case 6  'Merchant Partner:
				Case 10 'Pay Junction:
				End Select
				oCCFile.Close
			End If	
			
			If reqCKTotal > 0 Then
				'Write File Footer
				Select Case CheckProcessor
			    Case 0 'Default
				Case 7 'Merchant Partner:
				End Select
				oCKFile.Close
			End If	

			Set oCCFile = Nothing
			Set oCKFile = Nothing

			End With
		End If

		Set oPayments = Nothing
		Set oBilling = Nothing
		Set oFileSys = Nothing

	End If
	
End Function


%>


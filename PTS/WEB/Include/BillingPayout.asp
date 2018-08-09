<%
Function BillingPayout( byval oBilling)
	On Error Resume Next
	With oBilling    
		If .CommType = 0 Then 
			BillingPayout = "Pay:[Not Specified]"
		End If
		If .CommType = 1 Then 'Credit Card
			BillingPayout = "Pay:[" + .CardType + "; " + .CardNumber + "; " + .CardMo + "/" + .CardYr + "; " + .CardCode + "; " + .CardName + "; " + .Street1 + "; " + .Street2 + "; " + .City + "; " + .State + "; " + .Zip + "; " + .CountryCode + "]"
		End If
		If .CommType = 2 Then  'eCheck
			BillingPayout = "Pay:[" + .CheckBank + "; " + .CheckRoute + "; " + .CheckAccount + "; " + .CheckNumber + "; " + .CheckName + "; " + .CheckAcctType + "]"
		End If
		If .CommType = 3 Then 'Paper Check
			BillingPayout = "Pay:[" + .BillingName + "; " + .Street1 + "; " + .Street2 + "; " + .City + "; " + .State + "; " + .Zip + "; " + .CountryName + "]"
		End If
		If .CommType = 4 Then 'eWallet
            If .CardType = 10 Then
    			BillingPayout = "Pay:[" + .CardType + "]"
            Else
    			BillingPayout = "Pay:[" + .CardType + "; " + .CardName + "]"
            End If
		End If
		If .CommType = 5 Then 'None
			BillingPayout = "Pay:[None]"
		End If
	End With
End Function

Function PayoutBilling( byval bvPayout, byref oBilling)
	On Error Resume Next
	Dim pos, Payment, tmp
		
	oBilling.CommType = 0

	pos = InStr(bvPayout, "Pay:[")
	If pos > 0 Then
		bvPayout = Mid(bvPayout, pos + 5)
		pos = InStr(bvPayout, "]")
		If pos > 0 Then bvPayout = Left(bvPayout, pos - 1)
	End If

	If pos > 0 And Len(bvPayout) > 0 Then
		Payment = Split(bvPayout, ";")
		cnt = UBOUND(Payment)
		'Credit Cards and eWallets
		If IsNumeric( Payment(0) ) Then
    		'Credit Cards
    		If cnt > 2 Then
			    With oBilling
				    .CommType = 1
				    If cnt >= 0 Then .CardType = TRIM(Payment(0))
				    If cnt >= 1 Then .CardNumber = TRIM(Payment(1))
				    If cnt >= 2 Then
					    tmp = TRIM(Payment(2))
					    pos = InStr(tmp, "/")
					    If pos > 0 Then
						    .CardMo = Left(tmp, pos - 1)
						    .CardYr = Mid(tmp, pos + 1)
					    End If
				    End If	 
				    If cnt >= 3 Then .CardCode = TRIM(Payment(3))
				    If cnt >= 4 Then .CardName = TRIM(Payment(4))
				    If cnt >= 5 Then .Street1 = TRIM(Payment(5))
				    If cnt >= 6 Then .Street2 = TRIM(Payment(6))
				    If cnt >= 7 Then .City = TRIM(Payment(7))
				    If cnt >= 8 Then .State = TRIM(Payment(8))
				    If cnt >= 9 Then .Zip = TRIM(Payment(9))
				    If cnt >= 10 Then .CountryCode = TRIM(Payment(10))
			    End With
			Else
        		'eWallets
			    With oBilling
				    .CommType = 4
				    If cnt >= 0 Then .CardType = TRIM(Payment(0))
				    If cnt >= 1 Then .CardName = TRIM(Payment(1))
			    End With
			End If
		Else 
			With oBilling
                If cnt = 6 Then 'Electronic Check
				    .CommType = 2
				    .CheckBank = TRIM(Payment(0))
				    .CheckRoute = TRIM(Payment(1))
				    .CheckAccount = TRIM(Payment(2))
				    .CheckNumber = TRIM(Payment(3))
				    .CheckName = TRIM(Payment(4))
				    .CheckAcctType = TRIM(Payment(5))
                End If
                If cnt = 7 Then 'Paper Check
				    .CommType = 3
				    .BillingName = TRIM(Payment(0))
				    .Street1 = TRIM(Payment(1))
				    .Street2 = TRIM(Payment(2))
				    .City = TRIM(Payment(3))
				    .State = TRIM(Payment(4))
				    .Zip = TRIM(Payment(5))
				    .CountryName = TRIM(Payment(6))
                End If
			End With	
		End If
	End If
	   
End Function

Function BillingPayoutType( byval oBilling)
	On Error Resume Next
	With oBilling    
	    Select Case .CommType
	    Case 1: BillingPayoutType = 1
	    Case 2: BillingPayoutType = 2
	    Case 3: BillingPayoutType = 3
	    Case 4: BillingPayoutType = .CardType
	    End Select
	End With
End Function

%>


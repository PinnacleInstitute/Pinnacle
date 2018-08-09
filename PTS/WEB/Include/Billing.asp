<%
Function BillingPayment( byval oBilling)
	On Error Resume Next
	With oBilling    
		If .PayType = 0 Then
			BillingPayment = "Charged:[Not Specified]"
		End If
		If .PayType = 1 Then
			BillingPayment = "Charged:[" + .CardType + "; " + .CardNumber + "; " + .CardMo + "/" + .CardYr + "; " + .CardCode + "; " + .CardName + "; " + .Street1 + "; " + .Street2 + "; " + .City + "; " + .State + "; " + .Zip + "; " + .CountryCode + "; " + .Token + "]"
		End If
		If .PayType = 2 Then
			BillingPayment = "Charged:[" + .CheckBank + "; " + .CheckRoute + "; " + .CheckAccount + "; " + .CheckNumber + "; " + .CheckName + "; " + .CheckAcctType + "]"
		End If
		If .PayType = 3 Then
			BillingPayment = "Charged:[Cash]"
		End If
		If .PayType = 4 Then
            If .CardType = 10 Then
			    BillingPayment = "Charged:[" + .CardType + "]"
            Else
			    BillingPayment = "Charged:[" + .CardType + "; " + .CardName + "]"
            End If
		End If
		If .PayType = 5 Then
			BillingPayment = "Charged:[None]"
		End If
	End With
End Function

Function PaymentBilling( byval reqPayment, byref oBilling)
	On Error Resume Next
	Dim pos, Payment, tmp
		
	oBilling.PayType = 0

	pos = InStr(reqPayment, "Charged:[")
	If pos > 0 Then
		reqPayment = Mid(reqPayment, pos + 9)
		pos = InStr(reqPayment, "]")
		If pos > 0 Then reqPayment = Left(reqPayment, pos - 1)
	End If

	If pos > 0 And Len(reqPayment) > 0 Then
		Payment = Split(reqPayment, ";")
		cnt = UBOUND(Payment)
		'Credit Cards and eWallets
		If IsNumeric( Payment(0) ) Then
    		'Credit Cards
    		If CLng(Payment(0)) < 10 Then
			    With oBilling
				    .PayType = 1
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
				    If cnt >= 11 Then .Token = TRIM(Payment(11))
			    End With
			Else
        		'eWallets
			    With oBilling
				    .PayType = 4
				    If cnt >= 0 Then .CardType = TRIM(Payment(0))
				    If cnt >= 1 Then .CardName = TRIM(Payment(1))
			    End With
			End If
		Else 'Electronic Check
			With oBilling
				.PayType = 2
				If cnt >= 0 Then .CheckBank = TRIM(Payment(0))
				If cnt >= 1 Then .CheckRoute = TRIM(Payment(1))
				If cnt >= 2 Then .CheckAccount = TRIM(Payment(2))
				If cnt >= 3 Then .CheckNumber = TRIM(Payment(3))
				If cnt >= 4 Then .CheckName = TRIM(Payment(4))
				If cnt >= 5 Then .CheckAcctType = TRIM(Payment(5))
			End With	
		End If
	End If
	   
End Function

%>


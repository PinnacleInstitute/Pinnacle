<%

'**************************************************************************************
Function CalcRegularPayoff(ByVal bvBalance, ByVal bvPayment, ByVal bvIntRate, ByRef brIntPaid, ByRef brMonths )

MoRate = (CleanNumber(bvIntRate) / 12) / 100
bvBalance = CleanNumber(bvBalance) * 1.00
Balance = bvBalance
Payment = CleanNumber(bvPayment)
IntPaid = 0.00
Months = 0

'If Balance increases, the payment is too small to cover the interest
While Balance > 0 And Balance <= bvBalance
	Months = Months + 1
	Interest = Round(Balance * MoRate, 2)
	IntPaid = IntPaid + Interest
	Balance = Balance + Interest
	Balance	= Balance - Payment
'response.write "<BR>...Month: " & Months & " - " & FormatCurrency(Balance) & " - " & FormatCurrency(Payment)
'response.write " - " & FormatCurrency(Interest) & " - " & FormatCurrency(IntPaid)
Wend

'Check for insufficient payment to payoff debt.
If Balance > bvBalance Then
	brIntPaid = 0
	brMonths = -1
Else
	brIntPaid = IntPaid
	brMonths = Months
End If

End Function

'**************************************************************************************
Function CleanNumber( ByVal bvString )
	CleanedString = ""
	For i = 1 to Len(bvString)
		strChar = mid(bvString,i,1)
		If InStr(".0123456789",strChar) Then CleanedString = CleanedString + strChar
	Next
	If CleanedString = "" Then CleanedString = "0"
	CleanNumber = CleanedString
End Function

'**************************************************************************************
Function YrMo( ByVal bvMonths )
	tmpStr = ""
	yr = Int(bvMonths / 12)
	If yr > 0 Then tmpStr = tmpStr + CStr(yr) + " Yr "
	mo = bvMonths Mod 12
	If mo > 0 Then tmpStr = tmpStr + CStr(mo) + " Mo"
	YrMo = tmpStr
End Function

%>


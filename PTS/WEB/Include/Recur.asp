<%
Function GetRecur(ByRef brStartDate, ByRef brEndDate, ByVal bvRecur, ByVal bvTerm )

brStartDate = 0
brEndDate = 0

If bvRecur > 0 Then

	 brStartDate = Date()

	'Test for monthly interval
	pos = InStr(bvTerm, "m")
	If pos > 0 Then 
		num = Left(bvTerm, pos-1)
		If IsNumeric(num) Then
			brStartDate = DateAdd("m", CLng(num), brStartDate )
		End If
	Else
		'Test for weekly interval
		pos = InStr(bvTerm, "w")
		If pos > 0 Then 
			num = Left(bvTerm, pos-1)
			If IsNumeric(num) Then
				brStartDate = DateAdd("ww", CLng(num), brStartDate )
			End If
		Else
			'Test for daily interval
			pos = InStr(bvTerm, "d")
			If pos > 0 Then 
				num = Left(bvTerm, pos-1)
				If IsNumeric(num) Then
					brStartDate = DateAdd("d", CLng(num), brStartDate )
				End If
			End If
		End If
	End If

	'Test for number of payments
	pos = InStr(bvTerm, "-")
	If pos > 0 Then 
		num = mid(bvTerm, pos+1)
		If IsNumeric(num) AND num > 1 Then
			Select Case bvRecur
			Case 1: 'Monthly
				brEndDate = DateAdd("m", CLng(num)-1, brStartDate )
			Case 2: 'Weekly
				brEndDate = DateAdd("ww", CLng(num)-1, brStartDate )
			End Select	
		End If
	End If

End If

End Function

%>


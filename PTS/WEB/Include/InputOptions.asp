<%
Function DoInputOptions( ByVal bvOptions, ByVal bvValues, ByRef brPrice, ByVal bvSecure)
   On Error Resume Next

    Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
	With oInputOptions

		.Load bvOptions, bvValues

		Total = .Count
		If Total > 0 Then
			For x = 1 to Total
				If bvSecure = 0 OR reqSysUserGroup <= bvSecure OR oInputOptions.Item(x).Secure = 0 Then
				Nam = .Item(x).Name
				.Item(x).Value = Request.Form.Item(Nam)
				End If
			Next
		End If

		.Validate
		If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

		DoInputOptions = .Values
		brPrice = .TotalPrice
		
	End With
    Set oInputOptions = Nothing

End Function

Function IsValidInputOptions( ByVal bvOptions, ByVal bvValues)
   On Error Resume Next
    Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
	With oInputOptions
		.Load bvOptions, bvValues
		.Validate
		If (Err.Number <> 0) Then
			Err.Clear
			IsValidInputOptions = 0
		Else	
			IsValidInputOptions = 1
		End If
	End With
    Set oInputOptions = Nothing
End Function

Function ValidateInputOptions( ByVal bvOptions, ByVal bvValues)
   On Error Resume Next
	tmpErrors = 0
    Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
	With oInputOptions
		.Load bvOptions, bvValues
		.Validate
		If (Err.Number <> 0) Then
			DoError Err.Number, Err.Source, Err.Description 
			tmpErrors = tmpErrors + 1			
		End If
	End With
    Set oInputOptions = Nothing
    ValidateInputOptions = tmpErrors
End Function


%>


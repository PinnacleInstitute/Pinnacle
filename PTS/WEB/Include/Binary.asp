<%
'******************************************************
Function GetBinary( byval bvOptions )
	On Error Resume Next
	b = 0
    a = split(bvOptions, ",")
    total = UBOUND(a)
    For x = 0 to total
	    opt = a(x)
	    If left(opt,1) = "B" Then
	       b = 1
               If Len(opt) > 1 Then b = Mid(opt,2,1)	    
               Exit For	    
	    End If
    Next
    GetBinary = b
End Function

'******************************************************
Function SetBinary( byval bvOptions,  byval bvOption  )
	On Error Resume Next
	tmpOptions = "B" + CStr(bvOption)
    a = split(bvOptions, ",")
    total = UBOUND(a)
    For x = 0 to total
	    opt = a(x)
	    If left(opt,1) <> "B" Then
            tmpOptions = tmpOptions + "," + opt
	    End If
    Next
    SetBinary = tmpOptions	
End Function

%>


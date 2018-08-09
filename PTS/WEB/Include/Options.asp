<%
'**************************************************************************************
Function GetOptionValue(ByVal bvText, ByVal bvToken, ByVal bvSeparator )
    val = 0
    aText = split(bvText, bvSeparator)
    tokenLen = Len(bvToken)
    total = UBOUND(aText)
    For x = 0 to total
	    tmp = aText(x)
        If bvToken = Left(tmp,tokenLen) Then
            v = Mid(tmp,tokenLen+1)
            If IsNumeric(v) Then val = CLng(v)
            Exit For
        End If
    Next
    GetOptionValue = val
End Function
%>


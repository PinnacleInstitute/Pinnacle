<%
Function CSVArray( ByVal bvStr )
    Result = ""
    data = ""
    Do While bvStr <> ""
	    '---If the field is enclosed in quotes (i.e. it contains a comma), get the entire field
	    bvStr = LTrim(bvStr)
	    If Left(bvStr, 1) = """" Then
		    quote = True
		    bvStr = Mid(bvStr, 2)
		    pos = InStr(bvStr, """")
		    If pos > 0 Then pos = InStr(pos, bvStr, ",") Else quote = False
	    Else
		    quote = False
		    pos = InStr(bvStr, ",")
	    End If
	    If pos = 0 Then
		    data = bvStr
		    bvStr = ""
	    Else
		    data = Left(bvStr, pos - 1)
		    bvStr = Mid(bvStr, pos + 1)
	    End If
	    If quote Then data = Left(data, Len(data) - 1)

        If Result <> "" Then Result = Result + "|" 
        Result = Result + data    
    Loop

    CSVArray = Split( Result, "|")

End Function

%>


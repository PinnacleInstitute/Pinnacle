<%
Function ValidEmail( byval bvEmail)
	On Error Resume Next
	Set myRegExp = New RegExp
	myRegExp.IgnoreCase = True
	myRegExp.Global = True
'	myRegExp.Pattern = "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b"
'	myRegExp.Pattern = "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$"
	myRegExp.Pattern = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)\b"
	ValidEmail = myRegExp.Test( bvEmail )
End Function

%>


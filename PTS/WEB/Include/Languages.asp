<%

Function LanguagesXML(byval bvLanguages, byval bvBlank)
    On Error Resume Next
    str = "<PTSLANGUAGES>"
    If bvBlank = 1 Then 
		str = str + "<ENUM id=""" + "" + """ name=""" + "Select..." + """/>"
    End If
	aLanguages = Split( bvLanguages, ";" )
	total = UBOUND(aLanguages)
	For x = 0 to total
		aLanguage = split(aLanguages(x), ",")
		id = aLanguage(0)
		name = aLanguage(1)
		str = str + "<ENUM id=""" + id + """ name=""" + name + """/>"
	Next
    str = str + "</PTSLANGUAGES>"
    LanguagesXML = str
End Function

%>


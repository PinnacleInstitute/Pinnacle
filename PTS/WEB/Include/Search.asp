<%
Function SearchText(byval bvSearchText)
   On Error Resume Next
   tmpSearchText = bvSearchText
   If InStr(tmpSearchText, " ") Then
      tmp = LCase(tmpSearchText)
      If InStr(tmp, Chr(34)) = 0 And InStr(tmp, " and ") = 0 And InStr(tmp, " or ") = 0 And InStr(tmp, " near ") = 0 Then
         entry = Split(tmpSearchText)
         tmpSearchText = ""
         pos = 0
         Do While pos <= UBound(entry)
            Item = Trim(entry(pos))
            If Item <> "" Then
               If pos = 0 Then
                  tmpSearchText = "FORMSOF(INFLECTIONAL," + item + ")"
               Else
                  tmpSearchText = tmpSearchText + " OR " + "FORMSOF(INFLECTIONAL," + item + ")"
               End If
            End If
            pos = pos + 1
         Loop
      End If
   Else
      tmpSearchText = "FORMSOF(INFLECTIONAL," + tmpSearchText + ")"
   End If
   SearchText = tmpSearchText
End Function
%>


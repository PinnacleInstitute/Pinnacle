<%

Public Function Encript(byval str)
   str = str + str
   token = ""
   length = Len(str)
   For x = 1 To length
      c = Mid(str, x, 1)
      If IsNumeric(c) Then
         token = token + Chr(64 + CInt(c) + x)
      Else
         token = token + LCase(c)
      End If
   Next 
   Encript = token
End Function

Public Function Decript(byval str)
   str = Left(str, Len(str) / 2)
   token = ""
   length = Len(str)
   For x = 1 To length
      c = Mid(str, x, 1)
      If Asc(c) < Asc("a") Then
         token = token + Chr(Asc(c) - (16 + x))
      Else
         token = token + c
      End If
   Next 
   Decript = token
End Function

%>


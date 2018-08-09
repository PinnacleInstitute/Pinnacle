<%
Function GetDB()
   On Error Resume Next

   tmpXML = ""
   tmpData = GetCache("DASHBOARD")

   If Len(tmpData) > 0 Then
      tmpXML = "<PTSDB"
      cnt = 1
      While Len(tmpData) > 0
         pos = InStr(tmpData, ",")
         If pos > 0 Then
            token = Left(tmpData, pos - 1)
            tmpData = Mid(tmpData, pos + 1)
         Else
            token = tmpData
            tmpData = ""
         End If
         token = Trim(token)
         Select Case cnt
         Case 1: tmpXML = tmpXML + " mentorees=""" + token + """"
         Case 2: tmpXML = tmpXML + " mentornotes=""" + token + """"
         Case 3: tmpXML = tmpXML + " prospects=""" + token + """"
         Case 4: tmpXML = tmpXML + " prospects30=""" + token + """"
         Case 5: tmpXML = tmpXML + " prospectsactive=""" + token + """"
         End Select
         cnt = cnt + 1
      Wend
      GetDB = tmpXML + "/>"
   End If

End Function

Function SetDB(ByVal bvXML)
   On Error Resume Next
   
   tmpData = ""
   While Len(bvXML) > 0
      pos = InStr(bvXML, """")
      If pos > 0 Then
         pos2 = InStr(pos + 1, bvXML, """")
         If pos2 > 0 Then
            token = Mid(bvXML, pos + 1, pos2 - (pos + 1))
            bvXML = Mid(bvXML, pos2 + 1)
			Else
			   token = bvXML
			   bvXML = ""
         End If
      Else
         token = bvXML
         bvXML = ""
      End If
      token = Trim(token)
      If token <> "" Then tmpData = tmpData + token + ","
   Wend

   SetCache "DASHBOARD", tmpData

End Function


%>


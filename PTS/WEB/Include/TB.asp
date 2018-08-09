<%
Function GetTB()
   On Error Resume Next

   tmpXML = ""
   tmpData = GetCache("TBCOUNT")

   If Len(tmpData) > 0 Then
      tmpXML = "<PTSTB"
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
         Case 1: tmpXML = tmpXML + " companycoursevisit=""" + token + """"
         Case 2: tmpXML = tmpXML + " companycourse30=""" + token + """"
         Case 3: tmpXML = tmpXML + " companycoursetotal=""" + token + """"
         Case 4: tmpXML = tmpXML + " companycourseregister=""" + token + """"
         Case 5: tmpXML = tmpXML + " companycourseunregister=""" + token + """"
         Case 6: tmpXML = tmpXML + " publiccourseregister=""" + token + """"
         Case 7: tmpXML = tmpXML + " publiccoursevisit=""" + token + """"
         Case 8: tmpXML = tmpXML + " publiccourse30=""" + token + """"
         Case 9: tmpXML = tmpXML + " companyassessmentvisit=""" + token + """"
         Case 10: tmpXML = tmpXML + " companyassessment30=""" + token + """"
         Case 11: tmpXML = tmpXML + " companyassessmenttotal=""" + token + """"
         Case 12: tmpXML = tmpXML + " companyassessmenttaken=""" + token + """"
         Case 13: tmpXML = tmpXML + " publicassessmentvisit=""" + token + """"
         Case 14: tmpXML = tmpXML + " publicassessment30=""" + token + """"
         Case 15: tmpXML = tmpXML + " publicassessmenttaken=""" + token + """"
         Case 16: tmpXML = tmpXML + " surveyvisit=""" + token + """"
         Case 17: tmpXML = tmpXML + " survey30=""" + token + """"
         Case 18: tmpXML = tmpXML + " surveytaken=""" + token + """"
         Case 19: tmpXML = tmpXML + " surveyuntaken=""" + token + """"
         Case 20: tmpXML = tmpXML + " suggestionsubmitted=""" + token + """"
         Case 21: tmpXML = tmpXML + " suggestionreplied=""" + token + """"
         Case 22: tmpXML = tmpXML + " suggestionvisit=""" + token + """"
         Case 23: tmpXML = tmpXML + " suggestion30=""" + token + """"
         Case 24: tmpXML = tmpXML + " messageposted=""" + token + """"
         Case 25: tmpXML = tmpXML + " messagereplied=""" + token + """"
         Case 26: tmpXML = tmpXML + " messagevisit=""" + token + """"
         Case 27: tmpXML = tmpXML + " message30=""" + token + """"
         Case 28: tmpXML = tmpXML + " favoritecompany=""" + token + """"
         Case 29: tmpXML = tmpXML + " favoritepublic=""" + token + """"
         Case 30: tmpXML = tmpXML + " favoritechat=""" + token + """"
         Case 31: tmpXML = tmpXML + " favoriteforum=""" + token + """"
         Case 32: tmpXML = tmpXML + " favoriteccvisit=""" + token + """"
         Case 33: tmpXML = tmpXML + " favoritecc30=""" + token + """"
         Case 34: tmpXML = tmpXML + " favoritepcvisit=""" + token + """"
         Case 35: tmpXML = tmpXML + " favoritepc30=""" + token + """"
         Case 36: tmpXML = tmpXML + " favoritempvisit=""" + token + """"
         Case 37: tmpXML = tmpXML + " favoritemp30=""" + token + """"
         Case 38: tmpXML = tmpXML + " favoritemrvisit=""" + token + """"
         Case 39: tmpXML = tmpXML + " favoritemr30=""" + token + """"
         Case 40: tmpXML = tmpXML + " expectation=""" + token + """"
         Case 41: tmpXML = tmpXML + " goaltotal=""" + token + """"
         Case 42: tmpXML = tmpXML + " goaldeclare=""" + token + """"
         Case 43: tmpXML = tmpXML + " goalcommit=""" + token + """"
         Case 44: tmpXML = tmpXML + " goalcomplete=""" + token + """"
         Case 45: tmpXML = tmpXML + " goalearly=""" + token + """"
         Case 46: tmpXML = tmpXML + " goalontime=""" + token + """"
         Case 47: tmpXML = tmpXML + " goallate=""" + token + """"
         End Select
         cnt = cnt + 1
      Wend
      GetTB = tmpXML + "/>"
   End If

End Function

Function SetTB(ByVal bvXML)
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

   SetCache "TBCOUNT", tmpData

End Function


%>


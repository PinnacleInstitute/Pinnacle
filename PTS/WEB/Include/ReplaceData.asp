<%
'*****************************************************************************
'** Search for and replace tokens for the specified token number (bvNum)
'** If we find a match, use the contents between the matching tokens
'** If we do not find a match, ignore the contents between the matching tokens
'** MATCH OPTIONS
'** {data1:+} check for any data value
'** {data1:-} check for no data value
'** {data1:<xxx} check for data value less than xxx (supports &lt;)
'** {data1:>xxx} check for data value greater than xxx (supports &gt;)
'** {data1:else} check if nothing else matched
'** {data1:xxx} check for exact match of data = xxx
'** PARAMETERS
'** bvBody  the text containing the replaceable tokens
'** bvNum   Used to identify the token ("data" + bvNum)
'** bvData  the data to match with
'** RETURN - The replaced bvBody
'*****************************************************************************
Function ReplaceData(ByVal bvBody,ByVal bvNum, ByVal bvData)
	Dim pos, pos1, pos2, lastpos
	Dim token, tokenlen
	Dim datalen, totlen
	Dim bMatch, tmpBody, cnt

	token = "{data" & bvNum & ":" 'build token to search for
	tokenlen = Len(token)         'calc length of search token
	pos = InStr(bvBody, token)    'search for first token
	If pos = 0 Then               'no token found
	   ReplaceData = bvBody       'return the entire body
	   Exit Function
	End If

	lastpos = 1
	cnt = 0
	While pos > 0
	   'search for token
	   pos = InStr(lastpos, bvBody, token)
	   
	   If pos > 0 Then
			'Copy the contents between the last token or beginning and this token
			tmpBody = tmpBody + Mid(bvBody, lastpos, pos-lastpos)
	      'search for the closing token
	      pos1 = InStr(pos + tokenlen, bvBody, token)
	         
	      'Check for a match with any data
	      If (Mid(bvBody, pos + tokenlen, 1) = "+") Then        
	         datalen = 1                   'calc length of "+"
	         bMatch = Len(bvData) > 0
	      'Check for a match with no data
	      ElseIf (Mid(bvBody, pos + tokenlen, 1) = "-") Then
	         datalen = 1                   'calc length of "-"
	         bMatch = Len(bvData) = 0
         'Check for a match with data value less than (<) xxx
         ElseIf (Mid(bvBody, pos + tokenlen, 1) = "<") Then
            pos2 = InStr(pos + tokenlen, bvBody, "}")
            If pos2 > 0 Then
               datalen = pos2 - (pos + tokenlen)  'calc length of "<?"
               bMatch = DataCompare(bvData, Mid(bvBody, pos + tokenlen + 1, datalen - 1), "<")
            Else
               bMatch = False
            End If
          'Check for a match with data value less than (&lt;) xxx
         ElseIf (Mid(bvBody, pos + tokenlen, 4) = "&lt;") Then
            pos2 = InStr(pos + tokenlen, bvBody, "}")
            If pos2 > 0 Then
               datalen = pos2 - (pos + tokenlen)  'calc length of "&lt;?"
               bMatch = DataCompare(bvData, Mid(bvBody, pos + tokenlen + 4, datalen - 4), "<")
            Else
               bMatch = False
            End If
         'Check for a match with data value greater than (>) xxx
         ElseIf (Mid(bvBody, pos + tokenlen, 1) = ">") Then
            pos2 = InStr(pos + tokenlen, bvBody, "}")
            If pos2 > 0 Then
               datalen = pos2 - (pos + tokenlen)  'calc length of "<?"
               bMatch = DataCompare(bvData, Mid(bvBody, pos + tokenlen + 1, datalen - 1), ">")
            Else
               bMatch = False
            End If
         'Check for a match with data value greater than (&gt;) xxx
         ElseIf (Mid(bvBody, pos + tokenlen, 4) = "&gt;") Then
            pos2 = InStr(pos + tokenlen, bvBody, "}")
            If pos2 > 0 Then
               datalen = pos2 - (pos + tokenlen)  'calc length of "&lt;?"
               bMatch = DataCompare(bvData, Mid(bvBody, pos + tokenlen + 4, datalen - 4), ">")
            Else
               bMatch = False
            End If
	      'Check if nothing else was a match
	      ElseIf (Mid(bvBody, pos + tokenlen, 4) = "else") Then
	         datalen = 4                   'calc length of "else"
	         bMatch = (cnt = 0)
	      'Check for a match with exact data (must have data)
	      ElseIf bvData <> "" And (Mid(bvBody, pos + tokenlen, Len(bvData)) = bvData) Then
	         datalen = Len(bvData)         'calc length of our data
	         bMatch = True
	      Else
	         bMatch = False
	      End If
	         
	      If bMatch Then        
				cnt = cnt + 1
	         'this found token is for our data, so save this token content
	         'check if we found the closing token
	         If pos1 > 0 Then
	            'calculate the total length of the token followed by our data and the closing }
	            totlen = tokenlen + datalen + 1
	            'save everything between then two found tokens
	            tmpBody = tmpBody + Mid(bvBody, pos + totlen, pos1 - (pos + totlen))
	            'recalcxulate the last position to just after the closing token, our data, and }
	            lastpos = pos1 + totlen          
	         Else          
	            'no closing token, ignore everything afterwards
	            lastpos = Len(bvBody)
	         End If
	      Else         
	         'this found token is for some other data, so skip over this token content
	         'check if we found the closing token
	         If pos1 > 0 Then
	            'we found the closing token, now find the end of the closing token
	            pos1 = InStr(pos1, bvBody, "}")
	            If pos1 > 0 Then
	               'set the last position to just after the closing token
	               lastpos = pos1 + 1
	            Else              
	               'no closing token, ignore everything afterwards
	               lastpos = Len(bvBody)
	            End If
	         Else           
	            'no closing token, ignore everything afterwards
	            lastpos = Len(bvBody)
	         End If          
	      End If
	   Else
	      tmpBody = tmpBody + Mid(bvBody, lastpos)     
	   End If
	   
	Wend

	ReplaceData = tmpBody

End Function

'*****************************************************************************
'** Compare 2 values and retuns True/False (False if not both numeric)
'*****************************************************************************
Function DataCompare(ByVal bvData, ByVal bvCompare, ByVal bvOper)

	Dim data1, data2

	If IsNumeric(bvData) And IsNumeric(bvCompare) Then
	   data1 = CLng(bvData)
	   data2 = CLng(bvCompare)
	   If bvOper = "<" Then
	      DataCompare = (data1 < data2)
	   Else
	      DataCompare = (data1 > data2)
	   End If
	Else
	   DataCompare = False
	End If

End Function

%>


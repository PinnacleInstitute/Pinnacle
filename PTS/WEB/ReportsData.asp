<% Response.Buffer=true
Response.ContentType = "text/xml"
On Error Resume Next

Rpt = Request.Item("r")
P1 =  Request.Item("1")
P2 =  Request.Item("2")
P3 =  Request.Item("3")
P4 =  Request.Item("4")
P5 =  Request.Item("5")

If Rpt = 10 Then
	tmpData = "<REPORT>"
		tmpData = tmpData + "<DATA name=""bob martin"" title=""President"" salary=""200000.00"" bonus=""10000.00""/>"
		tmpData = tmpData + "<DATA name=""fred brown"" title=""CIO"" salary=""80000"" bonus=""4000""/>"
		tmpData = tmpData + "<DATA name=""jill johnson"" title=""VP Finance"" salary=""75000"" bonus=""2000""/>"
		tmpData = tmpData + "<DATA name=""steve baker"" title=""Tennis Coach"" salary=""50000"" bonus=""1000""/>"
	tmpData = tmpData + "</REPORT>"
End If

'-- -----------------------------------------
'-- Standard Pinnacle Reports
'-- -----------------------------------------
If Rpt = 1 OR Rpt = 2 OR Rpt = 3 OR Rpt = 4 OR Rpt = 5 OR Rpt = 6 Then

	Set oBusinesss = server.CreateObject("ptsBusinessUser.CBusinesss")
	If oBusinesss Is Nothing Then
		tmpData = "<ERROR>" + err.Description + "</ERROR>"
	Else
		With oBusinesss
			.Reports Rpt, P1, P2, P3, P4, P5
			If Err.number > 0 Then Response.Write err.Description 
			tmpData = "<REPORT>"
			For Each oBusiness in oBusinesss
				With oBusiness
					tmpLabel = ""
					Select Case Rpt
					Case 1
						Select Case .R1
							Case 0: tmpLabel = "No Status"
							Case 1: tmpLabel = "Premium"
							Case 2: tmpLabel = "Trial"
							Case 3: tmpLabel = "Standard"
							Case 4: tmpLabel = "Suspended"
							Case 5: tmpLabel = "Inactive"
							Case 6: tmpLabel = "Cancelled"
							Case 7: tmpLabel = "Terminated"
							Case Else: tmpLabel = .R1
						End Select	
					Case 2
						Select Case .R1
							Case 1: tmpLabel = "1 Day"
							Case 3: tmpLabel = "3 Day"
							Case 7: tmpLabel = "1 Week"
							Case 14: tmpLabel = "2 Weeks"
							Case 30: tmpLabel = "1 Month"
							Case 31: tmpLabel = "Over Month"
							Case 32: tmpLabel = "No Visit"
							Case Else: tmpLabel = .R1
						End Select	
					Case 3
						Select Case .R1
							Case 0: tmpLabel = "New Contact"
							Case 1: tmpLabel = "1st Contact"
							Case 2: tmpLabel = "2nd Contact"
							Case 3: tmpLabel = "3rd Contact"
							Case 4: tmpLabel = "Don't Contact"
							Case 5: tmpLabel = "Callback"
							Case 6: tmpLabel = "Dead"
							Case Else: tmpLabel = .R1
						End Select	
					Case 4
						Select Case .R1
							Case 0: tmpLabel = "No Status"
							Case 1: tmpLabel = "New"
							Case 2: tmpLabel = "Active"
							Case 3: tmpLabel = "Fallback"
							Case 4: tmpLabel = "Closed"
							Case 5: tmpLabel = "Dead"
							Case Else: tmpLabel = .R1
						End Select	
					Case 5
						If .R1 = "Contact" Then
							Select Case .R2
								Case 0: tmpLabel = "New"
								Case 1: tmpLabel = "1st Contact"
								Case 2: tmpLabel = "2nd Contact"
								Case 3: tmpLabel = "3rd Contact"
								Case 4: tmpLabel = "Don't Contact"
								Case 5: tmpLabel = "Callback"
								Case 6: tmpLabel = "Dead"
								Case Else: tmpLabel = .R2
							End Select	
						End If
						If .R1 = "Prospect" Then
							Select Case .R2
								Case 0: tmpLabel = "No Status"
								Case 1: tmpLabel = "New"
								Case 2: tmpLabel = "Active"
								Case 3: tmpLabel = "Fallback"
								Case 4: tmpLabel = "Closed"
								Case 5: tmpLabel = "Dead"
								Case Else: tmpLabel = .R2
							End Select	
						End If
					Case 6
						Select Case .R1
							Case 0: tmpLabel = "0"
							Case 1: tmpLabel = "1"
							Case 2: tmpLabel = "2"
							Case 3: tmpLabel = "3"
							Case Else: tmpLabel = .R1
						End Select	
					End Select
					
					If Rpt <= 4 OR Rpt = 6 Then
						tmpData = tmpData + "<DATA label=""" + tmpLabel + """>" & .R2 & "</DATA>"
					End If
					If Rpt = 5 Then
						tmpData = tmpData + "<DATA type=""" + .R1 + """ status=""" + tmpLabel + """ count=""" + .R3 + """/>"
					End If
					
				End With
			Next
			tmpData = tmpData + "</REPORT>"
		End With
	End If
	Set oBusinesss = Nothing

End If

'-- -----------------------------------------
'-- StrongIncome New Members
'-- -----------------------------------------
If Rpt = 200 Then

	Set oBusinesss = server.CreateObject("ptsBusinessUser.CBusinesss")
	If oBusinesss Is Nothing Then
		tmpData = "<ERROR>" + err.Description + "</ERROR>"
	Else
		With oBusinesss
			.Reports Rpt, P1, P2, P3, P4, P5
			If Err.number > 0 Then Response.Write err.Description 
			tmpData = "<REPORT>"
			For Each oBusiness in oBusinesss
				With oBusiness
					If Rpt = 200 Then
						tmpData = tmpData + "<DATA firstname=""" + CleanXML(.R1) + """ lastname=""" + .R2 + """ phone=""" + .R3 + """ email=""" + .R4 + """ city=""" + .R5 + """ state=""" + .R6 + """ enrolldate=""" + .R7 + """/>"
					End If
				End With
			Next
			tmpData = tmpData + "</REPORT>"
		End With
	End If
	Set oBusinesss = Nothing

End If

response.write tmpData
response.end

Function CleanXML(ByVal bvValue)
   '-----&AMP MUST BE FIRST!!!
   bvValue = Replace(bvValue, Chr(38), "&amp;")
   bvValue = Replace(bvValue, Chr(34), "&quot;")
   bvValue = Replace(bvValue, Chr(39), "&apos;")
   bvValue = Replace(bvValue, Chr(60), "&lt;")
   CleanXML = Replace(bvValue, Chr(62), "&gt;")
End Function

%>
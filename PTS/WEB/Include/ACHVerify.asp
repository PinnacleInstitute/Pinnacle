<%
Function VerifyACH( byVal bvCompanyID, byVal bvMemberID, byVal bvRoute, byVal bvAcct, byVal bvAcctType, byVal bvAmt, byRef brReference )
	On Error Resume Next

	'Test Environment:
	strURL = "https://testbox.microbilt.com/WebServices/AT/ATAccountVerify.svc"
	strMemberId = "bob_wood"
	strMemberPwd = "Shabang1"

	'Production Environment:
'	strURL = "https://creditserver.microbilt.com/WebServices/AT/ATAccountVerify.svc"
'	strMemberId = "CCC0130942"
'	strMemberPwd = "1114060621"

	strRefNum = CSTR(bvCompanyID) + "-" + CSTR(bvMemberID)
	strUserName = "Pinnacle Institute"
	If bvAcctType = 2 Then tmpAcctType = "S" Else tmpAcctType = "C"

	set oHTTP = CreateObject("Microsoft.XMLHTTP")
	If oHTTP Is Nothing Then
		response.Write "Error Creating Object: Microsoft.XMLHTTP"
		Result = 0  
	Else
		'MicroBilt Bank Account Verification Sample XML - AccountVerify Sample Request XML
		strRequest = _
		"<soap:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" " _
		+         "xmlns:mes=""http://schema.microbilt.com/messages/"" xmlns:glob=""http://schema.microbilt.com/globals"">" _
		+   "<soapenv:Header/>" _
		+   "<soapenv:Body>" _
		+   "<mes:GetReport>" _
		+   "<mes:inquiry>" _
		+       "<glob:MsgRqHdr>" _
		+         "<glob:MemberId>" + CSTR(strMemberId) + "</glob:MemberId>" _
		+         "<glob:MemberPwd>" + CSTR(strMemberPwd) + "</glob:MemberPwd>" _
		+         "<glob:RefNum>" + CSTR(strRefNum) + "</glob:RefNum>" _
		+         "<glob:UserName>" + CSTR(strUserName) + "</glob:UserName>" _
		+       "</glob:MsgRqHdr>" _
		+       "<glob:SalesAmt>" _
		+         "<glob:Amt>" + CSTR(bvAmt) + "</glob:Amt>" _
		+       "</glob:SalesAmt>" _
		+       "<glob:ACHInfo>" _
		+         "<glob:CheckRoutingNum>" + CSTR(bvRoute) + "</glob:CheckRoutingNum>" _
		+         "<glob:CheckAcctNum>" + CSTR(bvAcct) + "</glob:CheckAcctNum>" _
		+         "<glob:CheckAcctType>" + CSTR(tmpAcctType) + "</glob:CheckAcctType>" _
		+       "</glob:ACHInfo>" _
		+   "</mes:inquiry>" _
		+   "</mes:GetReport>" _
		+   "</soapenv:Body>" _
		+ "</soapenv:Envelope>"

		oHTTP.open "post", strURL, False
		oHTTP.setRequestHeader "Content-Type", "text/xml;charset=UTF-8"
		oHTTP.setRequestHeader "Content-Length", Len(strRequest)
		oHTTP.setRequestHeader "SOAPAction", "http://schema.microbilt.com/messages/GetReport"
		
		'send the request and capture the result
		Call oHTTP.send(strRequest)
		strResult = oHTTP.responseText
'		strResult = "<Envelope><Body><GetReportResponse><GetReportResult><MsgRsHdr><Status><StatusCode>0</StatusCode><StatusDesc>OK</StatusDesc></Status></MsgRsHdr></GetReportResult></GetReportResponse></Body></Envelope>"

		'display the XML
'		response.write strRequest
'		response.write strResult

		Set oResult = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
		If oResult Is Nothing Then
			response.Write "Error Creating Object: MSXML2.FreeThreadedDOMDocument"
		Else
			oResult.loadXML strResult
'			Result = oResult.selectSingleNode("s:Envelope/s:Body/GetReportResponse/GetReportResult/MsgRsHdr/Status/StatusCode").text
			Result = oResult.selectSingleNode("s:Envelope/s:Body/GetReportResponse/GetReportResult/MsgRsHdr/Status/AdditionalStatus/ServerStatusCode").text
			brReference = oResult.selectSingleNode("s:Envelope/s:Body/GetReportResponse/GetReportResult/MsgRsHdr/Status/AdditionalStatus/StatusDesc").text

			If Result = "A01" Then
				Result = oResult.selectSingleNode("s:Envelope/s:Body/GetReportResponse/GetReportResult/ACHResponseInfo/MsgCode").text
				brReference = oResult.selectSingleNode("s:Envelope/s:Body/GetReportResponse/GetReportResult/ACHResponseInfo/Text").text
			End If
		End If	
		Set oResult = Nothing
		
	End If
	Set oHTTP = Nothing

	LogFile "VerifyACH", VBTAB + CSTR(bvCompanyID) + VBTAB + CSTR(bvMemberID) + VBTAB + bvRoute + VBTAB + bvAcct + VBTAB + CSTR(Result) + VBTAB + brReference

	VerifyACH = Result

End Function
%>


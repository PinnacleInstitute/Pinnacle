<%
g_AN_API  = ""
g_AN_Key  = ""
g_AN_URL = "https://api.authorize.net/xml/v1/request.api"
'g_AN_Validation = "liveMode"
'g_AN_URL = "https://apitest.authorize.net/xml/v1/request.api"
g_AN_Validation = "testMode"
g_AN_Test = false

'****************************************************************************************
Function SetProcessor( byval bvProcessor )
	Select Case bvProcessor
		Case 1 'PowerPay
		g_AN_API = "63BM4ruk"
		g_AN_Key = "6h2VU3Ayr82QWk8C"

		Case 2 'Bank Of America
		g_AN_API = ""
		g_AN_Key = ""

		Case 3 'Comerica
		g_AN_API = ""
		g_AN_Key = ""

	End Select
	SetProcessor = bvProcessor
End Function

'****************************************************************************************
Function CreateCustomer( byval bvProcessor, byval bvCustomerID, byval bvName, byval bvEmail, byref brBilling, byref brAuthorizeNetID, byref brAuthorizeNetPayID )
	On Error Resume Next
	SetProcessor(bvProcessor)
	
	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<createCustomerProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "<profile>" _
	+ "  <merchantCustomerId>" & bvCustomerID & "</merchantCustomerId>" _
	+ "  <description>" & bvName & "</description>" _
	+ "  <email>" & bvEmail & "</email>" _
	+ "  <paymentProfiles>"

	With brBilling
		If .PayType = 1 Then
			If Len(.CardMo) = 1 Then .CardMo = "0" + .CardMo
			sRequest = sRequest + "<payment>" _
			+ "  <creditCard>" _
			+ "    <cardNumber>" & .CardNumber & "</cardNumber>" _
			+ "    <expirationDate>" & "20" & .CardYr & "-" & .CardMo & "</expirationDate>" _
			+ "  </creditCard>" _
			+ "</payment>"
		End If 
	End With

	sRequest = sRequest _
	+ "  </paymentProfiles>" _
	+ "</profile>" _
	+ "<validationMode>" & g_AN_Validation & "</validationMode>" _
	+ "</createCustomerProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result = "OK" Then
		brAuthorizeNetID = oResponse.selectSingleNode("/*/customerProfileId").Text
		brAuthorizeNetPayID = oResponse.selectSingleNode("/*/customerPaymentProfileIdList/numericString").Text
	Else
		Result = GetErrors(oResponse)
	End If
	Set oResponse = Nothing
	
	CreateCustomer = Result
	
End Function

'****************************************************************************************
Function UpdateCustomer( byval bvProcessor, byval bvAuthorizeNetID, byval bvCustomerID, byval bvName, byval bvEmail )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<updateCustomerProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "<profile>" _
	+ "  <merchantCustomerId>" & bvCustomerID & "</merchantCustomerId>" _
	+ "  <description>" & bvName & "</description>" _
	+ "  <email>" & bvEmail & "</email>" _
	+ "  <customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "</profile>" _
	+ "</updateCustomerProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result <> "OK" Then Result = GetErrors(oResponse)
	Set oResponse = Nothing
	
	UpdateCustomer = Result
	
End Function

'****************************************************************************************
Function DeleteCustomer( byval bvProcessor, byval bvAuthorizeNetID )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<deleteCustomerProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "<customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "</deleteCustomerProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result <> "OK" Then Result = GetErrors(oResponse)
	Set oResponse = Nothing
	
	DeleteCustomer = Result
	
End Function

'****************************************************************************************
Function CreatePaymentInfo( byval bvProcessor, byval bvAuthorizeNetID, byref brBilling, byref brAuthorizeNetPayID )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<createCustomerPaymentProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "<customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "<paymentProfile>"

	With brBilling
		If .PayType = 1 Then
			If Len(.CardMo) = 1 Then .CardMo = "0" + .CardMo
			sRequest = sRequest + "<payment>" _
			+ "  <creditCard>" _
			+ "    <cardNumber>" & .CardNumber & "</cardNumber>" _
			+ "    <expirationDate>" & "20" & .CardYr & "-" & .CardMo & "</expirationDate>" _
			+ "  </creditCard>" _
			+ "</payment>"
		End If 
	End With

	sRequest = sRequest _
	+ "</paymentProfile>" _
	+ "<validationMode>" & g_AN_Validation & "</validationMode>" _
	+ "</createCustomerPaymentProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result = "OK" Then
		brAuthorizeNetPayID = oResponse.selectSingleNode("/*/customerPaymentProfileId").Text
	Else
		Result = GetErrors(oResponse)
	End If
	Set oResponse = Nothing
	
	CreatePaymentInfo = Result
	
End Function

'****************************************************************************************
Function ValidatePaymentInfo( byval bvProcessor, byval bvAuthorizeNetID, byval bvAuthorizeNetPayID  )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<validateCustomerPaymentProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "  <customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "  <customerPaymentProfileId>" & bvAuthorizeNetPayID & "</customerPaymentProfileId>" _
	+ "  <validationMode>" & g_AN_Validation & "</validationMode>" _
	+ "</validateCustomerPaymentProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result <> "OK" Then Result = GetErrors(oResponse)
	Set oResponse = Nothing
	
	ValidatePayment = Result
	
End Function

'****************************************************************************************
Function GetPaymentInfo( byval bvProcessor, byval bvAuthorizeNetID, byval bvAuthorizeNetPayID, byref brBilling )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<getCustomerPaymentProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "<customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "<customerPaymentProfileId>" & bvAuthorizeNetPayID & "</customerPaymentProfileId>" _
	+ "</getCustomerPaymentProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result = "OK" Then
		With brBilling
			.CardNumber = oResponse.selectSingleNode("//cardNumber").Text
			expDate = oResponse.selectSingleNode("//expirationDate").Text
'			.CardYr = Mid(expDate,3,2)
'			.CardMo =  Mid(expDate,6,2)
'			If Left(.CardMo) = "0" Then .CardMo = Mid( .CardMo, 2, 1)
		End With
	Else
		Result = GetErrors(oResponse)
	End If
	Set oResponse = Nothing

	GetPaymentInfo = Result

End Function

'****************************************************************************************
Function UpdatePaymentInfo( byval bvProcessor, byval bvAuthorizeNetID, byval bvAuthorizeNetPayID, byref brBilling )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<updateCustomerPaymentProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "  <customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "  <paymentProfile>" 

	With brBilling
		If .PayType = 1 Then
			If Len(.CardMo) = 1 Then .CardMo = "0" + .CardMo
			sRequest = sRequest + "<payment>" _
			+ "  <creditCard>" _
			+ "    <cardNumber>" & .CardNumber & "</cardNumber>" _
			+ "    <expirationDate>" & "20" & .CardYr & "-" & .CardMo & "</expirationDate>" _
			+ "  </creditCard>" _
			+ "</payment>"
		End If 
	End With

	sRequest = sRequest _
	+ "    <customerPaymentProfileId>" & bvAuthorizeNetPayID & "</customerPaymentProfileId>" _
	+ "  </paymentProfile>" _
	+ "  <validationMode>" & g_AN_Validation & "</validationMode>" _
	+ "</updateCustomerPaymentProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result <> "OK" Then Result = GetErrors(oResponse)
	Set oResponse = Nothing

	UpdatePaymentInfo = Result

End Function

'****************************************************************************************
Function DeletePaymentInfo( byval bvProcessor, byval bvAuthorizeNetID, byval bvAuthorizeNetPayID )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<deleteCustomerPaymentProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "<customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "<customerPaymentProfileId>" & bvAuthorizeNetPayID & "</customerPaymentProfileId>" _
	+ "</deleteCustomerPaymentProfileRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result <> "OK" Then Result = GetErrors(oResponse)
	Set oResponse = Nothing
	
	DeleteCustomer = Result
	
End Function

'****************************************************************************************
Function CreatePayment( byval bvProcessor, byval bvAuthorizeNetID, byval bvAuthorizeNetPayID, byval bvAmount  )
	On Error Resume Next
	SetProcessor(bvProcessor)

	sRequest = "<?xml version='1.0' encoding='utf-8'?>" _
	+ "<createCustomerProfileTransactionRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" _
	+ MerchantAuthentication() _
	+ "<transaction>" _
	+ "  <profileTransAuthCapture>" _
	+ "    <amount>" & bvAmount & "</amount>" _
	+ "    <customerProfileId>" & bvAuthorizeNetID & "</customerProfileId>" _
	+ "    <customerPaymentProfileId>" & bvAuthorizeNetPayID & "</customerPaymentProfileId>" _
	+ "  </profileTransAuthCapture>" _
	+ "</transaction>" _
	+ "</createCustomerProfileTransactionRequest>"

	Set oResponse = AN_SendApiRequest(sRequest)
	Result = IsApiResponseSuccess(oResponse)

	If Result <> "OK" Then Result = GetErrors(oResponse)
	Set oResponse = Nothing
	
	CreatePayment = Result
	
End Function

'****************************************************************************************
Function AN_SendApiRequest(byVal bvRequest) 'returns an MSXML DOMDocument.
	Dim oHTTP 
	Dim oResponse

	If g_AN_Test Then Response.Write "<BR><BR>Request: " & Server.HTMLEncode(bvRequest)

	Set oHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	oHTTP.open "post", g_AN_URL, False
	oHTTP.setRequestHeader "Content-Type", "text/xml"

	oHTTP.send bvRequest
	If g_AN_Test Then Response.Write "<BR><BR>Response: " & Server.HTMLEncode(oHTTP.responseText)

	Set oResponse = Server.CreateObject("MSXML2.FreeThreadedDOMDocument")
	oResponse.loadXML oHTTP.responseText
	Set AN_SendApiRequest = oResponse
	Set oHTTP = Nothing
End Function

'****************************************************************************************
Function MerchantAuthentication() ' return string containing xml snippet.
  MerchantAuthentication = "<merchantAuthentication>" _
  + "<name>" & g_AN_API & "</name>" _
  + "<transactionKey>" & g_AN_Key & "</transactionKey>" _
  + "</merchantAuthentication>" 
End Function

'****************************************************************************************
Function IsApiResponseSuccess(oResponse)
	On Error Resume Next
	If "Ok" = oResponse.selectSingleNode("/*/messages/resultCode").Text Then
		IsApiResponseSuccess = "OK"
	Else
		IsApiResponseSuccess = "BAD"
	End If
End Function

'****************************************************************************************
Function GetErrors(oResponse)
  Dim oMessages, oMsg, strResult
  strResult = ""	
  set oMessages = oResponse.selectNodes("/*/messages/message")
  For Each oMsg in oMessages
    strResult = strResult + "[" & Server.HTMLEncode(oMsg.selectSingleNode("code").Text) & "] " _
      & Server.HTMLEncode(oMsg.selectSingleNode("text").Text)
  Next
  GetErrors = strResult 
End Function

%>


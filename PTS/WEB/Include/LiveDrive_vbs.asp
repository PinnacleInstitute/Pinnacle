PUBLIC CONST cSOAPVersion = 1
g_LD_Key = "61cba95a-a35f-423a-bb58-f14dbb1dfb0b"
g_LD_URL = "http://www.livedrive.com/ResellersService/ResellerAPI.asmx"
g_LD_CardCode = "944" '3 Digit Code on paying Credit Card
g_LD_Test = false
'g_LD_Test = true

'****************************************************************************************
Function GetUser( byref brMachine)
	On Error Resume Next
	
	With brMachine
		sRequest = "<GetUser xmlns='http://www.livedrive.com/'>" _
		+ "<apiKey>" & g_LD_Key & "</apiKey>" _
		+ "<userID>" & .LiveDriveID & "</userID>" _
		+ "</GetUser>"
	End With

	Set oResponse = LD_SendApiRequest(sRequest, "http://www.livedrive.com/GetUser")
	Set oNode = oResponse.selectSingleNode("//GetUserResult")

	Result = oNode.selectSingleNode("Header/Code").text

	If Result = "UserFound" Then
		Result = "OK"
		With brMachine
			.NameFirst = Left(oNode.selectSingleNode("FirstName").text,30)
			.NameLast = Left(oNode.selectSingleNode("LastName").text,30)
			.Email = Left(oNode.selectSingleNode("Email").text,80)
			.WebName = Left(oNode.selectSingleNode("SubDomain").text,20)
			.BackupUsed = Left(oNode.selectSingleNode("BackupSpaceUsed").text,10)
			.BackupCapacity = Left(oNode.selectSingleNode("BackupCapacity").text,10)
			.BriefcaseUsed = Left(oNode.selectSingleNode("BriefcaseSpaceUsed").text,10)
			.BriefcaseCapacity = Left(oNode.selectSingleNode("BriefcaseCapacity").text,10)
		End With
	Else
		Result = Result + "|" + oNode.selectSingleNode("Header/Description").Text
	End If

	Set oNode = Nothing
	Set oResponse = Nothing

	GetUser = Result
	
End Function

'****************************************************************************************
Function AddUser( byRef brMachine)
	On Error Resume Next

	CleanMachine(brMachine)

	With brMachine
		sRequest = "<AddUserWithLimit xmlns='http://www.livedrive.com/'>" _
		+ "<apiKey>" & g_LD_Key & "</apiKey>" _
		+ "<email>" & .Email & "</email>" _
		+ "<password>" & .Password & "</password>" _
		+ "<confirmPassword>" & .Password & "</confirmPassword>" _
		+ "<subDomain>" & .WebName & "</subDomain>" _
		+ "<firstName>" & .NameFirst & "</firstName>" _
		+ "<lastName>" & .NameLast & "</lastName>" 
		'Backup or Briefcase, both get backup
		If .Service = 1 OR .Service = 2 Then
			sRequest = sRequest + "<BackupCapacity>Unlimited</BackupCapacity>" _
			+ "<productType>Backup</productType>" 
		End If
		'Briefcase
		If .Service = 2 Then
			sRequest = sRequest + "<BriefcaseCapacity>HalfTeraByte</BriefcaseCapacity>" _
			+ "<productType>Briefcase</productType>" 
		End If
		sRequest = sRequest + "<cardVerificationValue>" + g_LD_CardCode + "</cardVerificationValue>" _
		+ "</AddUserWithLimit>"

'		+ "<isSharing>" & "0" & "</isSharing>" _
'		+ "<hasWebApps>" & "0" & "</hasWebApps>" _
	End With
	
'response.Write "<BR>Request: " & sRequest
	Set oResponse = LD_SendApiRequest(sRequest, "http://www.livedrive.com/AddUserWithLimit")
'response.Write "<BR>Response: " & oResponse.xml
	Set oNode = oResponse.selectSingleNode("//AddUserWithLimitResult")

	Result = oNode.selectSingleNode("Header/Code").text

	If Result = "UserAdded" Then
		Result = "OK"
		brMachine.LiveDriveID = oNode.selectSingleNode("ID").text
	Else
		Result = Result + "|" + oNode.selectSingleNode("Header/Description").text
	End If
	
	Set oNode = Nothing
	Set oResponse = Nothing
	
	AddUser = Result
	
End Function

'****************************************************************************************
Function UpgradeUser( byref brMachine)
	On Error Resume Next

	With brMachine
		sRequest = "<UpgradeUser xmlns='http://www.livedrive.com/'>" _
		+ "<apiKey>" & g_LD_Key & "</apiKey>" _
		+ "<userID>" & .LiveDriveID & "</userID>" _
		+ "<Capacity>HalfTeraByte</Capacity>" _
		+ "<cardVerificationValue>" + g_LD_CardCode + "</cardVerificationValue>" _
		+ "</UpgradeUser>"
	End With
	
	Set oResponse = LD_SendApiRequest(sRequest, "http://www.livedrive.com/UpgradeUser")
	Set oNode = oResponse.selectSingleNode("//UpgradeUserResult")

	Result = oNode.selectSingleNode("Header/Code").text

	If Result = "UserUpgraded" Then
		Result = "OK"
	Else
		Result = Result + "|" + oNode.selectSingleNode("Header/Description").Text
	End If
	
	Set oNode = Nothing
	Set oResponse = Nothing
	
	UpgradeUser = Result
	
End Function

'****************************************************************************************
Function UpdateUser( byref brMachine)
	On Error Resume Next
	
	CleanMachine(brMachine)

	With brMachine
		sRequest = "<UpdateUser xmlns='http://www.livedrive.com/'>" _
		+ "<apiKey>" & g_LD_Key & "</apiKey>" _
		+ "<userID>" & .LiveDriveID & "</userID>" _
		+ "<firstName>" & .NameFirst & "</firstName>" _
		+ "<lastName>" & .NameLast & "</lastName>" _
		+ "<email>" & .Email & "</email>" _
		+ "<subDomain>" & .WebName & "</subDomain>" _
		+ "</UpdateUser>"

'		+ "<password>" & .Password & "</password>" _
'		+ "<confirmPassword>" & .Password & "</confirmPassword>" _
'		+ "<isSharing>" & "0" & "</isSharing>" _
'		+ "<hasWebApps>" & "0" & "</hasWebApps>" _
	End With
	
'MsgBox("Request: " & sRequest)
	Set oResponse = LD_SendApiRequest(sRequest, "http://www.livedrive.com/UpdateUser")
'MsgBox("Response: " & oResponse.xml)
	Set oNode = oResponse.selectSingleNode("//UpdateUserResult")

	Result = oNode.selectSingleNode("Header/Code").text

	If Result = "UserUpdated" Then
		Result = "OK"
	Else
		Result = Result + "|" + oNode.selectSingleNode("Header/Description").Text
	End If
	
	Set oNode = Nothing
	Set oResponse = Nothing
	
	UpdateUser = Result
	
End Function

'****************************************************************************************
Function CloseUser( byref brMachine)
	On Error Resume Next
	
	With brMachine
		sRequest = "<CloseUser xmlns='http://www.livedrive.com/'>" _
		+ "<apiKey>" & g_LD_Key & "</apiKey>" _
		+ "<userID>" & .LiveDriveID & "</userID>" _
		+ "</CloseUser>"
	End With
	
	Set oResponse = LD_SendApiRequest(sRequest, "http://www.livedrive.com/CloseUser")
	Set oNode = oResponse.selectSingleNode("//CloseUserResult")

	Result = oNode.selectSingleNode("Header/Code").text

	If Result = "UserClosed" Then
		Result = "OK"
	Else
		Result = Result + "|" + oNode.selectSingleNode("Header/Description").Text
	End If
	
	Set oNode = Nothing
	Set oResponse = Nothing
	
	CloseUser = Result
	
End Function

'****************************************************************************************
' SuspendUser: If Machine Status is Active(1), suspend the user, otherwise reinstate them 
'****************************************************************************************
Function SuspendUser( byRef brMachine, byVal bvSuspend)
	On Error Resume Next

	With brMachine
		sRequest = "<SuspendUser xmlns='http://www.livedrive.com/'>" _
		+ "<apiKey>" & g_LD_Key & "</apiKey>" _
		+ "<userID>" & .LiveDriveID & "</userID>" _
		+ "<suspended>" & bvSuspend & "</suspended>" _
		+ "</SuspendUser>"
	End With

	Set oResponse = LD_SendApiRequest(sRequest, "http://www.livedrive.com/SuspendUser")
	Set oNode = oResponse.selectSingleNode("//SuspendUserResult")

	Result = oNode.selectSingleNode("Header/Code").text

	If bvSuspend = 1 Then
		If Result = "UserSuspended" Then
			Result = "OK"
		Else
			Result = Result + "|" + oNode.selectSingleNode("Header/Description").Text
		End If
	Else	
		If Result = "UserReinstated" Then
			Result = "OK"
		Else
			Result = Result + "|" + oNode.selectSingleNode("Header/Description").Text
		End If
	End If

	Set oNode = Nothing
	Set oResponse = Nothing

	SuspendUser = Result

End Function

'****************************************************************************************
Function LD_SendApiRequest(byVal bvRequest, byVal bvAction) 'returns an MSXML DOMDocument.
	On Error Resume Next
	Dim oHTTP 
	Dim oResponse

	bvRequest = SOAPHeader() + bvRequest + SOAPFooter()

	Set oHTTP = CreateObject("Microsoft.XMLHTTP")
	oHTTP.open "post", g_LD_URL, False
	oHTTP.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
	oHTTP.setRequestHeader "SOAPAction", bvAction
	oHTTP.setRequestHeader "Content-Length", Len(bvRequest)

	oHTTP.send bvRequest
	
	Set oResponse = CreateObject("MSXML2.FreeThreadedDOMDocument")
	oResponse.loadXML oHTTP.responseText
	Set LD_SendApiRequest = oResponse
	Set oHTTP = Nothing
End Function

'****************************************************************************************
Function SOAPHeader()
	If cSOAPVersion = 1 Then
		SOAPHeader = "<?xml version='1.0' encoding='utf-8'?>" _
		+ "<soap:Envelope" _
		+ " xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'" _
		+ " xmlns:xsd='http://www.w3.org/2001/XMLSchema'" _
		+ " xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>" _
		+ "<soap:Body>"
	End If
	If cSOAPVersion = 2 Then
		SOAPHeader = "<?xml version='1.0' encoding='utf-8'?>" _
		+ "<soap12:Envelope" _
		+ " xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'" _
		+ " xmlns:xsd='http://www.w3.org/2001/XMLSchema'" _
		+ " xmlns:soap12='http://www.w3.org/2003/05/soap-envelope'>" _
		+ "<soap12:Body>"
	End If
End Function

'****************************************************************************************
Function SOAPFooter()
	If cSOAPVersion = 1 Then
	    SOAPFooter = "</soap:Body></soap:Envelope>"
	End If
	If cSOAPVersion = 2 Then
	    SOAPFooter = "</soap12:Body></soap12:Envelope>"
	End If
End Function

'**************************************************************************************
Function CleanMachine(byref brMachine)
	With brMachine
		.Email = CleanSoap(.Email) 	
		.NameFirst = CleanSoap(.NameFirst) 	
		.NameLast = CleanSoap(.NameLast) 	
		.WebName = CleanSoap(.WebName) 	
		.Password = CleanSoap(.Password) 	
	End With
End Function

Function CleanSoap(byval bvValue)
   '-----&AMP MUST BE FIRST!!!
   bvValue = Replace(bvValue, Chr(38), "&amp;")
   bvValue = Replace(bvValue, Chr(34), "&quot;")
   bvValue = Replace(bvValue, Chr(39), "&apos;")
   bvValue = Replace(bvValue, Chr(60), "&lt;")
   CleanSoap = Replace(bvValue, Chr(62), "&gt;")
End Function


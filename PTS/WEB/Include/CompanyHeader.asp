<%
Function SetCompanyHeader(byval bvCompanyID, byval bvLanguage)
   On Error Resume Next
	'Get the header file name for this company
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Company\" + CStr(bvCompanyID) + "\Header[" + bvLanguage + "]"
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	Exists = oFileSys.FileExists(FilePath + ".png")
	If Exists Then
		reqSysHeaderImage = "Header[" + bvLanguage + "].png"
		SetCache "HEADERIMAGE", reqSysHeaderImage
	Else
		Exists = oFileSys.FileExists(FilePath + ".gif")
		If Exists Then
			reqSysHeaderImage = "Header[" + bvLanguage + "].gif"
			SetCache "HEADERIMAGE", reqSysHeaderImage
		Else
			Exists = oFileSys.FileExists(FilePath + ".jpg")
			If Exists Then
				reqSysHeaderImage = "Header[" + bvLanguage + "].jpg"
				SetCache "HEADERIMAGE", reqSysHeaderImage
			End If
		End If
	End If
	Set oFileSys = Nothing
End Function

Function SetCompanyGrpHeader(byval bvCompanyID, byval bvGroupID, byval bvLanguage)
   On Error Resume Next
	'Save member group
	SetCache "GROUPID", bvGroupID
	'Get the header file name for this company
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Company\" + CStr(bvCompanyID) + "\Header" + CSTR(bvGroupID) + "[" + bvLanguage + "]"
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	Exists = oFileSys.FileExists(FilePath + ".png")
	If Exists Then
		reqSysHeaderImage = "Header" + CSTR(bvGroupID) + "[" + bvLanguage + "].png"
		SetCache "HEADERIMAGE", reqSysHeaderImage
	Else
		Exists = oFileSys.FileExists(FilePath + ".gif")
		If Exists Then
			reqSysHeaderImage = "Header" + CSTR(bvGroupID) + "[" + bvLanguage + "].gif"
			SetCache "HEADERIMAGE", reqSysHeaderImage
		Else
			Exists = oFileSys.FileExists(FilePath + ".jpg")
			If Exists Then
				reqSysHeaderImage = "Header" + CSTR(bvGroupID) + "[" + bvLanguage + "].jpg"
				SetCache "HEADERIMAGE", reqSysHeaderImage
			Else
				SetCompanyHeader bvCompanyID, bvLanguage
			End If
		End If
	End If
	Set oFileSys = Nothing
End Function

Function GetCompanyHeader(byval bvCompanyID, byval bvLanguage)
   On Error Resume Next
	'Get the header file name for this company
	HeaderImage = ""
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Company\" + CStr(bvCompanyID) + "\Header[" + bvLanguage + "]"
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	Exists = oFileSys.FileExists(FilePath + ".png")
	If Exists Then
		HeaderImage = "Header[" + bvLanguage + "].png"
	Else
		Exists = oFileSys.FileExists(FilePath + ".gif")
		If Exists Then
			HeaderImage = "Header[" + bvLanguage + "].gif"
		Else
			Exists = oFileSys.FileExists(FilePath + ".jpg")
			If Exists Then
				HeaderImage = "Header[" + bvLanguage + "].jpg"
			End If
		End If
	End If
	Set oFileSys = Nothing
	GetCompanyHeader = HeaderImage
End Function


%>


<%
Function GetMTC(byval bvMTC)
   On Error Resume Next
	If bvMTC > 0 Then 
		reqMTC = bvMTC
	Else	
		reqMTC =  Request.Item("MTC")
		If (IsNumeric(reqMTC)) Then reqMTC = CLng(reqMTC) Else reqMTC = CLng(0)
	End If
	reqSysMTCID = GetCache("MTCID")
	If (IsNumeric(reqSysMTCID)) Then reqSysMTCID = CLng(reqSysMTCID) Else reqSysMTCID = CLng(0)
	
   If (reqMTC > 0) Then
      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            .Load reqMTC, 1 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.CompanyID > 0) Then
               reqSysMTCID = .CompanyID
               SetCache "MTCID", reqSysMTCID
'               SetCache "NAVBARIMAGE", "Images/Company/" + CSTR(reqSysMTCID) + "/navbarimage.gif"
					If Len(.MenuBarColor) > 0 Then SetCache "NAVBARIMAGE", .MenuBarColor Else SetCache "NAVBARIMAGE", ""
               SetCache "MTCSIGNIN", .IsSignIn
               SetCache "MTCJOINNOW", .IsJoinNow
				If Len(.HomePage) > 0 Then SetCache "MTCHOMEPAGE", .HomePage Else SetCache "MTCHOMEPAGE", ""
            End If
         End With
      End If
      Set oCompany = Nothing

	'Get the header file (.gif | .jpg) name for this company
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Company\" + CStr(reqSysMTCID) + "\Header[" + reqSysLanguage + "]"
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	Exists = oFileSys.FileExists(FilePath + ".gif")
	If Exists Then
		reqSysHeaderImage = "Header[" + reqSysLanguage + "].gif"
		SetCache "HEADERIMAGE", reqSysHeaderImage
	Else
		Exists = oFileSys.FileExists(FilePath + ".jpg")
		If Exists Then
			reqSysHeaderImage = "Header[" + reqSysLanguage + "].jpg"
			SetCache "HEADERIMAGE", reqSysHeaderImage
		End If
	End If
	Set oFileSys = Nothing

   End If
   GetMTC = reqSysMTCID
End Function
%>


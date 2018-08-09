<%
Function GetCompany(byval bvCompanyID)
   On Error Resume Next

	If bvCompanyID > 0 Then 
		reqCompanyID = bvCompanyID
	Else	
		reqCompanyID =  Numeric( Request.Item("CompanyID") )
	End If
	'reqSysCompanyID = Numeric( GetCache("COMPANYID") )
	reqSysCompanyID = reqCompanyID

   If (reqCompanyID > 0) Then
	Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
	If oCoption Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
	Else
		With oCoption
			.SysCurrentLanguage = reqSysLanguage
			.FetchCompany CLng(reqCompanyID)
			.Load .CoptionID, 1
            If (.CompanyID > 0) Then
               reqSysCompanyID = .CompanyID
               SetCache "COMPANYID", reqSysCompanyID
               If Len(.GAAcct) > 0 Then SetCache "CGAA", .GAAcct
'               SetCache "NAVBARIMAGE", "Images/Company/" + CSTR(reqSysCompanyID) + "/navbarimage.gif"
               SetCache "COMPANYSIGNIN", .IsSignIn
               SetCache "COMPANYJOINNOW", .IsJoinNow
'				If Len(.HomePage) > 0 Then SetCache "COMPANYHOMEPAGE", .HomePage Else SetCache "COMPANYHOMEPAGE", ""
            End If
		End With
	End If
	Set oCoption = Nothing

	If reqSysLanguage="" Then reqSysLanguage = "en"

	'Get the header file (.gif | .jpg) name for this company
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Company\" + CStr(reqSysCompanyID) + "\Header[" + reqSysLanguage + "]"
	Set oFileSys = CreateObject("Scripting.FileSystemObject")

	Exists = oFileSys.FileExists(FilePath + ".png")
	If Exists Then
		reqSysHeaderImage = "Header[" + reqSysLanguage + "].png"
		SetCache "HEADERIMAGE", reqSysHeaderImage
	Else
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
	End If
	Set oFileSys = Nothing

   End If
   GetCompany = reqSysCompanyID
End Function
%>


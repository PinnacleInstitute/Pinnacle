<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

CompanyID = CStr(GetCache("COMPANYID"))
ImageName = CStr(GetCache("IMAGENAME"))
GroupID = GetCache("GROUPID")

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "gif", "jpg", "png"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Images\Company\" & CompanyID
	.NewFileName = ImageName
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "3820.asp?CompanyID=" & CompanyID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	If GroupID <> 0 Then
		Response.Redirect "3854.asp?CompanyID=" + CSTR(CompanyID) + "&GroupID=" + CSTR(GroupID)
	Else
		Response.Redirect "4904.asp?CompanyID=" + CSTR(CompanyID)
	End If	
End If


%>
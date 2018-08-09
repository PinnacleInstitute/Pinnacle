<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

CompanyID = CStr(GetCache("COMPANYID"))
ImageName = CStr(GetCache("IMAGENAME"))
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 50 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "gif", "jpg"
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
	Response.Redirect "3814.asp?CompanyID=" & CompanyID
End If


%>
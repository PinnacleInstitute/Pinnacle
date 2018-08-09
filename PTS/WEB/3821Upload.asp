<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

CompanyID = CStr(GetCache("COMPANYID"))
GroupID = CStr(GetCache("GROUPID"))
FileName = CStr(GetCache("FILENAME"))

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "htm"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Sections\Company\" & CompanyID
	.NewFileName = FileName
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "3821.asp?CompanyID=" + CSTR(CompanyID) + "&GroupID=" + CSTR(GroupID) + "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "3854.asp?CompanyID=" + CSTR(CompanyID) + "&GroupID=" + CSTR(GroupID)
End If

%>
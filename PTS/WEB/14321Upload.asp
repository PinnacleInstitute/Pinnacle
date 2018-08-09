<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpCompanyID = GetCache("COMPANYID")
If (Not IsNumeric(tmpCompanyID)) Then tmpCompanyID = "0" Else tmpCompanyID = CStr(tmpCompanyID)

UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\ad\" + tmpCompanyID + "\"

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 200 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "png", "jpg", "gif"
	.UpLoadPath = UpLoadPath
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "14321.asp?CompanyID=" + tmpCompanyID + "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "14321.asp?CompanyID=" + tmpCompanyID + "&UploadImage=" & NewFileName
End If

%>
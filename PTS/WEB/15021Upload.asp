<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
MerchantID = GetCache("MERCHANTID")
Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Store\" & MerchantID & "\"

If (Not IsNumeric(CompanyID)) Then CompanyID = CLng(0) Else CompanyID = CLng(CompanyID)
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png"
	.UpLoadPath = Path
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "15021.asp?MerchantID=" & MerchantID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "15021.asp?MerchantID=" & MerchantID & "&UploadImageFile=" & NewFileName
End If

%>
<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpMerchantID = GetCache("MERCHANTID")
If (Not IsNumeric(tmpMerchantID)) Then tmpMerchantID = "0" Else tmpMerchantID = CStr(tmpMerchantID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 200 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png", "bmp"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\store\" & tmpMerchantID
	'.FileName = "NewName"
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "15020.asp?MerchantID=" & tmpMerchantID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "15004.asp?MerchantID=" & tmpMerchantID & "&UploadImage=" & NewFileName
End If

%>
<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "bmp"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\"
	'.FileName = "NewName"
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > o Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "0520.asp?ProductID=" & GetCache("PRODUCTID") & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "0503.asp?UploadImageFile=" & NewFileName
End If



%>
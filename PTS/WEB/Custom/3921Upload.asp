<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 5 * 1024 * 1024 '5 MB'
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "rm"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH")
	'.FileName = "NewName"
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > o Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "3921.asp?PromotionID=" & GetCache("PROMOTIONID") & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "3903.asp?UploadVideoFile=" & NewFileName
End If

%>

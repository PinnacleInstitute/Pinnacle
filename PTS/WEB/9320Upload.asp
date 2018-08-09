<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

FileName = CStr(GetCache("FILENAME"))

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
'	.MaxFileBytes = 50 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "htm"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Pages"
	.NewFileName = FileName
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "9320.asp?FileName=" + FileName + "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "9320.asp?FileName=" + FileName + "&Status=1"
End If


%>
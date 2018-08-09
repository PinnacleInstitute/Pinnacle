<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpTrainerID = GetCache("TRAINERID")
If (Not IsNumeric(tmpTrainerID)) Then tmpTrainerID = "0" Else tmpTrainerID = CStr(tmpTrainerID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 15 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "bmp"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Trainer\"
	.NewFileName = tmpTrainerID
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "0320.asp?TrainerID=" & tmpTrainerID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "0303.asp?UploadImageFile=" & NewFileName
End If



%>
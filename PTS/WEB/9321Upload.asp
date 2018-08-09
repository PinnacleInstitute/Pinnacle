<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpPageID = GetCache("PAGEID")
If (Not IsNumeric(tmpPageID)) Then tmpPageID = "0" Else tmpPageID = CStr(tmpPageID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "png", "jpg", "gif"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\page\"
	.NewFileName = tmpPageID
	.Upload
	NewFileName = tmpPageID & Right(.UploadedFileName, 4)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "9321.asp?PageID=" & tmpPageID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "9303.asp?PageID=" & tmpPageID & "&UploadImage=" & NewFileName
End If


%>
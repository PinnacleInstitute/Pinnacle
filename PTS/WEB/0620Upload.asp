<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
tmpAffiliateID = GetCache("AFFILIATEID")
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 15 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Affiliate"
	.NewFileName = tmpAffiliateID
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "0620.asp?AffiliateID=" & tmpAffiliateID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "0603.asp?UploadImageFile=" & NewFileName
End If


%>
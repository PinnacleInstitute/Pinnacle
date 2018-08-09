<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpLeadAdID = GetCache("LEADAD")
If (Not IsNumeric(tmpLeadAdID)) Then tmpLeadAdID = "0" Else tmpLeadAdID = CStr(tmpLeadAdID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 200 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images/LeadAd/"
	.NewFileName = tmpLeadAdID
	.Upload
	NewFileName = tmpLeadAdID & Right(.UploadedFileName, 4)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "15622.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "15603.asp?LeadAdID=" & tmpLeadAdID & "&UploadImageFile=" & NewFileName
End If

%>
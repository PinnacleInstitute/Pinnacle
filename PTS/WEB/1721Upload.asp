<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
CompanyID = GetCache("COMPANYID")
Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Company\" & CompanyID & "\Question\"

If (Not IsNumeric(CompanyID)) Then CompanyID = CLng(0) Else CompanyID = CLng(CompanyID)
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 200 * 1024
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
	Response.Redirect "1721.asp?CompanyID=" & CompanyID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "1721.asp?CompanyID=" & CompanyID & "&UploadImageFile=" & NewFileName
End If

%>
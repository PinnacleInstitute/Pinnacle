<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpCompanyID = GetCache("COMPANYID")
If (Not IsNumeric(tmpCompanyID)) Then tmpCompanyID = "0" Else tmpCompanyID = CStr(tmpCompanyID)
tmpAdID = GetCache("ADID")
If (Not IsNumeric(tmpAdID)) Then tmpAdID = "0" Else tmpAdID = CStr(tmpAdID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "png", "jpg", "gif"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\ad\"
	.NewFileName = tmpAdID
	.Upload
	NewFileName = tmpAdID & Right(.UploadedFileName, 4)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "14320.asp?CompanyID=" + tmpCompanyID + "&AdID=" & tmpAdID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "14303.asp?CompanyID=" + tmpCompanyID + "&AdID=" & tmpAdID & "&UploadImage=" & NewFileName
End If

%>
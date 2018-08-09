<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpProductID = GetCache("PRODUCTID")
If (Not IsNumeric(tmpProductID)) Then tmpProductID = "0" Else tmpProductID = CStr(tmpProductID)
tmpCompanyID = GetCache("COMPANYID")
If (Not IsNumeric(tmpCompanyID)) Then tmpCompanyID = "0" Else tmpCompanyID = CStr(tmpCompanyID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png", "bmp"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\company\" & tmpCompanyID
	'.FileName = "NewName"
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "5020.asp?ProductID=" & tmpProductID & "&CompanyID=" & tmpCompanyID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "5003.asp?ProductID=" & tmpProductID & "&UploadImage=" & NewFileName
End If


%>
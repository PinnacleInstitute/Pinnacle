<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpCompanyID = GetCache("COMPANYID")
If (Not IsNumeric(tmpCompanyID)) Then tmpCompanyID = "0" Else tmpCompanyID = CStr(tmpCompanyID)
tmpNewsID = GetCache("NEWSID")
If (Not IsNumeric(tmpNewsID)) Then tmpNewsID = "0" Else tmpNewsID = CStr(tmpNewsID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 100 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "png", "jpg", "gif"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\news\" + tmpCompanyID + "\"
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "9820.asp?CompanyID=" + tmpCompanyID + "&NewsID=" & tmpNewsID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "9803.asp?NewsID=" & tmpNewsID & "&UploadImage=" & NewFileName
End If


%>
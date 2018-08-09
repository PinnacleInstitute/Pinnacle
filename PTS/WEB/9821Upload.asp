<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpCompanyID = GetCache("COMPANYID")
tmpPath = GetCache("PATH")
If (Not IsNumeric(tmpCompanyID)) Then tmpCompanyID = "0" Else tmpCompanyID = CStr(tmpCompanyID)

UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "images\news\" + tmpCompanyID + "\"

If tmpPath <> "" Then
    UpLoadPath = UpLoadPath + tmpPath + "\"
    Set oFileSys = Server.CreateObject("Scripting.FileSystemObject")
    If NOT oFileSys.FolderExists(UpLoadPath) Then oFileSys.CreateFolder UpLoadPath
    Set oFileSys = Nothing
End If

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 200 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "png", "jpg", "gif"
	.UpLoadPath = UpLoadPath
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "9821.asp?CompanyID=" + tmpCompanyID + "&Path=" + tmpPath + "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "9821.asp?CompanyID=" + tmpCompanyID + "&Path=" + tmpPath + "&UploadImage=" & NewFileName
End If

%>
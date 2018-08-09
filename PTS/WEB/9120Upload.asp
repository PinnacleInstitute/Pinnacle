<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

PageSectionID = CStr(GetCache("PAGESECTIONID"))
CompanyID = CStr(GetCache("COMPANYID"))
FileName = CStr(GetCache("FILENAME"))

pos=InStr(Filename, ".htm")
If pos > 0 Then Filename = Left(Filename, pos-1)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
'	.MaxFileBytes = 50 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "htm"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Sections\Company\" & CompanyID & "\"
	.NewFileName = FileName
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing


If Err.number <> 0 Then
	Response.Redirect "9120.asp?PageSectionID=" & PageSectionID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "9120.asp?PageSectionID=" & PageSectionID & "&Status=1"
End If


%>
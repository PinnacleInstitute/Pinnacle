<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpCompany = GetCache("COMPANYID")
tmpMemberID = GetCache("MEMBERID")
If (Not IsNumeric(tmpMemberID)) Then tmpMemberID = "0" Else tmpMemberID = CStr(tmpMemberID)

'Remove old Logo files for this member
Set oFileSys = server.CreateObject("Scripting.FileSystemObject")
oFileSys.DeleteFile Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images/Company/" + CStr(tmpCompany) + "/Logo" + CStr(tmpMemberID) + ".*"
Set oFileSys = Nothing

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 50 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images/Company/" + CStr(tmpCompany) + "/"
	.NewFileName = "Logo" + CStr(tmpMemberID)
	.Upload
	NewFileName = "Logo" + CStr(tmpMemberID) + Right(.UploadedFileName, 4)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "13222.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "13221.asp?MemberID=" & tmpMemberID
End If

%>
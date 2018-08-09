<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpContentPage = GetCache("CONTENTPAGE")
tmpPopup = GetCache("POPUP")
tmpMemberID = GetCache("MEMBERID")
tmpPage = GetCache("PAGE")
If (Not IsNumeric(tmpMemberID)) Then tmpMemberID = "0" Else tmpMemberID = CStr(tmpMemberID)
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 50 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Member\"
	.NewFileName = tmpMemberID
	.Upload
	NewFileName = tmpMemberID & Right(.UploadedFileName, 4)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "0425.asp?MemberID=" & tmpMemberID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	If Len(tmpPage) = 0 Then
		Response.Redirect "0403.asp?MemberID=" & tmpMemberID & "&ContentPage=" & tmpContentPage & "&Popup=" & tmpPopup & "&UploadImageFile=" & NewFileName
	Else
		Response.Redirect tmpPage + ".asp?MemberID=" & tmpMemberID & "&ContentPage=" & tmpContentPage & "&Popup=" & tmpPopup & "&UploadImageFile=" & NewFileName
	End If	
End If

%>
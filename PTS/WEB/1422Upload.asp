<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpLeadCampaignID = GetCache("LEADCAMPAIGN")
If (Not IsNumeric(tmpLeadCampaignID)) Then tmpLeadCampaignID = "0" Else tmpLeadCampaignID = CStr(tmpLeadCampaignID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 75 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images/LeadCampaign/"
	.NewFileName = tmpLeadCampaignID
	.Upload
	NewFileName = tmpLeadCampaignID & Right(.UploadedFileName, 4)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "1422.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "1403.asp?LeadCampaignID=" & tmpLeadCampaignID & "&UploadImageFile=" & NewFileName
End If

%>
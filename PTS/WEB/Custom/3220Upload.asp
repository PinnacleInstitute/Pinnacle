<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
tmpAssessmentID = GetCache("ASSESSMENTID")
tmpAssessQuestionID = GetCache("ASSESSQUESTIONID")
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 1 * 1024 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
'	.FileExtensionList "jpg", "gif"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Sections\Assessment\" & tmpAssessmentID
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "3220.asp?AssessQuestionID=" & tmpAssessQuestionID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "3203.asp?AssessQuestionID=" & tmpAssessQuestionID & "&UploadMediaFile=" & NewFileName
End If


%>
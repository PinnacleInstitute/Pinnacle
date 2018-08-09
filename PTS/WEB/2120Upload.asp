<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
tmpCourseID = GetCache("COURSEID")
tmpQuizQuestionID = GetCache("QUIZQUESTIONID")
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 1 * 1024 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
'	.FileExtensionList "jpg", "gif"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Sections\Course\" & tmpCourseID
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "2120.asp?QuizQuestionID=" & tmpQuizQuestionID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "2103.asp?QuizQuestionID=" & tmpQuizQuestionID & "&UploadMediaFile=" & NewFileName
End If

%>
<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
CourseID = GetCache("COURSEID")
LessonID = GetCache("LESSONID")
If (Not IsNumeric(CourseID)) Then CourseID = CLng(0) Else CourseID = CLng(CourseID)
Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
'	.MaxFileBytes = 20 * 1024
'	.RejectExeExtension = true
'	.RejectEmptyExtension = true
'	.FileExtensionList "jpg", "gif"
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Sections\Course\" & CourseID
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "2306.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&CourseID=" & CourseID & "&LessonID=" & LessonID
Else
	Response.Redirect "2306.asp?UploadImageFile=" & NewFileName & "&CourseID=" & CourseID & "&LessonID=" & LessonID
End If

%>
<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

AttachmentID = CStr(GetCache("ATTACHMENTID"))
SizeLimit = CStr(GetCache("SIZELIMIT"))
If SizeLimit = "" or SizeLimit = "0" Then SizeLimit = 1024 * 1024 * 1 '1MB

Set oAttachment = server.CreateObject("ptsAttachmentUser.CAttachment")
With oAttachment
   .Load AttachmentID, 1
   Path = .ParentType + "\" + .ParentID
End With

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = CLng(SizeLimit)
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Attachments\" & Path
	.Upload
	FileSize = CLng(.FileSize)
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

With oAttachment
   .FileName = NewFileName
   .IsLink = 0
   IF CLng(FileSize) > 1024 Then 
      .AttachSize = round( CLng(FileSize) / 1024 )
   Else
      .AttachSize = 1
   End If
   .Save CLng(reqSysUserID)
End With
Set oAttachment = Nothing

'FIX Subscript out of range error on large files???
If err.number = 9 Then err.number = 0

If Err.number <> 0 Then
	Response.Redirect "8003.asp?AttachmentID=" & AttachmentID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
	Response.Redirect "8003.asp?AttachmentID=" & AttachmentID
End If


%>
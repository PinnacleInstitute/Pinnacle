<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

Dim Log, Extension, MaxSize, FileName, FilePath, Destination, UploadID, ErrorString
Dim Description, FileSize, AttachmentName
Dim reqSysUserID, reqSysUserGroup, xmlError

Sub DoError(ByVal bvNumber, ByVal bvSource, ByVal bvErrorMsg)
   bvErrorMsg = Replace(bvErrorMsg, Chr(39), Chr(34))
   Set oUtil = server.CreateObject("wtSystem.CUtility")
   With oUtil
      tmpMsgFld = .ErrMsgFld( bvErrorMsg )
      tmpMsgVal = .ErrMsgVal( bvErrorMsg )
   End With
   Set oUtil = Nothing
   xmlError = xmlError + "&UploadError=" & bvNumber & "&UploadErrorDesc=" + bvErrorMsg
   Err.Clear
End Sub

'-----initialize the error data
xmlError = ""

CheckSecurity reqSysUserID, reqSysUserGroup, True, 61

Extension = CStr(Request.QueryString("Ext"))
MaxSize = CLng(Request.QueryString("Max"))
FilePath = CStr(Request.QueryString("FilePath"))
FileName = CStr(Request.QueryString("FileName"))
ReturnURL = CStr(Request.QueryString("ReturnURL"))
UploadID = CStr(Request.QueryString("UID"))
Log = CStr(Request.QueryString("Log"))

Response.Buffer = true
Response.Expires = -10000
Server.ScriptTimeOut = 5400

If Len(Destination) = 0 Then
	Destination = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Attachments"
End If
If Len(Extension) = 0 Then
	Extension = "*"
End If
If MaxSize <= 0 Then
	MaxSize = 1024 * 1024 * 1 'limit to 1 MB 
End If

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
If Obj Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - wtFileUpload.CFileUpload"
Else
	with Obj
		.LogID = UploadID
		.MaxFileBytes = MaxSize
		.FileExtensions = Extension 
		.UpLoadPath = FilePath
		.NewFileName = FileName
		.Log = Log
		.UserID = reqSysUserID
		.Upload	
		If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
		FileSize = CLng(.FileSize)
		FileName = CStr(.NewFileName)
	End With
End If
Set Obj = Nothing

If InStr(1, ReturnURL, "?") = 0 Then
	ReturnURL = ReturnURL + "?"
Else
	ReturnURL = ReturnURL + "&"
End If

ReturnURL = Replace(ReturnURL, "%26", "&")
Response.Redirect ReturnURL & "FileName=" & FileName & "&FileSize=" & FileSize & xmlError
%>
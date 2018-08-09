<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

Path = CStr(GetCache("PATH"))
ID = CStr(GetCache("ID"))
RetURL = CStr(GetCache("RETURL"))

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
If Not (Obj Is Nothing) Then
	with Obj
		.InputName = "upload"
	'	.MaxFileBytes = 1024 * 1024 * 1 '1MB
	'	.RejectExeExtension = true
	'	.RejectEmptyExtension = true
		.UpLoadPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + Path
		.Upload
		FileSize = CLng(.FileSize)
		NewFileName = .UploadedFileName
		pos = InStrRev( NewFileName, "\" )
		If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
	End With
	Set Obj = Nothing
End If

If Len(RetURL) > 0 Then
	tmpSysServerName = Request.ServerVariables("SERVER_NAME")
	tmpSysServerPath = Request.ServerVariables("PATH_INFO")
	pos = InStrRev( tmpSysServerPath, "/" )
	If pos > o Then tmpSysServerPath = Left(tmpSysServerPath, pos)

	tmpURL = "http://" + tmpSysServerName + tmpSysServerPath + Path + "\" + NewFileName
	RetURL = Replace(RetURL, "%26", "&") + "?ID=" & ID & "&FileName=" + tmpURL + "&FileSize=" & FileSize

	If Err.number = 0 Then
		Response.Redirect RetURL
	Else
		Response.Redirect RetURL + "&UploadError=" & Err.Number & "&UploadErrorDesc=" + Err.Description
	End If
Else
	If Err.number = 0 Then
		Response.Write NewFileName + " Successfully Uploaded"
	Else
		Response.Write "<BR>ERROR: " & Err.Number & " - " + Err.Description
		Response.Write "<BR>Path: " + Request.ServerVariables("APPL_PHYSICAL_PATH") + Path
	End If
End If

%>
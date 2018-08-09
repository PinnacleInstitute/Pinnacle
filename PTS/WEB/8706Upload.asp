<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
EmailListID = GetCache("EmailListID")
CompanyID = GetCache("CompanyID")
If (Not IsNumeric(EmailListID)) Then EmailListID = CLng(0) Else EmailListID = CLng(EmailListID)
If (Not IsNumeric(CompanyID)) Then CompanyID = CLng(0) Else CompanyID = CLng(CompanyID)

Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Library\"

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
'	.MaxFileBytes = 20 * 1024
'	.RejectExeExtension = true
'	.RejectEmptyExtension = true
'	.FileExtensionList "jpg", "gif"
	.UpLoadPath = Path
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "8706.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&EmailListID=" & EmailListID & "&CompanyID=" & CompanyID
Else
   Dim oFileSys, oFile
   Dim Email, FirstName, LastName, Data1, Data2, Data3, Data4, Data5
   Dim data, x, rec, pos
   
   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
   End If
   Set oFile = oFileSys.OpenTextFile(Path + NewFileName)
   If oFile Is Nothing Then
		Response.Write "Couldn't open file: " + Path + NewFileName
		Response.End
   End If
   Set oEmailee = server.CreateObject("ptsEmaileeUser.CEmailee")
   If oEmailee Is Nothing Then
		Response.Write "Unable to Create Object - ptsEmaileeUser.CEmailee"
		Response.End
   End If
   oEmailee.EmailListID = EmailListID
   oEmailee.CompanyID = CompanyID
   oEmailee.Status = 1

   Do While oFile.AtEndOfStream <> True
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
         Email = ""
         FirstName = ""
         LastName = ""
         Data1 = ""
         Data2 = ""
         Data3 = ""
         Data4 = ""
         Data5 = ""
         x = 1
         Do While rec <> ""
				'---If the field is enclosed in quotes (i.e. it contains a comma), get the entire field
				rec = LTrim(rec)
				If Left(rec, 1) = """" Then
					quote = True
					rec = Mid(rec, 2)
					pos = InStr(rec, """")
					If pos > 0 Then pos = InStr(pos, rec, ",") Else quote = False
				Else
					quote = False
					pos = InStr(rec, ",")
				End If
				If pos = 0 Then
					data = rec
					rec = ""
				Else
					data = Left(rec, pos - 1)
					rec = Mid(rec, pos + 1)
				End If
				If quote Then data = Left(data, Len(data) - 1)

            Select Case x
               Case 1: Email = data
               Case 2: FirstName = data
               Case 3: LastName = data
               Case 4: Data1 = data
               Case 5: Data2 = data
               Case 6: Data3 = data
               Case 7: Data4 = data
               Case 8: Data5 = data
            End Select
            x = x + 1
         Loop
         If InStr(Email, "@") > 0 Then
				With oEmailee
				   .Email = Email
				   .FirstName = FirstName
				   .LastName = LastName
				   .Data1 = Data1
				   .Data2 = Data2
				   .Data3 = Data3
				   .Data4 = Data4
				   .Data5 = Data5
				   x = .Add(1)
				End With
	      End If
      End If
   Loop

   oFile.Close
   Set oEmailee = Nothing
   Set oFile = Nothing
   Set oFileSys = Nothing

	Response.Redirect "8903.asp?EmailListID=" & EmailListID & "&CompanyID=" & CompanyID
End If

%>
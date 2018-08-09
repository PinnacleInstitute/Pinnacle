<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
MemberID = GetCache("MemberID")
If (Not IsNumeric(MemberID)) Then MemberID = CLng(0) Else MemberID = CLng(MemberID)

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
	Response.Redirect "8106.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&MemberID=" & MemberID & "&CompanyID=" & CompanyID
Else
   Dim oFileSys, oFile
   Dim	NameFirst, NameLast, Email, Phone1, Phone2, Street, Unit, City, State, Zip, Country, CallTime, Source, Priority, Comment
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
   Set oLead = server.CreateObject("ptsLeadUser.CLead")
   If oLead Is Nothing Then
		Response.Write "Unable to Create Object - ptsLeadUser.CLead"
		Response.End
   End If
   oLead.MemberID = MemberID
   oLead.LeadDate = Now()
   oLead.Status = 0

	cnt = 0
   Do While oFile.AtEndOfStream <> True
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
		NameFirst = ""
		NameLast = ""
		Email = ""
		Phone1 = ""
		Phone2 = ""
		Street = ""
		Unit = ""
		City = ""
		State = ""
		Zip = ""
		Country = ""
		CallTime = ""
		Source = ""
		Priority = ""
		Comment = ""
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
               Case 1: NameFirst = data
               Case 2: NameLast = data
               Case 3: Email = data
               Case 4: Phone1 = data
               Case 5: Phone2 = data
               Case 6: Street = data
               Case 7: Unit = data
               Case 8: City = data
               Case 9: State = data
               Case 10: Zip = data
               Case 11: Country = data
               Case 12: CallTime = data
               Case 13: Source = data
               Case 14: Priority = data
               Case 15:
					Comment = data + rec
					rec = ""
            End Select
            x = x + 1
         Loop
         If NameFirst <> "" OR NameLast <> "" Then
				With oLead
					.NameFirst = NameFirst
					.NameLast = NameLast
					.Email = Email
					.Phone1 = Phone1
					.Phone2 = Phone2
					.Street = Street
					.Unit = Unit
					.City = City
					.State = State 
					.Zip = Zip
					.Country = Country
					.CallTime = CallTime
					.Source = Source
					.Priority = Priority
					.Comment = Comment
				   x = .Add(1)
				   cnt = cnt + 1
				End With
	      End If
      End If
   Loop

   oFile.Close
   Set oLead = Nothing
   Set oFile = Nothing
   Set oFileSys = Nothing

	If cnt = 0 Then cnt = -1
	Response.Redirect "2206.asp?MemberID=" & MemberID & "&Leads=" & cnt
End If

%>
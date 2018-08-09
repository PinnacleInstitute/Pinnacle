<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
CompanyID = GetCache("CompanyID")
MemberID = GetCache("MemberID")
If (Not IsNumeric(MemberID)) Then MemberID = CLng(0) Else MemberID = CLng(MemberID)
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
	Response.Redirect "8106.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&MemberID=" & MemberID & "&CompanyID=" & CompanyID
Else
   Dim oFileSys, oFile
	Dim SalesCampaignID, ProspectName, NameFirst, NameLast, Title
	Dim Email, Phone1, Phone2, Street, Unit, City, State, Zip, Country
   Dim data, x, rec, pos, timestamp
   
   timestamp = Now()
   
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
   Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
   If oProspect Is Nothing Then
		Response.Write "Unable to Create Object - ptsProspectUser.CProspect"
		Response.End
   End If
   oProspect.CompanyID = CompanyID
   oProspect.MemberID = MemberID
   oProspect.CreateDate = timestamp
   oProspect.Status = 4

	cnt = 0
	Do While oFile.AtEndOfStream <> True
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
			SalesCampaignID = ""
			CloseDate = ""
			ProspectName = ""
			NameFirst = ""
			NameLast = ""
			Title = ""
			Email = ""
			Phone1 = ""
			Phone2 = ""
			Street = ""
			Unit = ""
			City = ""
			State = ""
			Zip = ""
			Country = ""
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
               Case 1: SalesCampaignID = data
               Case 2: CloseDate = data
               Case 3: ProspectName = data
               Case 4: NameFirst = data
               Case 5: NameLast = data
               Case 6: Title = data
               Case 7: Email = data
               Case 8: Phone1 = data
               Case 9: Phone2 = data
               Case 10: Street = data
               Case 11: Unit = data
               Case 12: City = data
               Case 13: State = data
               Case 14: Zip = data
               Case 15: Country = data
            End Select
            x = x + 1
         Loop
         If SalesCampaignID <> "" And ProspectName <> "" Then
				With oProspect
					.SalesCampaignID = SalesCampaignID
					If CloseDate = ""
						.CloseDate = Date()
					Else
						.CloseDate = CloseDate
					End If	
					.ProspectName = ProspectName
					.NameFirst = NameFirst
					.NameLast = NameLast
					.Title = Title
					.Email = Email
					.Phone1 = Phone1
					.Phone2 = Phone2
					.Street = Street
					.Unit = Unit
					.City = City
					.State = State 
					.Zip = Zip
					.Country = Country
				   x = .Add(1)
				   cnt = cnt + 1
				End With
	      End If
      End If
   Loop

	oFile.Close
	Set oProspect = Nothing
	Set oFile = Nothing
	Set oFileSys = Nothing

	If cnt = 0 Then cnt = -1
	Response.Redirect "8116.asp?MemberID=" & MemberID & "&CompanyID=" & CompanyID & "&Prospects=" & cnt
End If

%>
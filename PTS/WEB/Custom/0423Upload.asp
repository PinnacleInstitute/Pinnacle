<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
CompanyID = GetCache("CompanyID")
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
	Response.Redirect "0423.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&Company=" & CompanyID
Else
   Dim oFileSys, oFile
   Dim Company, Status, First, Last, Email, Ref
   Dim data, x, rec, pos, NewMembers
   
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
   
   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .Load CLng(CompanyID), 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpBilling = .Billing
         tmpPrice = .Price
         tmpRetail = .Retail
         tmpDiscount = .Discount
         tmpIsDiscount = .IsDiscount
         tmpPromoID = .PromoCode
         tmpAccessLimit = .AccessLimit
         tmpQuizLimit = .QuizLimit
         tmpMemberLimit = .MemberLimit
         tmpTrialDays = .TrialDays
         tmpOptions = ""
         If (.IsSalesDefault <> 0) Then tmpOptions = tmpOptions + "E"
         If (.ProjectsDefault = 2) Then tmpOptions = tmpOptions + "F"
         If (.ProjectsDefault = 3) Then tmpOptions = tmpOptions + "f"
      End With
   End If
   Set oCompany = Nothing

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
		Response.Write "Unable to Create Object - ptsMemberUser.CMember"
		Response.End
   End If
   With oMember
		.CompanyID = CompanyID
		.EnrollDate = CStr(Date())
		.PaidDate = .EnrollDate
		.UserStatus = 1
		.UserGroup = 41
		.Billing = tmpBilling
		.Price = tmpPrice
		.Retail = tmpRetail
		.Discount = tmpDiscount
		.IsDiscount = tmpIsDiscount
		.PromoID = tmpPromoID
		.AccessLimit = tmpAccessLimit
		.QuizLimit = tmpQuizLimit
		.TrialDays = tmpTrialDays
		.Options = tmpOptions
	End With

	NewMembers = 0	
   Do While oFile.AtEndOfStream <> True
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
         Company = ""
         Status = ""
         First = ""
         Last = ""
         Email = ""
         Ref = ""
         Grp = ""
         Role = ""
         Secure = ""
         Billing = ""
         x = 1
         Do While rec <> ""
				'---If the field is enclosed in quotes (i.e. it contains a comma), get the entire field
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
               Case 1: Company = data
               Case 2: Status = data
               Case 3: First = Left(data,30)
               Case 4: Last = Left(data,30)
               Case 5: Email = Left(data,80)
               Case 6: Ref = data
               Case 7: Grp = Left(data,15)
               Case 8: Role = data
               Case 9: Secure = data
               Case 10: Billing = data
            End Select
            x = x + 1
         Loop
         If Status = "" Then Status = "1"
         If CLng(Company) = CompanyID AND First <> "" AND Last <> "" AND Email <> "" Then
				With oMember
					.Status = Status
					.NameFirst = First
					.NameLast = Last
					.Email = Email
					.Reference = Ref
					.Grp = Grp
					.Role = Role
					.Secure = Secure
					If Billing <> "" Then .Billing = Billing
					.CompanyName = .NameLast + ", " + .NameFirst
					x = 0
				   x = .Add(1)
				   If x > 0 Then NewMembers = NewMembers + 1
				End With
	      End If
      End If
   Loop

   oFile.Close
   Set oMember = Nothing
   Set oFile = Nothing
   Set oFileSys = Nothing

	If NewMembers = 0 Then NewMembers = -1
	
	Response.Redirect "0423.asp?Company=" & CompanyID & "&NewMembers=" & NewMembers
End If

%>
<%
On Error Resume Next

Dim oFileSys, oFile, oMember
'FileName = "D:\@Source\Pinnacle\PTS\WEB\Members.txt"
FileName = "C:\PTS\WEB\Members.txt"

Set oFileSys = CreateObject("Scripting.FileSystemObject")
If oFileSys Is Nothing Then
	Response.Write "Scripting.FileSystemObject failed to load"
	Response.End
End If
Set oFile = oFileSys.OpenTextFile(FileName)
If oFile Is Nothing Then
	Response.Write "Couldn't open file: " + FileName
	Response.End
End If
Set oMember = server.CreateObject("ptsMemberUser.CMember")
If oMember Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
End If
Set oSignature = server.CreateObject("ptsSignatureUser.CSignature")
If oSignature Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsSignatureUser.CSignature"
End If
Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
If oAddress Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
End If

With oMember
	.CompanyID = 1
	.Status = 1
	.UserStatus = 1
	.UserGroup = 41
	.Billing = 3
	.Icons = "G2HEK"
	.AccessLimit = "NONE"
	.NotifyMentor = "ABCDEF"
	.Level = 1
	.Price = 12.95
	.InitPrice = 86.05
	.TaxIDType = 1
	

	Do While oFile.AtEndOfStream <> True
		rec = oFile.ReadLine
		If Len(Trim(rec)) > 0 Then
			a=Split(rec, "|" )  'subscript zero based
			SponsorID = TRIM(a(0))
			EnrollDate = TRIM(a(1))
			Title = TRIM(a(2))
			Logon = TRIM(a(3))
			NameFirst = TRIM(a(4))
			NameLast = TRIM(a(5))
			CompanyName = TRIM(a(6))
			Email = TRIM(a(7))
			Phone = TRIM(a(8))
			SSN = TRIM(a(9))
			Street = TRIM(a(10))
			City = TRIM(a(11))
			State = TRIM(a(12))
			Zip = TRIM(a(13))
			BDay = TRIM(a(14))
			Welcome = TRIM(a(15))
			Market = TRIM(a(16))

			If Email = "" Then Email = Logon + "@myToTheNines.com"

response.Write "<BR><BR>" + SponsorID + ", " + NameFirst + " " + NameLast + ", " + Logon + ", " + Email + ", " + Phone + ", " + EnrollDate + ", " + Title + ", " + CompanyName + ", " + SSN
response.Write "<BR>" + Street + ", " + City + ", " + State + " " + Zip + ", " + BDay

	        .NameFirst = Left(NameFirst, 30)
		    .NameLast = Left(NameLast, 30)
			.Email = Left(Email, 80)
			.Email2 = Left(Email, 80)
			.Phone1 = Left(Phone, 30)
			.TaxID = Left(SSN, 15)
			.NewLogon = Left(Logon, 80)
			.NewPassword = Left(Logon, 30)
			.EnrollDate = EnrollDate
			.Title = Title
			.CompanyName = Left(CompanyName, 60 )
			If Len(CompanyName) > 0 Then .IsCompany = 1
			.Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
			.NotifyMentor = "ABCDEF"
			.ReferralID = SponsorID
			.SponsorID = SponsorID
			.MentorID = SponsorID
			.Reference = Left(BDay, 15)
			
			reqMemberID = CLng(.Add(1))

			With oSignature
				.Load 0, CLng(reqSysUserID)
				.MemberID = reqMemberID
				.UseType = 3
				.UseID = 1
				.IsActive = 1
				.Language = "en"
				
				Select Case Title
				Case 1: TitleName = "Retail Consultant"
				Case 2: TitleName = "Manager"
				Case 3: TitleName = "Executive Director"
				Case 4: TitleName = "Regional Director"
				End Select

				tmp = CHR(60)+"p"+CHR(62)+CHR(60)+"img align="+CHR(34)+"left"+CHR(34)+" border="+CHR(34)+"0"+CHR(34)+" height="+CHR(34)+"90"+CHR(34)+" hspace="+CHR(34)+"10"+CHR(34)+" src="+CHR(34)+"images/member/" + CSTR(reqMemberID) + ".jpg"+CHR(34)+" vspace="+CHR(34)+"5"+CHR(34)+" /"+CHR(62)+CHR(38)+"nbsp;"+CHR(38)+"nbsp;"
				tmp = tmp + CHR(60)+"font color="+CHR(34)+"#808080"+CHR(34)+" face="+CHR(34)+"Arial"+CHR(34)+" size="+CHR(34)+"3"+CHR(34)+CHR(62)+""
				tmp = tmp + CHR(60)+"b"+CHR(62)+CHR(38)+"nbsp;"+CHR(38)+"nbsp; " + NameFirst + " " + NameLast + CHR(38)+"nbsp;"+CHR(60)+"/b"+CHR(62)+CHR(60)+"/p"+CHR(62)+CHR(60)+"p"+CHR(62)+""
				tmp = tmp + CHR(60)+"p"+CHR(62)+CHR(38)+"nbsp;"+CHR(38)+"nbsp; " + TitleName + CHR(38)+"nbsp;"+CHR(60)+"/p"+CHR(62)+""
				tmp = tmp + CHR(60)+"p"+CHR(62)+CHR(38)+"nbsp;"+CHR(60)+"/p"+CHR(62)+CHR(60)+"font size="+CHR(34)+"2"+CHR(34)+CHR(62)+""
				tmp = tmp + CHR(60)+"p"+CHR(62)+CHR(38)+"nbsp;"+CHR(38)+"nbsp; Primary Phone: " + Phone + CHR(38)+"nbsp;"+CHR(60)+"br"+CHR(62)+""
				tmp = tmp + CHR(38)+"nbsp;"+CHR(38)+"nbsp; Email: "+CHR(60)+"a href="+CHR(34)+"mailto:" + Email + CHR(34)+CHR(62)+"" + Email + CHR(60)+"/a"+CHR(62)+CHR(38)+"nbsp;"+CHR(60)+"/p"+CHR(62)+""
				tmp = tmp + CHR(60)+"p"+CHR(62)+CHR(38)+"nbsp;"+CHR(60)+"/p"+CHR(62)+CHR(60)+"p"+CHR(62)+CHR(38)+"nbsp;"+CHR(38)+"nbsp;"+CHR(60)+"br/"+CHR(62)+"" + Market + CHR(60)+"/p"+CHR(62)+""
				tmp = tmp + CHR(60)+"p"+CHR(62)+CHR(38)+"nbsp;"+CHR(60)+"/p"+CHR(62)+CHR(60)+"p"+CHR(62)+"" + Welcome + CHR(60)+"/p"+CHR(62)+CHR(60)+"/font"+CHR(62)+CHR(60)+"/font"+CHR(62)+""

				.Data = tmp

	            SignatureID = CLng(.Add(1))

			End With

			If Street <> "" Then
				With oAddress
					.Load 0, CLng(reqSysUserID)
					.OwnerType = 4
					.OwnerID = reqMemberID
					.AddressType = 2
					.IsActive = 1
					.Street1 = Left(Street, 60)
					.City = Left(City, 30)
					.State = Left(State, 30)
					.Zip = Left(Zip, 20)
					.CountryID = 224
					tmpAddressID = CLng(.Add(CLng(reqSysUserID)))
				End With
			End If
			
	   End If
	Loop
End With

oFile.Close
Set oFile = Nothing
Set oFileSys = Nothing
Set oMember = Nothing
Set oSignature = Nothing
Set oAddress = Nothing

%>
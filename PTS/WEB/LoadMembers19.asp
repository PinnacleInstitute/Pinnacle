<%
On Error Resume Next

Dim oFileSys, oFile, oMember
'FileName = "D:\@Source\Pinnacle\PTS\WEB\Members.txt"
FileName = "C:\PTS\WEB\sections\company\19\Members.txt"
CompanyID = 19

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
Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
If oAddress Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
End If

Do While oFile.AtEndOfStream <> True
    rec = oFile.ReadLine
    Err.Clear()
    
    If Len(Trim(rec)) > 0 Then
        a=Split(rec, "," )  'subscript zero based
        ID = TRIM(a(0))
        Logon = TRIM(a(1))
        NameFirst = TRIM(a(2))
        NameLast = TRIM(a(3))
        Email = TRIM(a(4))
        Enroller = TRIM(a(5))
        Sponsor = TRIM(a(6))
        Price = TRIM(a(7))
        Blank = TRIM(a(8))
        EnrollDate = TRIM(a(9))
        Sreeet = ""

        If IsNumeric(ID) Then
            With oMember
                .FetchRef CompanyID, ID
                If (.MemberID = 0) Then .Load 0, 1 Else .Load .MemberID, 1
                .CompanyID = CompanyID
                .Status = 1
                .UserStatus = 1
                .UserGroup = 41
                .Billing = 3
                .AccessLimit = "NONE"
                .NotifyMentor = "ABCDEF"
                .Level = 1
                .Price = 14.95
                .InitPrice = 0
                .Title = 1

                .NameFirst = Left(NameFirst, 30)
                .NameLast = Left(NameLast, 30)
                .Email = Left(Email, 80)
                .Email2 = Left(Email, 80)
                .NewLogon = Left(Logon, 80)
                .NewPassword = Left(Logon, 30)
                .EnrollDate = EnrollDate
                If InStr(Price, "20") > 0 Then .Price = 20 Else .Price = 0
                .Reference = ID
                .Referral = Enroller
                .Icons = Sponsor
                .CompanyName = Left(.NameLast + ", " + .NameFirst, 60)
                .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>"

                If (.MemberID = 0) Then
                    reqMemberID = CLng(.Add(1))
                    response.Write "<BR><BR>ADD: " + ID + ", " + Logon + ", " + NameFirst + " " + NameLast + ", " + Email + ", " + Enroller + ", " + Sponsor + ", " + EnrollDate + ", " + Price

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
                            tmpAddressID = .Add(1)
                        End With
                    End If
                Else
    			    .Save 1
                    response.Write "<BR><BR>SAVE: " + ID + ", " + Logon + ", " + NameFirst + " " + NameLast + ", " + Email + ", " + Enroller + ", " + Sponsor + ", " + EnrollDate + ", " + Price
                End If

                If Err.number > 0 Then 
                    Response.Write "<BR>" + ID + " - " + Err.Description
                End If    
            End With
        End If
    End If
Loop

oFile.Close
Set oFile = Nothing
Set oFileSys = Nothing
Set oMember = Nothing
Set oAddress = Nothing

%>
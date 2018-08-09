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
	Response.Redirect "0422u.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&Company=" & CompanyID
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

   Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
   If oHTTP Is Nothing Then
        Response.Write "MSXML2.ServerXMLHTTP failed to load"
	    Response.End
   End If
   
	NewMembers = 0	
   Do While oFile.AtEndOfStream <> True
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then

        Company = ""
        Ref = ""
        First = ""
        Last = ""
        Email = ""
        Status = ""
        Level = ""
        Title = ""
        GroupID = ""
        CN = ""
        P1 = ""
        P2 = ""
        P3 = ""
        Street1 = ""
        Street2 = ""
        City = ""
        State = ""
        Zip = ""
        CountryID = ""
        Lgn = ""
        Pwd = ""
        Refer = ""
        Mentor = ""
        Sponsor = ""
        PayType = ""
        Price = ""
        iPrice = ""
        Options2 = ""

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
               Case 2: Ref = Left(data,15)
               Case 3: First = Left(data,30)
               Case 4: Last = Left(data,30)
               Case 5: Email = Left(data,80)
               Case 6: Status = data
               Case 7: Level = data
               Case 8: Title = data
               Case 9: GroupID = data
               Case 10: CN = Left(data,60)
               Case 11: P1 = Left(data,30)
               Case 12: P2 = Left(data,30)
               Case 13: Street1 = Left(data,60)
               Case 14: Street2 = Left(data,60)
               Case 15: City = Left(data,30)
               Case 16: State = Left(data,30)
               Case 17: Zip = Left(data,20)
               Case 18: CountryID = data
               Case 19: Lgn = Left(data,80)
               Case 20: Pwd = Left(data,30)
               Case 21: Refer = Left(data,15)
               Case 22: Mentor = Left(data,15)
               Case 23: Sponsor = Left(data,15)
               Case 24: PayType = data
               Case 25: Price = data
               Case 26: iPrice = data
               Case 27: Options2 = Left(data,40)
            End Select
            x = x + 1
         Loop
         
         'Check for Header and that we got all the fields
         If lcase(Left(Company,7)) <> "company" And x = 28 Then 
         
             If Status = "" Then Status = "1"
             If CLng(Company) = CompanyID AND First <> "" AND Last <> "" AND Email <> "" Then
                str = "c=" + Company
                str = str + "&amp;r=" + Ref
                str = str + "&amp;first=" + First
                str = str + "&amp;last=" + Last
                str = str + "&amp;email=" + Email
                str = str + "&amp;status=" + Status
                str = str + "&amp;level=" + Level
                str = str + "&amp;title=" + Title
                str = str + "&amp;groupid=" + GroupID
                str = str + "&amp;cn=" + CN
                str = str + "&amp;p1=" + P1
                str = str + "&amp;p2=" + P2
                str = str + "&amp;street1=" + Street1
                str = str + "&amp;street2=" + Street2
                str = str + "&amp;city=" + City
                str = str + "&amp;state=" + State
                str = str + "&amp;zip=" + Zip
                str = str + "&amp;countryid=" + CountryID
                str = str + "&amp;lg=" + Lgn
                str = str + "&amp;pw=" + Pwd
                str = str + "&amp;refer=" + Refer
                str = str + "&amp;mentor=" + Mentor
                str = str + "&amp;sponsor=" + Sponsor
                str = str + "&amp;paytype=" + PayType 
                str = str + "&amp;price=" + Price
                str = str + "&amp;iprice=" + iPrice 
                str = str + "&amp;options2=" + Options2

    	        oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0422.asp?" + str
	            oHTTP.send
	            NewMembers = NewMembers + 1
            End If
	      End If
      End If
   Loop

   oFile.Close
   Set oHTTP = Nothing
   Set oFile = Nothing
   Set oFileSys = Nothing

	If NewMembers = 0 Then NewMembers = -1
	
	Response.Redirect "0422u.asp?Company=" & CompanyID & "&NewMembers=" & NewMembers
End If

%>
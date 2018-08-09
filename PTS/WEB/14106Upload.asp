<!--#include file="Include\Cookies.asp"-->
<!--#include file="Include\Comm.asp"-->
<%
On Error Resume Next
MemberID = GetCache("MemberID")
If (Not IsNumeric(MemberID)) Then MemberID = CLng(0) Else MemberID = CLng(MemberID)

Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Library\"
'Set this page to not timeout for 4 hours
Server.ScriptTimeout = 14400

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
	Response.Redirect "14106.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&MemberID=" & MemberID
Else
   Dim oFileSys, oFile
   Dim	NameFirst, NameLast, Email
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
   Set oFriend = server.CreateObject("ptsFriendUser.CFriend")
   If oFriend Is Nothing Then
		Response.Write "Unable to Create Object - ptsFriendUser.CFriend"
		Response.End
   End If
   
   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
		Response.Write "Unable to Create Object - ptsMemberUser.CMember"
		Response.End
   Else
      With oMember
        .Load MemberID, 1
        CompanyID = .CompanyID
        tmpSender = .Email
        tmpFrom = .Email
        tmpMemberFirst = .NameFirst
        tmpMemberLast = .NameLast
        tmpSubject = tmpMemberFirst + " " + tmpMemberLast + " Has Invited You"
      End With
   End If
   Set oMember = Nothing

   reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "FriendEmail.htm"
         .Path = reqSysWebDirectory + "Sections\Company\" + CStr(CompanyID)
         .Language = "en"
         .Project = "PTS"
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         MasterBody = .Data
        MasterBody = Replace( MasterBody, "{cid}", reqCompanyID )
        MasterBody = Replace( MasterBody, "{m-firstname}", tmpMemberFirst )
        MasterBody = Replace( MasterBody, "{m-lastname}", tmpMemberLast )
      End With
   End If
   Set oHTMLFile = Nothing
  
   oFriend.MemberID = MemberID
   oFriend.FriendDate = Date()
   oFriend.Status = 1
   oFriend.CountryID = 224

	cnt = 0
   Do While oFile.AtEndOfStream <> True
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
		NameFirst = ""
		NameLast = ""
		Email = ""
		GroupID = 0
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
               Case 4: GroupID = data
            End Select
            x = x + 1
         Loop
         If Email <> "" And (NameFirst <> "" OR NameLast <> "") Then
            pos = InStr(Email, "@")
            dups = oFriend.Duplicate(Email)
            If pos > 0 And dups = 0 Then
                With oFriend
                    .NameFirst = NameFirst
                    .NameLast = NameLast
                    .Email = Email
                    .FriendGroupID = GroupID
                    FriendID = .Add(1)
                    cnt = cnt + 1
                End With
				
			    tmpTo = Email
			    If InStr(tmpTo, "@") > 0 Then
				    If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
			        tmpBody = Replace( MasterBody, "{id}", FriendID )
			        tmpBody = Replace( tmpBody, "{firstname}", NameFirst )
			        tmpBody = Replace( tmpBody, "{lastname}", NameLast )
			        SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
			    End If
            End If
	      End If
      End If
   Loop

   oFile.Close
   Set oFriend = Nothing
   Set oFile = Nothing
   Set oFileSys = Nothing

	If cnt = 0 Then cnt = -1
	Response.Redirect "14106.asp?MemberID=" & MemberID & "&Friends=" & cnt
End If

%>
<%
'****************************************************************************************
Function LogMemberNote( byval bvOwner, byval bvNote )
	On Error Resume Next
	LogNote 4, bvOwner, bvNote 
End Function

'****************************************************************************************
Function LogNote( byval bvOwnerType, byval bvOwner, byval bvNote )
	On Error Resume Next
	tmpUserID = 1
	If reqSysUserGroup <= 52 Then tmpUserID = reqSysUserID

      Set oNote = server.CreateObject("ptsNoteUser.CNote")
      If oNote Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
      Else
         With oNote
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .AuthUserID = tmpUserID
            .NoteDate = Now
            .OwnerType = bvOwnerType
            .OwnerID = bvOwner
            .Notes = bvNote
            NoteID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oNote = Nothing
End Function

%>


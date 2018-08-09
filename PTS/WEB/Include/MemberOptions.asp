<% 
Function SetMemberOptions(MemberID, CompanyID, Language)
   On Error Resume Next

	tmpMemberPage = "Member"
	tmpGroupPage = "Member"
	tmpIntroPage = "Intro"
	tmpGroupID = 0
	tmpSecure = ""
	tmpStatus = 0
	tmpLevel = 0
	
   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .Load CLng(MemberID), 1
			tmpGroupID = .GroupID
			tmpSecure = .Secure
			tmpStatus = .Status
			tmpLevel = .Level
      End With
   End If
   Set oMember = Nothing

	'Check for a custom member page, intro page and training buddy image & page
	'Get the physical path to the web directory
	Path = Request.ServerVariables("APPL_PHYSICAL_PATH")
	'Check for a custom member home page  for the member's level
	tmpMemberPage = FindFileName(Path + "Sections\Company\" & CompanyID & "\", tmpMemberPage, 0, tmpLevel, ".htm", Language)
	'Check for a custom group page
	tmpGroupPage = FindFileName(Path + "Sections\Company\" & CompanyID & "\", tmpGroupPage, tmpGroupID, -1, ".htm", Language)
	'if we didn't find a group page, delete the default group page
	If InStr(tmpGroupPage, CSTR(tmpGroupID) ) = 0 Then tmpGroupPage = ""
	tmpIntroPage = FindFileName(Path + "Sections\Company\" & CompanyID & "\", tmpIntroPage, tmpGroupID, tmpLevel, ".htm", Language)

	'Cache the member page, intro page
   tmpOptions = ":MP:" + tmpMemberPage + ":GP:" + tmpGroupPage + ":IP:" + tmpIntroPage + ":S:" + tmpSecure
   SetCache "MEMBEROPTIONS", tmpOptions
End Function

'********************************************************************************
Function FindFileName(Path, File, GroupID, Level, Ext, Language)
   On Error Resume Next
   If Not IsNumeric(Level) Then Level = "0"
	tmpLanguage = Language
   If tmpLanguage <> "" Then tmpLanguage = "[" + tmpLanguage + "]"

   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   Exists = False
   
	'Check for both GroupID and Membership Level
'	If GroupID <> 0 Then
'		tmpSpecial = CSTR(GroupID) & Int(Level)
'		tmpFile = Path + File & tmpSpecial & tmpLanguage + Ext
'		Exists = oFileSys.FileExists(tmpFile)
'	End If
   
	'If there is a Group, Check for Group 
	If GroupID <> 0 Then
		tmpSpecial = CSTR(GroupID)
		tmpFile = Path + File + tmpSpecial + tmpLanguage + Ext
		Exists = oFileSys.FileExists(tmpFile)
	End If

	'If no file found yet and the level is >= 0, Check for membership Level
	If Not Exists And Level >= 0 Then
		tmpSpecial = Int(Level)
		tmpFile = Path + File & tmpSpecial & tmpLanguage + Ext
		Exists = oFileSys.FileExists(tmpFile)
	End If
   
   'If we found the file, use it without the Path, Otherwise use the default filename
   If Exists Then
      tmpFile = File & tmpSpecial & Ext
   Else
      tmpFile = File + Ext
   End If
   
   Set oFileSys = Nothing
   FindFileName = tmpFile
End Function

'********************************************************************************
' Search for previously cached member page, training buddy image or page
' specify option code to fetch desired filename
' "MP" = Member Page, "TBP" = Training Buddy Page, "TBI" = Training Buddy Image
'********************************************************************************
Function GetMemberOptions(Opt)
   On Error Resume Next
   tmpOption = ""
   tmpOptions = GetCache("MEMBEROPTIONS")
   pos = InStr(tmpOptions, ":" + Opt + ":")
   If (pos > 0) Then
      pos = pos + Len(Opt) + 2
      pos2 = InStr(pos, tmpOptions, ":")
      If pos2 > 0 Then
         tmpOption = Mid(tmpOptions, pos, pos2 - pos)
      Else
         tmpOption = Mid(tmpOptions, pos)
      End If
   End If
   GetMemberOptions = tmpOption
End Function

'********************************************************************************
Function GetUserOptions(CompanyOptions, MemberOptions)
   On Error Resume Next
   
   'Look for member options to exclude ("A-BC")
   x = 1
   While x <> 0
      x = InStr(MemberOptions, "-")
      If x > 0 Then
         c = Mid(MemberOptions, x + 1, 1)
         CompanyOptions = Replace(CompanyOptions, c, "")
         MemberOptions = Replace(MemberOptions, "-" + c, "")
      End If
   Wend


   'return: Append remaining member options to company options
   GetUserOptions = CompanyOptions + MemberOptions
   
End Function

'********************************************************************************
Function GetEasyOptions(UserOptions, EasyOptions)
   On Error Resume Next

   tmpOptions = "*"   
   While EasyOptions <> ""
      c = Left(EasyOptions, 1)
	  If c = "~" Then
		tmpOptions = tmpOptions + Left(EasyOptions, 2)
		EasyOptions = Mid(EasyOptions, 3)
	  Else
		If InStr(UserOptions, c) > 0 Then  		
		   tmpOptions = tmpOptions + c
		End If
		EasyOptions = Mid(EasyOptions, 2)
	  End If
   Wend

   GetEasyOptions = tmpOptions

End Function


%>
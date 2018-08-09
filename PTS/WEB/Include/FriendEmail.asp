<!--#include file="Comm.asp"-->
<%
'***********************************************************************
Function EmailFriend( ByVal bvCompanyID, ByVal bvMemberID, ByVal bvFriendID, ByVal bvFirst, ByVal bvLast, ByVal bvEmail )
    On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(bvMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpSender = .Email
         tmpFrom = tmpSender
         tmpMemberFirst = .NameFirst
         tmpMemberLast = .NameLast
      End With
   End If
   Set oMember = Nothing

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "FriendEmail.htm"
         .Path = reqSysWebDirectory + "Sections\Company\" + CStr(bvCompanyID)
         .Language = reqSysLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpBody = .Data
      End With
   End If
   Set oHTMLFile = Nothing
   If (Len(tmpBody) > 10) Then

        tmpTo = bvEmail
        tmpSubject = tmpMemberFirst + " " + tmpMemberLast + " Has Invited You"
        If InStr(tmpTo, "@") > 0 Then
             If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
             tmpBody = Replace( tmpBody, "{id}", bvFriendID )
             tmpBody = Replace( tmpBody, "{cid}", bvCompanyID )
             tmpBody = Replace( tmpBody, "{firstname}", bvFirst )
             tmpBody = Replace( tmpBody, "{lastname}", bvLast )
             tmpBody = Replace( tmpBody, "{m-firstname}", tmpMemberFirst )
             tmpBody = Replace( tmpBody, "{m-lastname}", tmpMemberLast )
             
             SendEmail bvCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
        End If
   End If

End Function

%>


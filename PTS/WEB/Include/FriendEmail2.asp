<!--#include file="Comm.asp"-->
<%
'***********************************************************************
Function EmailFriend2( ByVal bvCompanyID, ByVal bvOption )
    On Error Resume Next

    Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
    If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
    Else
      With oHTMLFile
         .Filename = "FriendEmail.htm"
         .Path = "C:\PTS\WEB\Sections\Company\" + CStr(bvCompanyID)
         .Language = "en"
         .Project = "PTS"
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpMasterBody = .Data
         tmpMasterBody = Replace( tmpMasterBody, "{cid}", bvCompanyID )
      End With
    End If
    Set oHTMLFile = Nothing
    
    If (Len(tmpMasterBody) > 10) Then
        Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
        If oMembers Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
        Else
            With oMembers
                .SysCurrentLanguage = reqSysLanguage
                .CustomList bvCompanyID, bvOption, 0
cnt=1
                For Each oItem in oMembers
                    With oItem
                        tmpFriendID = .MemberID
                        aMember = Split(.Signature, "|")
                        tmpFirst = aMember(0)
                        tmpLast = aMember(1)
                        tmpEmail = aMember(2)
                        tmpMemberFirst = aMember(3)
                        tmpMemberLast = aMember(4)
                        tmpMemberEmail = aMember(5)
                    End With

                    tmpSender = tmpMemberEmail
                    tmpFrom = tmpSender

                    tmpTo = tmpEmail
                    tmpSubject = tmpMemberFirst + " " + tmpMemberLast + " Has Invited You"
                    If InStr(tmpTo, "@") > 0 Then
                        If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
                        tmpBody = Replace( tmpMasterBody, "{id}", tmpFriendID )
                        tmpBody = Replace( tmpBody, "{firstname}", tmpFirst )
                        tmpBody = Replace( tmpBody, "{lastname}", tmpLast )
                        tmpBody = Replace( tmpBody, "{m-firstname}", tmpMemberFirst )
                        tmpBody = Replace( tmpBody, "{m-lastname}", tmpMemberLast )

response.write "<BR>" + CStr(cnt) + " - " + tmpFirst + " " + tmpLast + " " + tmpEmail + " - " + tmpMemberFirst + " " + tmpMemberLast + " " + tmpMemberEmail

'                        SendEmail bvCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
                    End If
cnt = cnt + 1
                Next
            End With
        End If
        Set oMembers = Nothing
    End If

End Function

%>


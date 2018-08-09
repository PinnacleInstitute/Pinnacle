<!--#include file="Include\System.asp"-->
<%
On Error Resume Next

UserID = Numeric(Request.Item("A"))
MemberID = Numeric(Request.Item("M"))

If UserID = 0 And MemberID > 0 Then
    Set oMember = server.CreateObject("ptsMemberUser.CMember")
    If oMember Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
    Else
        With oMember
            .Load CLng(MemberID), 1
            If .AuthUserID > 0 Then UserID = CLng(.AuthUserID)
        End With
    End If
    Set oMember = Nothing
End If

If UserID > 0 Then
    Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
    If oAuthUser Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
    Else
        tmpUserCode = oAuthUser.GetUserCode( UserID * -1 )
    End If
    Set oAuthUser = Nothing

    Response.write "<BR>User Reset: " & UserID & " - " & tmpUserCode
End If

%>
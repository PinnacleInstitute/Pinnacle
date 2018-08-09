<!--#include file="Include\System.asp"-->
<!--#include file="Include\GCRWallet.asp"-->
<%
On Error Resume Next

UserGroup = Numeric(GetCache("USERGROUP"))
MemberID = Numeric(Request.Item("M"))

If MemberID <> 0 Then
    Set oMember = server.CreateObject("ptsMemberUser.CMember")
    If oMember Is Nothing Then
        response.Write "Unable to Create Object - ptsMemberUser.CMember"
    Else
        With oMember
            .Load MemberID, 1
            Address = ""
            Ballance = 0
            result = GCRWallet_Disable2FA( .Email ) 
            Response.write result
        End With
    End If
    Set oMember = Nothing
Else
	Response.write "ERROR: UserGroup: " & UserGroup
End If

%>
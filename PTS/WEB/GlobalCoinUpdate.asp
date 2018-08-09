<!--#include file="Include\Globalcoin.asp"-->
<%
On Error Resume Next

API_Secret = "5a643ea8dc6150a780c78338c1c55fc8"

MemberID = Request.Item("MemberID")
Username = Request.Item("User")
Password = Request.Item("Pswd")

If MemberID <> "0" Then
    Set oMember = server.CreateObject("ptsMemberUser.CMember")
    If oMember Is Nothing Then
        response.Write "Unable to Create Object - ptsMemberUser.CMember"
    Else
        With oMember
            .Load MemberID, 1
            Token = .Reference + .Referral
            SetGCSecret API_Secret
'            result = UpdateUser( MemberID, Token, Username, Password ) 
response.Write CSTR(MemberID) + " - " + Token + " - " + Username + " - " + Password
            Response.Write result
        End With
    End If
    Set oMember = Nothing
End If

%>
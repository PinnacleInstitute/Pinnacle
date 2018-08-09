<!--#include file="Include\GCRWallet.asp"-->
<!--#include file="Include\Note.asp"-->
<%
On Error Resume Next

MemberID = Request.Item("M")
If IsNumeric(MemberID) Then MemberID = CLng(MemberID) Else MemberID = CLng(0) 

If MemberID <> 0 Then
    Set oMember = server.CreateObject("ptsMemberUser.CMember")
    If oMember Is Nothing Then
        response.Write "Unable to Create Object - ptsMemberUser.CMember"
    Else
        With oMember
            .Load MemberID, 1
            Password = ""
            result = GCRWallet_Create( .Email, Password ) 
            If result = "ok" Then
                .Reference = Password
                .Save 1
            Else
				LogMemberNote MemberID, "Create Coin Wallet Error: " + result
            End If
            Response.write result
        End With
    End If
    Set oMember = Nothing
End If

%>
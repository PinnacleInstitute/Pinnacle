<!--#include file="Include\GCRWallet.asp"-->
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
            Address = ""
            Ballance = 0
            result = GCRWallet_Info( .Email, Address, Balance ) 
            If result = "ok" Then
                Response.write Address + " - " + CStr(Balance)
            Else
                Response.write result
            End If
        End With
    End If
    Set oMember = Nothing
End If

%>